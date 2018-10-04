#!/usr/bin/python2

import argparse
import time
from pyedb import edb

import sllurpsock.cmd as sllurpcmd

parser = argparse.ArgumentParser(
            description="Collect watchpoint trace from EDB")
parser.add_argument('trace_file',
            help="Output file to which to save the watchpoint trace")
parser.add_argument('--duration', type=float, default=20.0,
            help="Amount of time to collect the trace for")
parser.add_argument('--reader-host',
            help='IP address (or hostname) of the RFID reader')
parser.add_argument('--tx-power', type=float, default=20,
            help='RFID reader TX power (dBm)')
parser.add_argument('--reader-init-timeout', type=int, default=0,
            help='time it takes to RFID reader to supply steady even power')
parser.add_argument('--device', default="/dev/ttyUSB0",
            help="Device file for EDB")
parser.add_argument('--watchpoints-buffered', type=int, default=16,
    help='How many watchpoints to buffer before sending to host (EDB param, max 16)')
args = parser.parse_args()

reader_settings = dict(
    host=args.reader_host,
    tx_power=args.tx_power
)

reader_handle = sllurpcmd.reader_on(reader_settings)
time.sleep(args.reader_init_timeout)

monitor = edb.EDB(args.device)

monitor.set_remote_param("num_watchpoint_events_buffered",
                         edb.UIntValue(args.watchpoints_buffered))

monitor.toggle_watchpoint(0,1,1)
monitor.toggle_watchpoint(1,1,1)

fp = open(args.trace_file,"w")
streams = ["WATCHPOINTS"]
monitor.stream(streams, duration_sec=args.duration, out_file=fp,
               silent=False, no_parse=False)

monitor.destroy()
fp.close()

sllurpcmd.reader_off(reader_handle)
