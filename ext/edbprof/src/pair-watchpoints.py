#!/usr/bin/python

import argparse
import pandas as pd
import sys

parser = argparse.ArgumentParser(
            description="Arrange traced watchpoints into pairs")
parser.add_argument('in_file',
            help="Input file with the raw watchpoint trace (CSV)")
parser.add_argument('out_file',
            help="Output file with the paired watchpoint data (CSV)")
parser.add_argument('--watchpoints', nargs=2, type=int,
            metavar=['START', 'END'], required=True,
            help="Watchpoint indexes used by harness binary (CSV)")
args = parser.parse_args()

number_samples_collected = 0

fout = open(args.out_file,'w')
fout.write("timestamp_start_s,timestamp_end_s,voltage_start_V,voltage_end_V\n")

trace = pd.read_csv(args.in_file, index_col=False)

start_watchpoint = None
for i, row in trace.iterrows():
    if start_watchpoint is None:
        if row.watchpoint_id == args.watchpoints[0]:
            start_watchpoint = row
    elif row.watchpoint_id == args.watchpoints[1]:
        fout.write("%e,%e,%e,%e\n" % (start_watchpoint.timestamp_sec, row.timestamp_sec, \
                                      start_watchpoint.watchpoint_vcap, row.watchpoint_vcap))
        start_watchpoint = None
    else: # mismatched watchpoint
        start_watchpoint = None
        if row.watchpoint_id == args.watchpoints[0]:
            start_watchpoint = row
