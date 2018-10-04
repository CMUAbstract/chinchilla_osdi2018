#!/usr/bin/python

import os
import pylab as pl
import pandas as pd
import seaborn as sb
import argparse

parser = argparse.ArgumentParser(
    description="Plot histograms of block energy cost")
parser.add_argument('energy_dataset', nargs='+',
    help="Input file with the energy deltas for a block (CSV)")
parser.add_argument('--out', '-o',
    help="Output filename to save the figure to (extension indicates format)")
parser.add_argument('--map', '-m',
    help="Input file with map from block name to block hash")
parser.add_argument('--hist', action='store_true', default=False,
    help="Plot histogram")
parser.add_argument('--kde', action='store_true',
    help="Plot KDE in addition")
args = parser.parse_args()


# If a name -> hash map is given, we use it to put names in labels
blk_hash_to_name = {}
if args.map is not None:
    for line in open(args.map, "r"):
        func, blk_name, blk_hash = map(str.strip, line.split(','))
        blk_hash_to_name[blk_hash] = blk_name

for dataset in args.energy_dataset:
    d = pd.read_csv(dataset)

    # Try to use block name, but always also include some part of the hash
    blk_hash = os.path.basename(dataset).split('.')[0]
    if blk_hash in blk_hash_to_name:
        label = "%s (%s...)" % (blk_hash_to_name[blk_hash], blk_hash[0:4])
    else:
        label = blk_hash[0:8]

    block_energy_mJ = d["energy_mean"]
    sb.distplot(block_energy_mJ, label=label, hist=args.hist, kde=args.kde)

pl.title("Measured block energy cost")
pl.xlabel("Block energy (uJ)")

if args.kde:
    pl.ylabel("Probability")
else: # hist only
    pl.ylabel("Count (datapoints)")

pl.legend()

if args.out is None:
    pl.show()
else:
    pl.savefig(args.out, bbox_inches='tight')
