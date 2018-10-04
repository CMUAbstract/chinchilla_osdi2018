import logging
import multiprocessing
import os
import signal
import sys

from twisted.internet import reactor, defer

import sllurp.llrp as llrp
from sllurp.llrp_proto import Modulation_Name2Type, Modulation_DefaultTari

def init_logging (debug, logfile=None):
    logger = logging.getLogger('sllurp')
    logLevel = (debug and logging.DEBUG or logging.WARN)
    logFormat = '%(asctime)s %(name)s: %(levelname)s: %(message)s'
    formatter = logging.Formatter(logFormat)
    stderr = logging.StreamHandler()
    stderr.setFormatter(formatter)

    root = logging.getLogger()
    root.setLevel(logLevel)
    root.handlers = [stderr,]

    if logfile:
        fHandler = logging.FileHandler(logfile)
        fHandler.setFormatter(formatter)
        root.addHandler(fHandler)

    logger.log(logging.INFO, 'log level: {}'.format(logging.getLevelName(logLevel)))

def range_spec(s):
    return range(*map(int, s.split(':')))

def finish (_):
    pass
    #if reactor.running:
        #reactor.stop()

def politeShutdown (factory):
    return factory.politeShutdown()

def do_rfid_inventory(host=None, port=llrp.LLRP_PORT, tag_report_callback=None,
                      duration=0,
                      antennas=[1], tx_power=20,
                      modulation='FM0', tari=0,
                      session=2, population=4,
                      debug=False, logfile=None):

    init_logging(debug, logfile)

    # special case default Tari values
    if modulation in Modulation_DefaultTari:
        if not tari:
            tari = Modulation_DefaultTari[modulation]

    # d.callback will be called when all connections have terminated normally.
    # use d.addCallback(<callable>) to define end-of-program behavior.
    d = defer.Deferred()
    d.addCallback(finish)

    fac = llrp.LLRPClientFactory(onFinish=d,
            duration=duration,
            report_every_n_tags=1,
            antennas=antennas,
            tx_power=tx_power,
            modulation=modulation,
            tari=tari,
            session=session,
            tag_population=population,
            start_inventory=True,
            disconnect_when_done=False,
            reconnect=False,
            tag_content_selector={
                'EnableROSpecID': False,
                'EnableSpecIndex': False,
                'EnableInventoryParameterSpecID': False,
                'EnableAntennaID': True,
                'EnableChannelIndex': False,
                'EnablePeakRSSI': True,
                'EnableFirstSeenTimestamp': False,
                'EnableLastSeenTimestamp': True,
                'EnableTagSeenCount': True,
                'EnableAccessSpecID': False
            })

    # tagReportCallback will be called every time the reader sends a TagReport
    # message (i.e., when it has "seen" tags).
    if tag_report_callback is not None:
        fac.addTagReportCallback(tag_report_callback)

    # catch ctrl-C and stop inventory before disconnecting
    reactor.addSystemEventTrigger('before', 'shutdown', politeShutdown, fac)

    reactor.connectTCP(host, port, fac, timeout=3)

    reactor.run()

def inventory_tags(fout, reader_settings, tag_ids=None,
                   duration=None, num_readings=1):

    fout.write("tag_id,rssi\n")
    fout.flush()

    reader_proc = None
    #num_readings_collected = 0
    shared_vars = dict(num_readings_collected=0, stopped=False)

    def on_tag_report(llrp_msg):
        tags = llrp_msg.msgdict['RO_ACCESS_REPORT']['TagReportData']
        for tag in tags:
            tag_info = dict(
                id = tag['EPC-96'],
                rssi = float(tag['PeakRSSI'][0]),
            )
            print "tag: ", tag_info
            if tag_ids is None or tag_info['id'] in tag_ids:
                if not shared_vars['stopped'] and \
                    (duration or shared_vars['num_readings_collected'] < num_readings):
                    fout.write("%s,%f\n" % (tag_info['id'], tag_info['rssi']))
                    fout.flush()
                    shared_vars['num_readings_collected'] += 1
                    print "tag written, total", shared_vars['num_readings_collected']
                    if not duration and shared_vars['num_readings_collected'] == num_readings:
                        if not shared_vars['stopped']:
                            print "samples collected stop"
                            shared_vars['stopped'] = True # send signal only once
                            os.kill(reader_proc.pid, signal.SIGINT)

    local_reader_settings = reader_settings.copy()
    local_reader_settings.update(tag_report_callback=on_tag_report,
                                 duration=duration)

    reader_proc = multiprocessing.Process(target=do_rfid_inventory,
                                          kwargs=local_reader_settings)
    reader_proc.start()
    reader_proc.join() # terminates when duration expires or num_readings colleted

def stop_inventory(reader_handle):
    os.kill(reader_handle.pid, signal.SIGINT)
    reader_handle.join()

def reader_on(reader_settings):
    local_reader_settings = reader_settings.copy()
    local_reader_settings.update(duration=None) # duration must be present, else LLRP error
    reader_proc = multiprocessing.Process(target=do_rfid_inventory,
                                   kwargs=local_reader_settings)
    reader_proc.start()
    return reader_proc

def reader_off(reader_handle):
    stop_inventory(reader_handle)

