#!/usr/bin/python

import os
import pylab as pl
import pandas as pd
import argparse

parser = argparse.ArgumentParser(
    description="Plot block energy histogram")
parser.add_argument('energy_hist_dataset',
    help="Input file with the the histogram data (CSV)")
parser.add_argument('--out', '-o',
    help="Output filename to save the figure to (extension indicates format)")
parser.add_argument('--range', '-r', nargs=2, metavar=['FROM', 'TO'],
    type=float,
    help='Range of x-axis to show')
args = parser.parse_args()

d = pd.read_csv(args.energy_hist_dataset)

if args.range is not None:
    d_subset = d[(args.range[0] <= d['energy']) & (d['energy'] <= args.range[1])]
else:
    d_subset = d

energy = d_subset['energy']
count = d_subset['count']

if len(energy) >= 2:
    step = energy[1] - energy[0]
else:
    step = args.range[1] - args.range[0]
print(count)

pl.bar(energy - step / 2, count, width=step)

pl.title("Block energy histogram")
pl.xlabel("Block energy (uJ)")
pl.ylabel("Count")

#pl.legend()

if args.out is None:
    pl.show()
else:
    pl.savefig(args.out, bbox_inches='tight')
