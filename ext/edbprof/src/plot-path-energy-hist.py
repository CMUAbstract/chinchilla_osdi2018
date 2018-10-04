#!/usr/bin/python

import os
import pylab as pl
import pandas as pd
import argparse

parser = argparse.ArgumentParser(
    description="Plot histograms of path energy cost")
parser.add_argument('path_energy_dataset',
    help="Input file with the energy deltas for a block (CSV)")
parser.add_argument('--out', '-o',
    help="Output filename to save the figure to (extension indicates format)")
args = parser.parse_args()

d = pd.read_csv(args.path_energy_dataset)

path_energy = d['e_mean_J']
path_energy.hist()

pl.title("Calculated path energy cost")
pl.xlabel("Path energy (mJ)")
pl.ylabel("Count (# paths)")

pl.legend()

if args.out is None:
    pl.show()
else:
    pl.savefig(args.out, bbox_inches='tight')
