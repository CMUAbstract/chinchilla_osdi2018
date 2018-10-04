#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Count task failures using watchpoint trace")
parser.add_argument('watchpoint_trace',
    help="Input watchpoint trace (CSV)")
parser.add_argument('--output', '-o',
    help="Output file with failure counts")
args = parser.parse_args()

watchpoint_trace = pd.read_csv(args.watchpoint_trace)

fout = open(args.output, "w")
fout.write("task_id,start_voltage,succeeded\n")

prev_wid = None
for i, row in watchpoint_trace.iterrows():
    wid = int(row["watchpoint_id"])
    voltage = row["watchpoint_vcap"]
    if prev_wid is None:
        prev_wid = wid
        continue

    if prev_wid > 0: # a task start watchpoint
        if wid == 0: # a reboot follows this watchpoint
            succeeded = False
        else:
            succeeded = True

        fout.write("%u,%e,%u\n" % (prev_wid, prev_voltage, succeeded))

    prev_wid = wid
    prev_voltage = voltage
