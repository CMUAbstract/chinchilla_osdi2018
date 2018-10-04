#!/usr/bin/python

import argparse
import os
import pandas as pd
import numpy as np
import pylab as pl

from plot import *

parser = argparse.ArgumentParser(
    description="Plot boundary counts vs capacity")
parser.add_argument('boundary_counts',
    help='Input dataset with boundary counts (CSV)')
parser.add_argument('--output', '-o',
    help='Output file where to save the plot (format by extention)')
args = parser.parse_args()

boundary_counts = pd.read_csv(args.boundary_counts)

fig = pl.figure()
ax = fig.add_subplot(111)

cm = pl.get_cmap('gray')

boundary_counts = boundary_counts.set_index('capacity')

placers = ['greedy']
#markers = ['s']
markers = [None]
boundary_counts = boundary_counts[placers]

#boundary_counts.plot(marker='o')

for idx, placer in enumerate(placers):
    pl.plot(boundary_counts.index, boundary_counts[placer],
            label=PRETTY_PLACER_NAMES[placer],
            color=cm(idx * 1.0 / len(placers)), marker=markers[idx])

pl.title('Number of task boundaries placed by CleanCut')
pl.ylabel("Number of task boundaries")
pl.xlabel("Energy capacity available on device (uJ)")
#pl.legend(loc=0)

pl.ylim(ymin=0)

#pl.setp(ax.get_xticklabels(), visible=False)

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
