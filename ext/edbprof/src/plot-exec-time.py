#!/usr/bin/python

import argparse
import os
import pandas as pd
import numpy as np
import pylab as pl

from plot import *

parser = argparse.ArgumentParser(
    description="Plot app execution times under different boundary placements")
parser.add_argument('placement_exec_times',
    help='Input dataset with app execution times (CSV)')
parser.add_argument('--output', '-o',
    help='Output file where to save the plot (format by extention)')
args = parser.parse_args()

placement_exec_times = pd.read_csv(args.placement_exec_times)

exec_times_by_placer = placement_exec_times.groupby('placer')
num_placers = len(exec_times_by_placer.groups.keys())

fig = pl.figure()
ax = fig.add_subplot(111)

cm = pl.get_cmap('gray')

for idx, (placer, exec_times) in enumerate(exec_times_by_placer):
    print("placer=", placer, "num exec times=", len(exec_times['idx']))
    ax.bar(exec_times['idx'], exec_times['elapsed_sec'],
          label=PRETTY_PLACER_NAMES[placer],
          color=cm(idx * 1.0 / num_placers))

pl.title('Total application execution time (lower is better)')
pl.ylabel("Application execution time (s)")
pl.xlabel("Task boundary placements")
pl.legend(loc=0)

pl.setp(ax.get_xticklabels(), visible=False)

# For some reason, by default, plot comes out with a blank space on the right
pl.xlim(xmax=placement_exec_times['idx'].max()+1)

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
