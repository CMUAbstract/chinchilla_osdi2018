#!/usr/bin/python

import argparse
import os
import pandas as pd
import numpy as np

from plot import *

parser = argparse.ArgumentParser(
    description="Table with the time placer takes to find a placement")
parser.add_argument('placer_times',
    help='Input dataset with placing times for placers (CSV)')
parser.add_argument('--output', '-o',
    help='Output file where to save the table (TeX)')
args = parser.parse_args()

placer_times = pd.read_csv(args.placer_times)

placer_times = placer_times.set_index('capacity')

placers = ['greedy']
#markers = ['s']
#markers = [None]
#placer_times = placer_times[['capacity'] + placers]
placer_times = placer_times[placers]

#for idx, placer in enumerate(placers):
#    pl.plot(placer_times.index, placer_times[placer],
#            label=PRETTY_PLACER_NAMES[placer],
#            color=cm(idx * 1.0 / len(placers)), marker=markers[idx])

stats = placer_times.describe()

fout = open(args.output, "w")
fout.write("% mean, max (s)\n");
fout.write("%.1f & %.1f\n" % (stats.loc['mean'], stats.loc['max']))
