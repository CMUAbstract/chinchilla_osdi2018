#!/usr/bin/python2

import argparse

from pyedb import edb
import sllurpsock.cmd as sllurpcmd

parser = argparse.ArgumentParser(
    description="Measure failure rate with a watchpoint trace")
parser.add_argument('--output', '-o', required=True,
    help="Output file with the collected watchpoint trace (CSV)")
parser.add_argument('--device', default="/dev/ttyUSB0",
    help="Device file for EDB")
parser.add_argument('--duration', type=float, default=10,
    help="Duration to collect start energy data for (sec)")
parser.add_argument('--reader-host',
    help='IP address (or hostname) of the RFID reader')
parser.add_argument('--tx-power', type=float, default=20,
    help='RFID reader TX power (dBm)')
args = parser.parse_args()

edb = edb.EDB(args.device)

# Must match what is set in the app and in libedb
BOOT_WATCHPOINT = 0
TASK_WATCHPOINTS = [1, 2]

edb.toggle_watchpoint(BOOT_WATCHPOINT, enable=True , vcap_snapshot=True)
for wp in TASK_WATCHPOINTS:
    edb.toggle_watchpoint(wp, enable=True , vcap_snapshot=True)

reader_settings = dict(
    host=args.reader_host,
    tx_power=args.tx_power
)
reader_handle = sllurpcmd.reader_on(reader_settings)

edb.stream(["WATCHPOINTS"], duration_sec=args.duration,
           out_file=open(args.output, "w"),
           silent=False, no_parse=False)

sllurpcmd.reader_off(reader_handle)

edb.toggle_watchpoint(BOOT_WATCHPOINT, enable=False, vcap_snapshot=True)
for wp in TASK_WATCHPOINTS:
    edb.toggle_watchpoint(wp, enable=False, vcap_snapshot=True)

edb.destroy()
