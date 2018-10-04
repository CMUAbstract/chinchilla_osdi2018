#!/usr/bin/python

import os
import numpy as np
import pylab as pl
import pandas as pd
import seaborn as sb
import argparse

parser = argparse.ArgumentParser(
    description="Plot histograms of block energy cost")
parser.add_argument('energy_dataset',
    help="Input file with the energy deltas for a block (CSV)")
parser.add_argument('--out', '-o',
    help="Output filename to save the figure to (extension indicates format)")
parser.add_argument('--map', '-m',
    help="Input file with map from block name to block hash")
parser.add_argument('--hist', action='store_true', default=True,
    help="Plot histogram")
parser.add_argument('--kde', action='store_true',
    help="Plot KDE in addition")
args = parser.parse_args()

print(args.energy_dataset)
d = pd.read_csv(args.energy_dataset)

ind = np.arange(len(d["func"]))
prefix = pd.Series(".", index = ind)
block_name = d["func"].add(prefix).add(d["block_name"])
block_energy_mJ = d["energy_mean"]
block_energy_stddev = d["energy_sd"]

pl.bar(ind, block_energy_mJ, yerr = block_energy_stddev)

pl.axhline(y=22.6, color='r', linestyle='-')

pl.title("Measured block energy cost")
pl.xlabel("Blocks")
pl.xticks(ind, block_name)

pl.ylabel("Energy (uJ)")

pl.legend()

if args.out is None:
    pl.show()
else:
    pl.savefig(args.out, bbox_inches='tight')
