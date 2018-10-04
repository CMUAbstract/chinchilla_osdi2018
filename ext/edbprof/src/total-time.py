#!/usr/bin/python

import argparse
import os
import pandas as pd

parser = argparse.ArgumentParser(
    description="Add times from 'time' trace")
parser.add_argument('time_trace',
    help="Input trace from running the 'time -f %e' command (in seconds)")
parser.add_argument('--output', '-o',
    help='Output file where to save the time dataset (CSV)')
args = parser.parse_args()

times = pd.read_csv(args.time_trace, header=None)
total_time = times.sum()

time_df = pd.DataFrame(dict(exec_time=total_time), index=[0])
time_df.to_csv(args.output, index=False)
