# WISP Monitor Python Class

# Compatibility with Python 2.6
from __future__ import print_function

import serial
import math
import time
import re
import sys
import os
import errno
import select
import time
import json
import signal
from binascii import hexlify

from . import delayed_signals

SERIAL_PORT                         = '/dev/ttyUSB0'

EDB_INTERFACE_FILE = os.path.join(os.path.dirname(__file__), "edb.json")

REPORT_STREAM_PROGRESS_INTERVAL = 0.2 # sec

# Packet construction states
CONSTRUCT_STATE_IDENTIFIER          = 0x00
CONSTRUCT_STATE_DESCRIPTOR          = 0x01
CONSTRUCT_STATE_DATA_LEN            = 0x02
CONSTRUCT_STATE_DATA                = 0x03
CONSTRUCT_STATE_PADDING             = 0x04

def log_error(msg):
    sys.stderr.write(msg + "\n")

def key_lookup(d, value):
    for k in d:
        if d[k] == value:
            return k
    return None

def serialize_uint16(value):
    value = int(value)
    return [value & 0xFF, (value >> 8) & 0xFF]

def deserialize_uint16(bytes):
    value = (bytes[1] << 8) | bytes[0]
    return '%d' % value

def serialize_frac(value):
    value = float(value)
    denomenator = 10000
    numerator = int(value * denomenator)
    return [numerator & 0xFF, (numerator >> 8) & 0xFF,
            denomenator & 0xFF, (denomenator >> 8) & 0xFF]

def deserialize_frac(bytes):
    numerator = (bytes[1] << 8) | bytes[0]
    denomenator = (bytes[3] << 8) | bytes[2]
    return "%f" % (float(numerator) / denomenator)

edb_iface = json.load(open(EDB_INTERFACE_FILE, "r"))

# This is a cludge due to legacy, to avoid changing every access
class HeaderAdapter:
    def __init__(self, iface, name):
        self.enums = iface[name]["enums"]
        self.macros = iface[name]["macros"]

host_comm_header = HeaderAdapter(edb_iface, "host_comm_header")
target_comm_header = HeaderAdapter(edb_iface, "target_comm_header")
config_header = HeaderAdapter(edb_iface, "config_header")
clock_config_header = HeaderAdapter(edb_iface, "clock_config_header")

COMPARATOR_REF_VOLTAGE = edb_iface["COMPARATOR_REF_VOLTAGE"]
VDD = edb_iface["VDD"]

class StreamInterrupted(Exception):
    pass

class InterruptContext:
    def __init__(self, type, id, saved_vcap=None):
        self.type = type
        self.id = id
        self.saved_vcap = saved_vcap

class WatchpointEvent:
    def __init__(self, id, vcap):
        self.id = id
        self.vcap = vcap

class StdIOData:
    def __init__(self, timestamp, string):
        self.timestamp = timestamp
        self.string = string

class EnergyProfile:
    # TODO: structured representation of the profile
    def __init__(self, timestamp, profile):
        self.timestamp = timestamp
        self.profile = profile

class StreamDataPoint:
    def __init__(self, timestamp_cycles, value_set):
        self.timestamp_cycles = timestamp_cycles
        self.value_set = value_set 

class StreamDecodeException(Exception):
    def __init__(self, msg=""):
        self.message = msg

class PacketParseException(Exception):
    def __init__(self, msg=""):
        self.message = msg

class UIntValue:
    """An value of type unsigned int representable on the remote side (EDB)"""
    def __init__(self, value):
        self.value = value

    def from_string(s):
        return UIntValue(int(s))

    def __repr__(self):
        return repr(self.value)

    def to_edb_repr(self):
        return self.value

    def from_edb_repr(val):
        return UIntValue(self.value)

    def serialize(self, edb):
        return serialize_uint16(self.to_edb_repr())
    def deserialize(data, edb):
        return UIntValue.from_edb_repr(deserialize_uint16(data))

class VoltageValue:
    """An voltage representable on the remote side (EDB)"""

    def __init__(self, voltage_v, edb_repr=None):
        self.voltage_v = voltage_v
        self.edb_repr = edb_repr

    def from_string(s):
        voltage_re = r'(?P<value>[0-9.]+)(?P<mult>m?)(?P<unit>(v|V))?'
        m = re.match(voltage_re, s)
        if not m:
            raise Exception("Failed to parse voltage value '" + str(s) + "': " +
                            "expecting match to regexp '" + voltage_re + "'")

        voltage_v = float(m.group('value'))
        mult = m.group('mult')
        if mult == "m":
            voltage_v /= 1000

        return VoltageValue(voltage_v)

    def __repr__(self):
        return repr(self.voltage_v) + "V"

    def to_edb_repr(self, edb):
        if self.edb_repr is not None:
            return self.edb_repr
        return edb.voltage_to_adc(self.voltage_v)

    def from_edb_repr(edb, val):
        return VoltageValue(edb.adc_to_voltage(val), edb_repr=val)

    def serialize(self, edb):
        return serialize_uint16(self.to_edb_repr(edb))
    def deserialize(edb, data):
        return VoltageValue.from_edb_repr(edb, deserialize_uint16(data))

class TimeValue:
    """An abstract base for time value representable on the remote side (EDB)"""

    def __init__(self, time_s):
        self.time_s = time_s

    def parse(s):

        voltage_re = r'(?P<value>[0-9.]+)(?P<mult>m?)(?P<unit>(s|sec|S))?'
        m = re.match(voltage_re, s)
        if not m:
            raise Exception("Failed to parse voltage value '" + str(s) + "': " +
                            "expecting match to regexp '" + voltage_re + "'")

        time_s = float(m.group('value'))
        mult = m.group('mult')
        if mult == "m":
            time_s /= 1000
        elif mult == "u":
            time_s /= 1000000

        return time_s

    def __repr__(self):
        return repr(self.time_s) + "s"

class McuKCyclesTimeValue(TimeValue):
    """A time value represented on the remote side (EDB) in MCU clock cycles"""

    def __init__(self, time_s, edb_repr=None):
        TimeValue.__init__(self, time_s)

        self.edb_repr = edb_repr

    def from_string(s):
        return McuKCyclesTimeValue(TimeValue.parse(s))

    def to_edb_repr(self, edb):
        if self.edb_repr is not None:
            return self.edb_repr
        return edb.sec_to_mcu_cycles(self.time_s) / 1000

    def from_edb_repr(edb, val):
        return McuKCyclesTimeValue(edb.mcu_cycles_to_sec(val * 1000), edb_repr=val)

    def serialize(self, edb):
        return serialize_uint16(self.to_edb_repr(edb))
    def deserialize(edb, data):
        return McuKCyclesTimeValue.from_edb_repr(edb, deserialize_uint16(data))

class Param:
    def __init__(self, key, type):
        self.key = key
        self.type = type

class EDB:
    VDD                                 = VDD # V
    CMP_VREF                            = 2.5
    CMP_BITS                            = 5

    def __init__(self, device, uart_log_fname=None):
        self.uart_log = open(uart_log_fname, "wb") if uart_log_fname else None
        self.rxPkt = RxPkt()

        baudrate = config_header.macros['CONFIG_USB_UART_BAUDRATE']
        self.serial = serial.Serial(port=device, baudrate=baudrate, timeout=1)

        self.serial.close()
        self.serial.open()

        self.rcv_buf = bytearray()
        self.stream_bytes = 0

        self.stream_decoders = {
                "VCAP": self.decode_adc_value,
                "VBOOST": self.decode_adc_value,
                "VREG": self.decode_adc_value,
                "VRECT": self.decode_adc_value,
                "VINJ": self.decode_adc_value,
                "RF_EVENTS": self.decode_rf_event,
                "WATCHPOINTS": self.decode_watchpoint_event,
        }

        self.remote_params = {
                "TEST": Param("PARAM_TEST", UIntValue),
                "TARGET_BOOT_VOLTAGE" : Param("TARGET_BOOT_VOLTAGE_DL", VoltageValue),
                "TARGET_BOOT_LATENCY" : Param("TARGET_BOOT_LATENCY_KCYCLES", McuKCyclesTimeValue),
                "NUM_WATCHPOINT_EVENTS_BUFFERED" : Param("NUM_WATCHPOINT_EVENTS_BUFFERED", UIntValue),
        }

        def clk_source_freq(source):
            # Cutting corners a bit: assume that ACLK is sourced either from XT1 or REFO
            if source == 'ACLK' or re.match(r'T.SSEL__ACLK', source):
                assert clock_config_header.macros['CONFIG_XT1_FREQ'] == clock_config_header.macros['CONFIG_REFO_FREQ']
                return clock_config_header.macros['CONFIG_XT1_FREQ']
            elif source == 'SMCLK' or re.match(r'T.SSEL__SMCLK', source):
                return clock_config_header.macros['CONFIG_DCOCLKDIV_FREQ'] / \
                       clock_config_header.macros['CONFIG_CLK_DIV_SMCLK']
            elif source == 'MCLK':
                return clock_config_header.macros['CONFIG_DCOCLKDIV_FREQ']
            else:
                raise Exception("Not implemented")

        def clk_source(source_macro_prefix):
            for source in ['ACLK', 'SMCLK', 'MCLK']:
                if config_header.macros[source_macro_prefix + source]:
                    return source
            raise Exception("Could not find a defined clk source macro for: " + source_macro_prefix)

        self.MCU_CLK_FREQ = clk_source_freq('MCLK')

        self.TIMELOG_CLK_FREQ = clk_source_freq(config_header.macros['CONFIG_TIMELOG_TIMER_SOURCE']) / \
                (config_header.macros['CONFIG_TIMELOG_TIMER_DIV'] * \
                config_header.macros['CONFIG_TIMELOG_TIMER_DIV_EX'])
        self.TIMELOG_PERIOD = 1.0 / self.TIMELOG_CLK_FREQ # seconds

        adc_trigger_timer_clk_source = clk_source('CONFIG_ADC_TIMER_SOURCE_')
        self.ADC_TRIGGER_TIMER_CLK_FREQ = \
                float(clk_source_freq(adc_trigger_timer_clk_source)) / \
                config_header.macros['CONFIG_ADC_TIMER_DIV']

        self.params = {
            'adc_sampling_freq_hz' : 1000
        }

        self.replay_log = None
        self.rcv_no_parse = None
        
    def destroy(self):
        self.serial.close()

    def get_local_params(self):
        return self.params

    def get_local_param(self, param):
        return self.params[param]

    def set_local_param(self, param, value):
        self.params[param] = value
        return value

    def get_remote_param_type(self, param):
        return self.remote_params[param.upper()].type

    def set_remote_param(self, param, value):
        param = param.upper()
        param_def = self.remote_params[param]

        if not isinstance(value, param_def.type):
            raise Exception("Type mismatch for param '" + param + "': " + \
                    str(type(value)) + " (expecting " + str(param_def.type) + ")")

        param_id = host_comm_header.enums['PARAM'][param_def.key]
        cmd_data = [param_id & 0xff, (param_id>> 8) & 0xff] + value.serialize(self)
        self.sendCmd(host_comm_header.enums['USB_CMD']['SET_PARAM'], data=cmd_data)
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['RETURN_CODE'])
        return reply["code"]

    def get_remote_param(self, param):
        param = param.upper()
        param_def = self.remote_params[param]
        param_id = host_comm_header.enums['PARAM'][param_def.key]
        cmd_data = [param_id & 0xff, (param_id>> 8) & 0xff]
        self.sendCmd(host_comm_header.enums['USB_CMD']['GET_PARAM'], data=cmd_data)
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['PARAM'])
        return param_def.type.deserialize(self, reply["value"])
    
    def buildRxPkt(self, buf):
        """Parses packet header and returns whether it is ready or not"""

        minBufLen = len(buf)
        while minBufLen > 0:
            if(self.rxPkt.constructState == CONSTRUCT_STATE_IDENTIFIER):
                self.rxPkt.identifier = buf.pop(0) # get the identifier byte
                minBufLen -= 1
                
                if(self.rxPkt.identifier != host_comm_header.macros['UART_IDENTIFIER_USB']):
                    # unknown identifier - reset state
                    self.rxPkt.constructState = CONSTRUCT_STATE_IDENTIFIER
                    log_error("packet construction failed: unknown identifier: " + \
                              "0x%02x (exp 0x%02x)" % (self.rxPkt.identifier, \
                              host_comm_header.macros['UART_IDENTIFIER_USB']))
                    continue
                self.rxPkt.constructState = CONSTRUCT_STATE_DESCRIPTOR
            elif(self.rxPkt.constructState == CONSTRUCT_STATE_DESCRIPTOR):
                self.rxPkt.descriptor = buf.pop(0) # get descriptor byte
                minBufLen -= 1
                self.rxPkt.constructState = CONSTRUCT_STATE_DATA_LEN
                continue
            elif(self.rxPkt.constructState == CONSTRUCT_STATE_DATA_LEN):
                self.rxPkt.length = buf.pop(0) # get data length
                minBufLen -= 1
                self.rxPkt.constructState = CONSTRUCT_STATE_PADDING
                continue
            elif(self.rxPkt.constructState == CONSTRUCT_STATE_PADDING):
                buf.pop(0) # padding
                minBufLen -= 1 # padding
                self.rxPkt.constructState = CONSTRUCT_STATE_DATA
                continue
            elif(self.rxPkt.constructState == CONSTRUCT_STATE_DATA):
                if(minBufLen >= self.rxPkt.length):
                    # copy the data
                    self.rxPkt.data = buf[0:self.rxPkt.length]
                    del buf[:self.rxPkt.length]
                    self.rxPkt.constructState = CONSTRUCT_STATE_IDENTIFIER
                    return True # packet construction succeeded
                else:
                    return False # not enough data
            else:
                # unknown state - reset packet construction state
                self.rxPkt.constructState = CONSTRUCT_STATE_IDENTIFIER
                raise Exception("packet construction failed")
        
        # ran out of data
        return False # packet construction will resume next time this function is called
    
    # Note that when sending data, the byte order is reversed.
    # Example: to send a command to set Vcap to 2.2 V, do the following.
    #               descriptor = host_comm_header.enums['USB_CMD']['SET_VCAP']
    #               adc = 2.2 * 2^12 / VDD = 2.2 * 4096 / 3.35 = 2689.91
    #               data = byteReverse(round(adc)) = byteReverse(2690)
    #                    = byteReverse(0x0A82)
    #                    = bytearray([0x82, 0x0A])
    def sendCmd(self, descriptor, data=[]):
        serialMsg = bytearray([host_comm_header.macros['UART_IDENTIFIER_USB'], descriptor])
        serialMsg += bytearray([len(data), 0]) + bytearray(data) # zero is padding
        self.serial.write(serialMsg)

    def receive(self):
        if not self.rcv_no_parse and self.buildRxPkt(self.rcv_buf):
            pkt = { "descriptor" : self.rxPkt.descriptor }

            # TODO: add error handling for all descriptors

            if self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['RETURN_CODE']:
                pkt["code"] = self.rxPkt.data[0]

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['TIME']:
                cycles = (self.rxPkt.data[3] << 24) | (self.rxPkt.data[2] << 16) | \
                         (self.rxPkt.data[1] <<  8) | (self.rxPkt.data[0])
                pkt["time_sec"] = float(cycles) * self.TIMELOG_PERIOD

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['VOLTAGE']:
                adc_reading = (self.rxPkt.data[1] << 8) | self.rxPkt.data[0]
                pkt["voltage"] = self.adc_to_voltage(adc_reading)

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['VOLTAGES']:
                offset = 0
                num_channels = self.rxPkt.data[offset]
                offset += 1
                pkt["voltages"] = []
                for i in range(num_channels):
                    adc_reading = (self.rxPkt.data[offset + 2 * i + 1] << 8) | \
                                   self.rxPkt.data[offset + 2 * i]
                    pkt["voltages"].append(self.adc_to_voltage(adc_reading))

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['INTERRUPTED']:
                pkt["interrupt_type"] = key_lookup(target_comm_header.enums['INTERRUPT_TYPE'], self.rxPkt.data[0])
                pkt["interrupt_id"] = (self.rxPkt.data[2] << 8) | self.rxPkt.data[1]
                saved_vcap_adc_reading = (self.rxPkt.data[4] << 8) | self.rxPkt.data[3]
                pkt["saved_vcap"] = self.adc_to_voltage(saved_vcap_adc_reading)

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['WATCHPOINT']:
                pkt["id"] = (self.rxPkt.data[1] << 8) | self.rxPkt.data[0]
                pkt["timestamp"] = (self.rxPkt.data[3] << 8) | self.rxPkt.data[2]
                vcap_adc_reading = (self.rxPkt.data[5] << 8) | self.rxPkt.data[4]
                pkt["vcap"] = self.adc_to_voltage(vcap_adc_reading)

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['STDIO']:
                pkt["string"] = bytearray(self.rxPkt.data).decode('ascii', errors='backslashreplace')

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['ENERGY_PROFILE']:
                pkt["profile"] = " ".join(["0x%x" % b for b in bytearray(self.rxPkt.data)])

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['WISP_MEMORY']:
                pkt["address"] = (self.rxPkt.data[3] << 24) | (self.rxPkt.data[2] << 16) | \
                                 (self.rxPkt.data[1] <<  8) | (self.rxPkt.data[0] <<  0)
                pkt["value"] = self.rxPkt.data[4:]

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['ADDRESS']:
                pkt["address"] = (self.rxPkt.data[3] << 24) | (self.rxPkt.data[2] << 16) | \
                                 (self.rxPkt.data[1] <<  8) | (self.rxPkt.data[0] <<  0)

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['ECHO']:
                pkt["value"] = self.rxPkt.data[0]

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['PARAM']:
                offset = 0
                param_id = (self.rxPkt.data[1] << 8) | self.rxPkt.data[0]
                offset += 2
                pkt["param"] = key_lookup(host_comm_header.enums['PARAM'], param_id)
                pkt["value"] = self.rxPkt.data[offset:]

            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['STREAM_EVENTS']:
                FIELD_LEN_STREAMS = 1
                FIELD_LEN_TIMESTAMP = 4

                offset = 0

                data_points = []

                if offset + FIELD_LEN_STREAMS <= len(self.rxPkt.data):

                    pkt_streams = self.rxPkt.data[offset]
                    #print "pkt_streams=0x%08x" % pkt_streams
                    offset += 1

                    # padding
                    offset += 1

                    while offset < len(self.rxPkt.data):
                        # invalid pkt, but best we can do here is not fail
                        if offset + FIELD_LEN_TIMESTAMP > len(self.rxPkt.data):
                            log_error("WARNING: corrupt STREAM_DATA pkt: timestamp field")
                            break

                        timestamp_cycles = (self.rxPkt.data[offset + 3] << 24) | \
                                           (self.rxPkt.data[offset + 2] << 16) | \
                                           (self.rxPkt.data[offset + 1] <<  8) | \
                                           (self.rxPkt.data[offset + 0] <<  0);
                        offset += FIELD_LEN_TIMESTAMP

                        try:
                            # Decode the pkt into a dictionary: stream->value.
                            # Order is implied by the bit index of each stream as defined by the enum
                            value_set = {}
                            for stream in host_comm_header.enums['STREAM']:
                                if pkt_streams & host_comm_header.enums['STREAM'][stream]:
                                    value, length = self.stream_decoders[stream](self.rxPkt.data, offset)
                                    offset += length
                                    value_set[stream] = value

                            data_points.append(StreamDataPoint(timestamp_cycles, value_set))
                        except StreamDecodeException as e:
                            # invalid pkt, best we can do here is not fail
                            log_error("WARNING: corrupt STREAM_DATA pkt: value field: %s" % \
                                    e.message)
                            break
                else:
                    # invalid pkt, best we can do here is not fail
                    log_error("WARNING: corrupt STREAM_DATA pkt: streams field")

                pkt["data_points"] = data_points

            # The voltage stream packet has to be forked because we are forced to layout
            # the buffer with timestamps grouped together folled by voltage samples
            # grouped together for efficiency reasons (DMA).
            elif self.rxPkt.descriptor == host_comm_header.enums['USB_RSP']['STREAM_VOLTAGES']:
                FIELD_LEN_STREAMS = 1
                FIELD_LEN_SAMPLE_COUNT = 1
                FIELD_LEN_TIMESTAMP = 4
                FIELD_LEN_VOLTAGE = 2

                offset = 0

                data_points = []

                try:
                    if offset + FIELD_LEN_STREAMS + FIELD_LEN_SAMPLE_COUNT > len(self.rxPkt.data):
                        raise PacketParseException("header")

                    pkt_streams = self.rxPkt.data[offset]
                    #print "pkt_streams=0x%08x" % pkt_streams
                    offset += 1

                    num_samples = self.rxPkt.data[offset]
                    offset += 1

                    timestamp_offset = offset
                    voltage_offset = offset + num_samples * FIELD_LEN_TIMESTAMP

                    if timestamp_offset + num_samples * FIELD_LEN_TIMESTAMP > len(self.rxPkt.data):
                        raise PacketParseException("timestamps section")

                    if voltage_offset + num_samples * FIELD_LEN_VOLTAGE > len(self.rxPkt.data):
                        raise PacketParseException("voltages section")

                    for sample_i in range(num_samples):

                        timestamp_cycles = (self.rxPkt.data[timestamp_offset + 3] << 24) | \
                                           (self.rxPkt.data[timestamp_offset + 2] << 16) | \
                                           (self.rxPkt.data[timestamp_offset + 1] <<  8) | \
                                           (self.rxPkt.data[timestamp_offset + 0] <<  0);
                        timestamp_offset += FIELD_LEN_TIMESTAMP

                        # Decode the pkt into a dictionary: stream->value.
                        # Order is implied by the bit index of each stream as defined by the enum
                        value_set = {}
                        for stream in host_comm_header.enums['STREAM']:
                            if pkt_streams & host_comm_header.enums['STREAM'][stream]:
                                value, length = self.stream_decoders[stream](self.rxPkt.data,
                                                                             voltage_offset)
                                voltage_offset += length
                                value_set[stream] = value

                        data_points.append(StreamDataPoint(timestamp_cycles, value_set))

                except StreamDecodeException as e:
                    # invalid pkt, best we can do here is not fail
                    log_error("StreamDecodeException: %s" % e.message)

                except PacketParseException as e:
                    log_error("PacketParseException: %s" % e.message)

                pkt["data_points"] = data_points


            return pkt


        if self.replay_log is not None:
            newData = self.replay_log.read(1)
        else:
            newData = self.serial.read()

        if self.rcv_no_parse: # debugging gimmick
            self.rcv_no_parse_total_bytes += len(newData)
            print("\r%d" % self.rcv_no_parse_total_bytes, end='')
            return None

        if len(newData) > 0:
            newBytes = bytearray(newData)
            if self.uart_log:
                self.uart_log.write(newBytes)
                self.uart_log.flush()
            self.rcv_buf.extend(newBytes)
            self.stream_bytes += len(newData)
        return None

    def receive_reply(self, descriptors, timeout=None):
        # Be compatible with legacy code
        if not hasattr(descriptors, "__iter__"):
            descriptors = [descriptors]
        reply = None
        start_time = time.time()
        while reply is None:
            while reply is None and (timeout is None or time.time() - start_time < timeout):
                reply = self.receive()
            if reply is None: # timed out
                return None
            reply_descriptor = reply["descriptor"]
            if reply_descriptor not in descriptors:
                log_error("unexpected reply: 0x%02x (exp [%s])" % \
                        (reply["descriptor"], ",".join(map(lambda d: "0x%02x" % d, descriptors))))
                reply = None
                continue
        if reply_descriptor == host_comm_header.enums['USB_RSP']['RETURN_CODE']: # this one is generic, so handle it here
            if reply["code"] != 0:
                raise Exception("Command failed: return code " + ("0x%02x" % reply["code"]))
        return reply

    def flush(self):
        while len(self.serial.read()) > 0:
            pass
        self.rcv_buf = []

    def load_replay_log(self, file):
        self.replay_log = open(file, "r")

    def uint16_to_bytes(self, val):
        return [val & 0xFF, (val>> 8) & 0xFF]

    def bytes_to_uint16(self, bytes):
        return (bytes[1] << 8) | bytes[0]

    def uint32_to_bytes(self, val):
        return [val & 0xFF, (val>> 8) & 0xFF, (val >> 16) & 0xFF, (val >> 24) & 0xFF]

    def bytes_to_uint32(self, bytes):
        return (bytes[3] << 24) | (bytes[2] << 16) | (bytes[1] << 8) | (bytes[0] << 0)

    def voltage_to_adc(self, voltage):
        return int(math.ceil(voltage * 4096 / self.VDD))

    def adc_to_voltage(self, value):
        return float(value) / 4096 * self.VDD

    def cmp_ref_for_v(self, voltage):
        if voltage > 2.5:
            ref = "VCC"
        elif voltage > 2.0:
            ref = "VREF_2_5"
        elif voltage > 1.5:
            ref = "VREF_2_0"
        else:
            ref = "VREF_1_5"
        return ref

    def voltage_to_cmp(self, voltage):
        ref = self.cmp_ref_for_v(voltage)
        return int(voltage / (COMPARATOR_REF_VOLTAGE[ref] / 2**self.CMP_BITS)) - 1, ref

    def cmp_to_voltage(self, value, ref):
        return (float(value) + 1) * (COMPARATOR_REF_VOLTAGE[ref] / 2**CMP_BITS)

    def sec_to_mcu_cycles(time_ms):
        return int(self.MCU_CLK_FREQ * (time_ms / 1000))

    def mcu_cycles_to_sec(self, cycles):
        return float(cycles) / self.MCU_CLK_FREQ

    def decode_adc_value(self, bytes, offset):
        FIELD_LEN = 2
        if offset + FIELD_LEN > len(bytes):
            raise StreamDecodeException("buf (offset = " + str(offset) + "): " + \
                    str(hexlify(bytearray(bytes))))
        adc_value = (bytes[offset + 1] << 8) | (bytes[offset] << 0)
        length = 2
        voltage = self.adc_to_voltage(adc_value)
        return voltage, length

    def decode_rf_event(self, bytes, offset):
        FIELD_LEN = 2
        if offset + FIELD_LEN > len(bytes):
            raise StreamDecodeException("not enough bytes")
        rf_event_id = (bytes[offset + 1] << 8) | (bytes[offset] << 0)
        #print "rf_event_id = 0x%08x" % rf_event_id
        rf_event = key_lookup(host_comm_header.enums['RF_EVENT'], rf_event_id)
        if rf_event is None:
            raise StreamDecodeException("invalid event id: " + "0x%04x" % rf_event_id)
        length = 2 # sizeof(rf_event_t.id field + padding in the struct)
        return rf_event, length

    def decode_watchpoint_event(self, bytes, offset):
        DATA_LEN = 2 + 2 # id, adc value
        starting_offset = offset 
        if offset + DATA_LEN > len(bytes):
            raise StreamDecodeException("not enough bytes")
        id = (bytes[offset + 1] << 8) | (bytes[offset] << 0)
        offset += 2
        adc_value = (bytes[offset + 1] << 8) | (bytes[offset] << 0)
        offset += 2
        voltage = self.adc_to_voltage(adc_value)
        return WatchpointEvent(id, voltage), offset - starting_offset

    def get_adc_channels():
        return host_comm_header.enums['ADC_CHAN_INDEX']

    def sense(self, channel):
        channel_idx = host_comm_header.enums['ADC_CHAN_INDEX'][channel]
        self.sendCmd(host_comm_header.enums['USB_CMD']['SENSE'], data=[channel_idx])
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['VOLTAGE'])
        return reply["voltage"]

    def stream_begin(self, streams_bitmask):
        adc_sampling_period_cycles = \
                int((1.0 / float(self.params['adc_sampling_freq_hz'])) * self.ADC_TRIGGER_TIMER_CLK_FREQ)
        print("adc_sampling_period_cycles=%r" % adc_sampling_period_cycles)
        self.stream_bytes = 0
        self.stream_start = time.time()
        self.sendCmd(host_comm_header.enums['USB_CMD']['STREAM_BEGIN'],
                     data=[streams_bitmask] + \
                          self.uint16_to_bytes(adc_sampling_period_cycles))

    def stream_end(self, streams_bitmask):
        self.sendCmd(host_comm_header.enums['USB_CMD']['STREAM_END'], data=[streams_bitmask])

    def stream_datarate_kbps(self):
        return float(self.stream_bytes) / 1000 / (time.time() - self.stream_start)

    def charge(self, target_voltage):
        target_voltage_adc = self.voltage_to_adc(target_voltage)
        cmd_data = self.uint16_to_bytes(target_voltage_adc)
        self.sendCmd(host_comm_header.enums['USB_CMD']['CHARGE'], data=cmd_data)
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['VOLTAGE'])
        return reply["voltage"]

    def discharge(self, target_voltage):
        target_voltage_adc = self.voltage_to_adc(target_voltage)
        cmd_data = self.uint16_to_bytes(target_voltage_adc)
        self.sendCmd(host_comm_header.enums['USB_CMD']['DISCHARGE'], data=cmd_data)
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['VOLTAGE'])
        return reply["voltage"]

    def charge_cmp(self, target_voltage):
        target_voltage_cmp, ref = self.voltage_to_cmp(target_voltage)
        cmd_data = self.uint16_to_bytes(target_voltage_cmp) + [host_comm_header.enums['CMP_REF'][ref]]
        self.sendCmd(host_comm_header.enums['USB_CMD']['CHARGE_CMP'], data=cmd_data)
        self.receive_reply(host_comm_header.enums['USB_RSP']['RETURN_CODE'])

    def discharge_cmp(self, target_voltage):
        target_voltage_cmp, ref = self.voltage_to_cmp(target_voltage)
        cmd_data = self.uint16_to_bytes(target_voltage_cmp) + [host_comm_header.enums['CMP_REF'][ref]]
        self.sendCmd(host_comm_header.enums['USB_CMD']['DISCHARGE_CMP'], data=cmd_data)
        self.receive_reply(host_comm_header.enums['USB_RSP']['RETURN_CODE'])

    def enter_debug_mode(self):
        self.sendCmd(host_comm_header.enums['USB_CMD']['ENTER_ACTIVE_DEBUG'])
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['INTERRUPTED'])
        return reply["saved_vcap"]

    def exit_debug_mode(self):
        self.sendCmd(host_comm_header.enums['USB_CMD']['EXIT_ACTIVE_DEBUG'])
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['VOLTAGE'])
        return reply["voltage"]

    def interrupt(self):
        """Interrupt target and enter interractive debug shell

           The interrupt command first waits for target regulated voltage
           (Vreg) to rise to a specified threshold (param target_boot_voltage),
           and then waits for a fixed interval (param target_boot_latency) for
           the MCU to boot and start listening for EDB signals.
        """
        self.sendCmd(host_comm_header.enums['USB_CMD']['INTERRUPT'])
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['INTERRUPTED'])
        return reply["saved_vcap"]

    def break_at_vcap_level(self, level, impl):
        extra_args = []
        if impl == "ADC":
            level = self.voltage_to_adc(level)
        elif impl == "CMP":
            level, ref = self.voltage_to_cmp(level)
            extra_args += [host_comm_header.enums['CMP_REF'][ref]]
        else:
            raise Exception("Invalid energy breakpoint implementation method: " + impl)
        cmd_data = self.uint16_to_bytes(level) + [host_comm_header.enums['ENERGY_BREAKPOINT_IMPL'][impl]] + extra_args
        self.sendCmd(host_comm_header.enums['USB_CMD']['BREAK_AT_VCAP_LEVEL'], data=cmd_data)
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['INTERRUPTED'])
        return reply["saved_vcap"]

    def get_breakpoint_types():
        return host_comm_header.enums['BREAKPOINT_TYPE']

    def toggle_breakpoint(self, type, idx, enable, energy_level=None):

        if energy_level is not None:
            energy_level_cmp, cmp_ref = self.voltage_to_cmp(energy_level)
        else:
            energy_level_cmp, cmp_ref = 0, "VCC"

        self.sendCmd(host_comm_header.enums['USB_CMD']['BREAKPOINT'],
                     data=[host_comm_header.enums['BREAKPOINT_TYPE'][type], idx] + \
                           self.uint16_to_bytes(energy_level_cmp) + \
                           [host_comm_header.enums['CMP_REF'][cmp_ref], enable])
        self.receive_reply(host_comm_header.enums['USB_RSP']['RETURN_CODE'])

    def toggle_watchpoint(self, idx, enable, vcap_snapshot):
        cmd_data = [idx, (enable << 0) | (vcap_snapshot << 1)]
        self.sendCmd(host_comm_header.enums['USB_CMD']['WATCHPOINT'],
                     data=cmd_data)
        self.receive_reply(host_comm_header.enums['USB_RSP']['RETURN_CODE'])

    def wait(self):
        pkt = self.receive_reply([
            host_comm_header.enums['USB_RSP']['INTERRUPTED'],
            host_comm_header.enums['USB_RSP']['WATCHPOINT'],
            host_comm_header.enums['USB_RSP']['STDIO'],
            host_comm_header.enums['USB_RSP']['ENERGY_PROFILE']
        ])
        desc = pkt["descriptor"]
        if desc == host_comm_header.enums['USB_RSP']['INTERRUPTED']:
            return InterruptContext(pkt["interrupt_type"], pkt["interrupt_id"], pkt["saved_vcap"])
        elif desc == host_comm_header.enums['USB_RSP']['STDIO']:
            return StdIOData(time.time(), pkt["string"])
        elif desc == host_comm_header.enums['USB_RSP']['ENERGY_PROFILE']:
            return EnergyProfile(time.time(), pkt["profile"])
        else:
            raise Exception("Unexpected pkt: " + "0x%08x" % pkt["descriptor"])

    def get_interrupt_sources():
        return host_comm_header.enums['INTERRUPT_SOURCE']

    def get_interrupt_context(self, source):
        self.sendCmd(host_comm_header.enums['USB_CMD']['GET_INTERRUPT_CONTEXT'], data=[host_comm_header.enums['INTERRUPT_SOURCE'][source]])
        pkt = self.receive_reply(host_comm_header.enums['USB_RSP']['INTERRUPTED'])
        return InterruptContext(pkt["interrupt_type"], pkt["interrupt_id"], pkt["saved_vcap"])

    def read_mem(self, addr, len):
        cmd_data = self.uint32_to_bytes(addr) + [len]
        self.sendCmd(host_comm_header.enums['USB_CMD']['READ_MEM'], data=cmd_data)
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['WISP_MEMORY'])
        return reply["address"], reply["value"]

    def write_mem(self, addr, value):
        cmd_data = self.uint32_to_bytes(addr) + [len(value)] + value
        self.sendCmd(host_comm_header.enums['USB_CMD']['WRITE_MEM'], data=cmd_data)
        self.receive_reply(host_comm_header.enums['USB_RSP']['RETURN_CODE'])

    def get_pc(self):
        self.sendCmd(host_comm_header.enums['USB_CMD']['GET_WISP_PC'])
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['ADDRESS'])
        return reply["address"]

    def reset_debug_mode_state(self):
        self.sendCmd(host_comm_header.enums['USB_CMD']['RESET_STATE'])
        self.receive_reply(host_comm_header.enums['USB_RSP']['RETURN_CODE'])

    def cont_power(self, on):
        cmd_data = [on]
        self.sendCmd(host_comm_header.enums['USB_CMD']['CONT_POWER'], data=cmd_data)
        self.receive_reply(host_comm_header.enums['USB_RSP']['RETURN_CODE'])

    def serial_echo(self, value):
        cmd_data = [value]
        self.sendCmd(host_comm_header.enums['USB_CMD']['SERIAL_ECHO'], data=cmd_data)
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['ECHO'])
        return reply["value"]

    def dma_echo(self, value):
        cmd_data = [value]
        self.sendCmd(host_comm_header.enums['USB_CMD']['DMA_ECHO'], data=cmd_data)
        reply = self.receive_reply(host_comm_header.enums['USB_RSP']['ECHO'])
        return reply["value"]

    def enable_target_uart(self, enable):
        cmd_data = [enable]
        self.sendCmd(host_comm_header.enums['USB_CMD']['ENABLE_TARGET_UART'], data=cmd_data)
        self.receive_reply(host_comm_header.enums['USB_RSP']['RETURN_CODE'])

    def enable_periodic_payload(self, enable):
        cmd_data = [enable]
        self.sendCmd(host_comm_header.enums['USB_CMD']['PERIODIC_PAYLOAD'], data=cmd_data)
        self.receive_reply(host_comm_header.enums['USB_RSP']['RETURN_CODE'])

    def get_streams():
        return host_comm_header.enums['STREAM']

    def stream(self, streams, duration_sec=None, out_file=None, silent=True, no_parse=False,
               stop_at_watchpoint=None):
        self.rcv_no_parse = no_parse
        self.rcv_no_parse_total_bytes = 0

        streams_bitmask = 0x0
        for stream in streams:
            streams_bitmask |= host_comm_header.enums['STREAM'][stream]

        streaming = True
        self.stream_begin(streams_bitmask)

        if not silent:
            print("Logging... Ctrl-C to stop")

        overflow_timestamp_cycles = {
            host_comm_header.enums['USB_RSP']['STREAM_EVENTS']: 0,
            host_comm_header.enums['USB_RSP']['STREAM_VOLTAGES']: 0
        }

        prev_timestamp_cycles = {
            host_comm_header.enums['USB_RSP']['STREAM_EVENTS']: 0,
            host_comm_header.enums['USB_RSP']['STREAM_VOLTAGES']: 0
        }

        num_samples = 0
        last_progress_report = time.time()

        def format_voltage_header(stream):
            return stream
        def format_voltage(voltage):
            return "%f" % voltage
        def format_rf_event_header(stream):
            return "rf_event"
        def format_rf_event(rf_event):
            return rf_event # a string
        def format_watchpoint_event_header(stream):
            return "watchpoint_id,watchpoint_vcap"
        def format_watchpoint_event(event):
            return "%u,%.4f" % (event.id, event.vcap)

        stream_formaters = {
            "VCAP": format_voltage,
            "VBOOST": format_voltage,
            "VREG": format_voltage,
            "VRECT": format_voltage,
            "VINJ": format_voltage,
            "RF_EVENTS": format_rf_event,
            "WATCHPOINTS": format_watchpoint_event,
        }
        stream_headers = {
            "VCAP": format_voltage_header,
            "VBOOST": format_voltage_header,
            "VREG": format_voltage_header,
            "VRECT": format_voltage_header,
            "VINJ": format_voltage_header,
            "RF_EVENTS": format_rf_event_header,
            "WATCHPOINTS": format_watchpoint_event_header,
        }

        interrupt_signals = [signal.SIGINT, signal.SIGALRM]

        csv_header = "host_timestamp_sec,timestamp_sec," + \
                ",".join(map(lambda s: stream_headers[s](s), streams)) + "\n"

        with delayed_signals.DelayedSignals(interrupt_signals): # prevent partial lines
            out_file.write(csv_header)

        STREAM_STATE_STREAMING = 0
        STREAM_STATE_TERMINATE_REQUEST = 1
        STREAM_STATE_TERMINATING = 2
        STREAM_STATE_TERMINATED = 3

        # Can't modify a variable in this scope, but can modify values in a dict
        signal_handler_data = {'stream_state' : STREAM_STATE_STREAMING}

        def interrupt_loop(sig, frame):
            signal_handler_data['stream_state'] = STREAM_STATE_TERMINATE_REQUEST

        if duration_sec is not None:
            # The main point here is to cause the read system call to return

            signal.signal(signal.SIGALRM, interrupt_loop)
            signal.setitimer(signal.ITIMER_REAL, duration_sec)

        time_started = time.time()

        while True:
            try:

                stream_state = signal_handler_data['stream_state']

                if stream_state in [STREAM_STATE_STREAMING, STREAM_STATE_TERMINATING]:

                    pkt = self.receive_reply([
                                    host_comm_header.enums['USB_RSP']['STREAM_EVENTS'],
                                    host_comm_header.enums['USB_RSP']['STREAM_VOLTAGES'],
                                    host_comm_header.enums['USB_RSP']['STDIO']
                                ], timeout=1)

                    if pkt is not None:

                        if pkt["descriptor"] == host_comm_header.enums['USB_RSP']['STDIO']:
                            continue

                        host_timestamp_sec = time.time() - time_started

                        for data_point in pkt["data_points"]:

                            # #### 16-bit timestamp
                            # Detect overflow by watching for timestamp to decrease
                            # NOTE: each pkt type has it's own time since the samples
                            # in two packets of different types, which (the packets)
                            # are transmitted one after another, may be interleaved.
                            #if data_point.timestamp_cycles < prev_timestamp_cycles[pkt['descriptor']]:
                            #    overflow_timestamp_cycles[pkt['descriptor']] += 1 << 16;
                            #prev_timestamp_cycles[pkt['descriptor']] = data_point.timestamp_cycles

                            # Count beyond 16 bits
                            #timestamp_cycles = overflow_timestamp_cycles[pkt['descriptor']] + \
                            #                        data_point.timestamp_cycles

                            # #### 32-bit timestamp
                            timestamp_cycles = data_point.timestamp_cycles

                            timestamp_sec = float(timestamp_cycles) * self.TIMELOG_PERIOD

                            line = "%f,%f" % (host_timestamp_sec, timestamp_sec)
                            stop_condition = False
                            for stream in streams:

                                # a column per requested stream, so may have blanks on some rows
                                line += ","
                                if stream in data_point.value_set:
                                    data = data_point.value_set[stream]
                                    line += stream_formaters[stream](data)

                                    if stream == 'WATCHPOINTS':
                                        if stop_at_watchpoint is not None and data.id == stop_at_watchpoint:
                                            stop_condition = True

                            line += "\n"

                            with delayed_signals.DelayedSignals(interrupt_signals): # prevent partial lines
                                out_file.write(line)

                            num_samples += 1

                            if stop_condition:
                                signal_handler_data['stream_state'] = STREAM_STATE_TERMINATE_REQUEST
                                break

                        now = time.time()
                        if not silent and now - last_progress_report > REPORT_STREAM_PROGRESS_INTERVAL:
                            print("\r%d samples @ %.2f KB/s" % (num_samples, self.stream_datarate_kbps()), end='')
                            sys.stdout.flush()
                            last_progress_report = now

                    if stream_state == STREAM_STATE_TERMINATING:
                        signal_handler_data['stream_state'] = STREAM_STATE_TERMINATED

                elif stream_state == STREAM_STATE_TERMINATE_REQUEST:
                    self.stream_end(streams_bitmask)
                    signal_handler_data['stream_state'] = STREAM_STATE_TERMINATING
                    # loop once more to get the left-overs: partially full buffer

                elif stream_state == STREAM_STATE_TERMINATED:
                    break

            except (KeyboardInterrupt, serial.SerialException):
                signal_handler_data['stream_state'] = STREAM_STATE_TERMINATE_REQUEST
                # loop around

        time_ended = time.time()

        if not silent:
            print() # the rolling progress report does not newline
            print("%d samples in %f seconds" % (num_samples, time_ended - time_started))

class RxPkt():
    def __init__(self):
        self.constructState = CONSTRUCT_STATE_IDENTIFIER
        self.identifier = 0
        self.descriptor = 0
        self.length = 0
        self.data = None
    
    def printSelf(self):
        print("RxPkt")
        print("\tidentifier = 0x%02x" % self.identifier)
        print("\tdescriptor = 0x%02x" % self.descriptor)
        print("\tlength = %d" % self.length)
        print("\tdata = 0x%s" % hexlify(self.data))

