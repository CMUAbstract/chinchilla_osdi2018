#!/usr/bin/python2

import argparse
import time
import os

from pyedb import edb as edbmod

import sllurpsock.cmd as sllurpcmd

parser = argparse.ArgumentParser(
    description="Collect start energy dataset using EDB")
parser.add_argument('--output', '-o', required=True,
    help="Output file with measured start energy dataset (CSV)")
parser.add_argument('--device', default="/dev/ttyUSB0",
    help="Device file for EDB")
parser.add_argument('--watchpoints', type=int, nargs='+', required=True,
    help="Watchpoint index(es) at the marker(s) of interest")
parser.add_argument('--duration', type=float,
    help="Duration to collect start energy data for (sec)")
parser.add_argument('--reader-host',
    help='IP address (or hostname) of the RFID reader')
parser.add_argument('--tx-power', type=float, default=20,
    help='RFID reader TX power (dBm)')
parser.add_argument('--reader-init-timeout', type=int, default=0,
    help='time it takes to RFID reader to supply steady even power')
parser.add_argument('--voltage-snapshot', action='store_true', default=True,
    help='Whether to tell EDB to collect a voltage snapshot at each watchpoint')
parser.add_argument('--watchpoints-buffered', type=int, default=16,
    help='How many watchpoints to buffer before sending to host (EDB param, max 16)')
parser.add_argument('--stop-at-watchpoint', type=int,
    help='Stop stream after receiving watchpoint with given ID (DEPRECATED, use --stop-pattern)')
parser.add_argument('--stop-pattern', type=str,
    help='A regex on the last 100 watchpoint IDs that signifies to end the collection ' + \
         '(e.g. "01$" will stop after Watchpoint 1, preceded by Watchpoint 0) ')
parser.add_argument('--abort-after-watchpoints', type=int,
    help='Abort the data collection after N watchpoints happened (for fault tolerance)')
args = parser.parse_args()

edb = edbmod.EDB(args.device)

if args.watchpoints_buffered:
    MAX_WATCHPOINTS_BUFFERED = 16 # TODO: add the max value to the interface
    if args.watchpoints_buffered > MAX_WATCHPOINTS_BUFFERED:
        raise Exception("invalid --watchpoint-buffered param: max supported by EDB:",
                        MAX_WATCHPOINTS_BUFFERED)
    print "Setting watchpoints buffer EDB param to:", args.watchpoints_buffered
    rc = edb.set_remote_param('num_watchpoint_events_buffered', edbmod.UIntValue(args.watchpoints_buffered))
    if rc != 0:
        raise Exception("failued to set watchpoint buffered param: rc " + str(rc))

for wp in args.watchpoints:
    edb.toggle_watchpoint(wp, enable=True , vcap_snapshot=args.voltage_snapshot)

reader_settings = dict(
    host=args.reader_host,
    tx_power=args.tx_power
)
reader_handle = sllurpcmd.reader_on(reader_settings)

time.sleep(args.reader_init_timeout)

# So that if we interrupt the collection, the file is not created at all
out_temp_filename = args.output + ".tmp"
out_temp_file = open(out_temp_filename, "w")

# For backward compatibility
if args.stop_at_watchpoint is not None:
    stop_pattern = args.stop_at_watchpoint + '$'
else:
    stop_pattern = args.stop_pattern

edb.stream(["WATCHPOINTS"], duration_sec=args.duration,
           out_file=out_temp_file, silent=False, no_parse=False,
           stop_pattern=stop_pattern, abort_after_watchpoints=args.abort_after_watchpoints)

sllurpcmd.reader_off(reader_handle)

for wp in args.watchpoints:
    edb.toggle_watchpoint(wp, enable=False, vcap_snapshot=args.voltage_snapshot)

edb.destroy()

os.rename(out_temp_filename, args.output)
