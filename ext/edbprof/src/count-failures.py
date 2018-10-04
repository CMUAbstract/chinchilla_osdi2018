#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl

parser = argparse.ArgumentParser(
    description="Count task failures using watchpoint trace")
parser.add_argument('watchpoint_trace',
    help="Input watchpoint trace (CSV)")
parser.add_argument('--output', '-o',
    help="Output file with failure counts")
args = parser.parse_args()

watchpoint_trace = pd.read_csv(args.watchpoint_trace)

# task -> failure count
reboots = {}
runs = {}

prev_wid = None
for i, row in watchpoint_trace.iterrows():
    wid = int(row["watchpoint_id"])
    if prev_wid is None:
        prev_wid = wid
        continue

    if prev_wid > 0: # a task start watchpoint
        if prev_wid not in reboots:
            reboots[prev_wid] = 0
            runs[prev_wid] = 0

        runs[prev_wid] += 1
        if wid == 0: # a reboot follows this watchpoint
            reboots[prev_wid] += 1

    #if wid > 0: # a task start watchpoint
        #runs[wid] += 1
        #if prev_wid == 0: # a reboot preceeded this watchpoint
            #reboots[wid] += 1

    prev_wid = wid

fout = open(args.output, "w")
fout.write("task,runs,reboots,failure_rate,completion_rate\n")
for task_idx in sorted(runs.keys()):
    failure_rate = float(reboots[task_idx]) / runs[task_idx] \
                   if runs[task_idx] > 0 else float('nan')
    completion_rate = 1.0 - failure_rate

    print("task %u: runs %u reboots %u failure %.4f completion %.4f" %
            (task_idx, runs[task_idx], reboots[task_idx],
             failure_rate, completion_rate))

    fout.write("%u,%u,%u,%f,%f\n" % (task_idx,
                    runs[task_idx], reboots[task_idx],
                    failure_rate, completion_rate))
