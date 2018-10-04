#!/usr/bin/python

import argparse
import os
import pandas as pd
import numpy as np

from plot import *

parser = argparse.ArgumentParser(
    description="Table with the time chcker takes to predict an outcome")
parser.add_argument('checker_extract_times',
    help='Input dataset with checker extract times for checkers (CSV)')
parser.add_argument('checker_eval_times',
    help='Input dataset with checker eval times for checkers (CSV)')
parser.add_argument('--output', '-o',
    help='Output file where to save the table (TeX)')
args = parser.parse_args()

checker_extract_times = pd.read_csv(args.checker_extract_times)
checker_eval_times = pd.read_csv(args.checker_eval_times)

checker_times = checker_extract_times['checker_time_s'] + checker_eval_times['checker_time_s'] 

mean_time = checker_times.mean()
max_time = checker_times.max()

fout = open(args.output, "w")
fout.write("% mean, max (s)\n");
fout.write("%.0f & %.0f\n" % (mean_time, max_time))
