#!/usr/bin/python

import argparse
import os
import pandas as pd
import numpy as np
import pylab as pl

from plot import *

parser = argparse.ArgumentParser(
    description="Plot with the time chcker takes to predict an outcome vs boundary count")
parser.add_argument('checker_times',
    help='Input dataset with checker times for checkers (CSV)')
parser.add_argument('--output', '-o',
    help='Output file where to save the table (TeX)')
parser.add_argument('--range', type=int, nargs=2, metavar=['FROM', 'TO'],
    help='Range of x-axis (boundary count)')
args = parser.parse_args()

checker_times = pd.read_csv(args.checker_times)

checker_times = checker_times.set_index('boundary_count')
 
pl.scatter(checker_times.index, checker_times['checker_time_s'], color='k')

pl.title("Time taken to validate a decomposition")
pl.xlabel("Number of boundaries")
pl.ylabel("Time (s)")

if args.range:
    pl.xlim(args.range)
else:
    pl.xlim(xmin=0)
    pl.ylim(ymin=0)

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
