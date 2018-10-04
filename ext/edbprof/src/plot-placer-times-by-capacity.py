#!/usr/bin/python

import argparse
import os
import pandas as pd
import numpy as np
import pylab as pl

from plot import *

parser = argparse.ArgumentParser(
    description="Plot the time placer takes to find a placement")
parser.add_argument('placer_times',
    help='Input dataset with placing times for placers (CSV)')
parser.add_argument('--output', '-o',
    help='Output file where to save the plot (format by extention)')
parser.add_argument('--range', type=float, nargs=2, metavar=['FROM', 'TO'],
    help='Range of x-axis (uJ)')
args = parser.parse_args()

placer_times = pd.read_csv(args.placer_times)

fig = pl.figure()
ax = fig.add_subplot(111)

cm = pl.get_cmap('gray')

placer_times = placer_times.set_index('capacity')

placers = ['greedy']
#markers = ['s']
#markers = [None]
placer_times = placer_times[placers]


for idx, placer in enumerate(placers):
    color = color=cm(idx * 1.0 / len(placers))
    pl.plot(placer_times.index, placer_times[placer], color=color,
            label=PRETTY_PLACER_NAMES[placer])

pl.title('Time to find a program decomposition')
pl.ylabel("Time (s)")
pl.xlabel("Energy capacity on devince (uJ)")

if args.range:
    pl.xlim(args.range)

#pl.legend(loc=0)
#pl.ylim(ymin=0)
#pl.setp(ax.get_xticklabels(), visible=False)

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
