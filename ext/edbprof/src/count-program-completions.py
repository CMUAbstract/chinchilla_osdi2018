#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl

parser = argparse.ArgumentParser(
    description="Count how many times program completed in a watchpoint trace")
parser.add_argument('watchpoint_trace',
    help="Input watchpoint trace from Checker validation workflow stage (CSV)")
parser.add_argument('--output', '-o',
    help="Output file with program completion count")
parser.add_argument('--watchpoints', nargs=2, type=int,
    metavar=['START', 'END'], default=[0, 1],
    help="Watchpoints used to mark program START and END events")
parser.add_argument('--multiple-trials', action='store_true',
    help="Whether the program will run many times in during one measurement " +
         "(depends on where the start/end markers are placed)")
args = parser.parse_args()

# In our current experimental methodology, we count program start event
# at the line before the main loop. We count the program end event at
# the end of an iteration. In all but the first iteration the end event
# is not paired with a start event, and is therefore ignored. So, the
# observed data is a binary outcome: either the program started and
# completed or it started but did not complete. So, usually (in the
# raw event trace, there will be only one start event (exception: no
# boundaries at all), and one or more end events.

# Program completion is when START even is followed by an END event
#   START and END events are watchpoints 

watchpoint_trace = pd.read_csv(args.watchpoint_trace)

start_wp = args.watchpoints[0]
end_wp = args.watchpoints[1]

print("start wp=", start_wp, "end_wp=", end_wp)

STATE_IDLE = 1
STATE_RUNNING = 0

state = STATE_IDLE
num_starts = 0
num_completions = 0
elapsed_times = []
for i, row in watchpoint_trace.iterrows():
    wid = int(row["watchpoint_id"])
    timestamp = float(row["host_timestamp_sec"])
    if state == STATE_RUNNING:
        if wid == end_wp:
            num_completions += 1
            elapsed_time = timestamp - start_timestamp
            elapsed_times.append(elapsed_time)
            state = STATE_IDLE
            continue
        else:
            pass # program did not complete

    if wid == start_wp:
        num_starts += 1
        start_timestamp = timestamp
        state = STATE_RUNNING
    else:
        pass # another completion: ignore
             # this is normal, because of the outer loop; we only consider
             # the first iteration after boot and ignore the rest

# Drop the last point, because the trace ends, so we don't know
# whether in that instance the program completed or not.
# Alternatively, we could re-write the above code to count only
# when two starts happen in a row.
if args.multiple_trials:
    if state == STATE_RUNNING:
        num_starts -= 1

if num_starts > 0:
    p_completes = num_completions / num_starts
else:
    p_completes = float('nan')

print("starts =", num_starts, "completions =", num_completions, 
      "p_completes = ", p_completes)

d = pd.DataFrame(dict(elapsed_sec=elapsed_times))
d.to_csv(args.output, index=False)
