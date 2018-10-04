#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl

parser = argparse.ArgumentParser(
    description="Plot function energy cost")
parser.add_argument('func_energy_dist',
    help="Dataset with func energy distribution (CSV)")
parser.add_argument('--output', '-o',
    help="Figure filename to which to save the plot")
args = parser.parse_args()

ENERGY_COLUMN = "energy"

d = pd.read_csv(args.func_energy_dist)

energy = d[ENERGY_COLUMN]

# TODO: create axes, then plot in one loop

# Plot pdf
pl.subplot(121)
pl.title("Function Energy Cost PDF")
pl.xlabel("Energy (J?)")
pl.ylabel('"Relative" Probability')
for func in d:
    if func == ENERGY_COLUMN:
        continue
    if func.endswith("-pdf"):
        pl.plot(energy, d[func])

# Plot cdf
pl.subplot(122)
pl.title("Function Energy Cost CDF")
pl.xlabel("Energy (J?)")
pl.ylabel("Cummulative Probability")
for func in d:
    if func == ENERGY_COLUMN:
        continue
    if func.endswith("-cdf"):
        pl.plot(energy, d[func])

pl.tight_layout()

if args.output is not None:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
