#!/usr/bin/python

import argparse
import numpy as np
import pandas as pd
import math

parser = argparse.ArgumentParser(
    description="Calculate histogram from raw energy data")
parser.add_argument('block_energy_dataset',
    help="Input dataset with block energy (CSV)")
parser.add_argument('--output', '-o',
    help="Output file where to save the histogram dataset (CSV)")
parser.add_argument('--num-hist-bins', type=int,
    help='Number of histogram bins to use')
parser.add_argument('--bin-size', type=float,
    help='Size of a bin')
args = parser.parse_args()

block_energy_dataset = pd.read_csv(args.block_energy_dataset)
block_energy = block_energy_dataset['block_energy_uJ']

if args.num_hist_bins:
    bins = args.num_hist_bins
else:
    # Keep the bins on a grid (+1 to have at least two bins, for interpolation to work)
    low_bins = math.floor(block_energy.min() / args.bin_size) - 1
    high_bins = math.ceil(block_energy.max() / args.bin_size) + 1
    bins = np.arange(low_bins * args.bin_size, (high_bins + 1) * args.bin_size, args.bin_size)

bin_values, bin_edges = np.histogram(block_energy, bins=bins)
if args.num_hist_bins:
    bin_width = (bin_edges[1] - bin_edges[0])
else:
    bin_width = args.bin_size
#bin_middles = bin_edges[0:-1] + (bin_width / 2)

hist_df = pd.DataFrame(dict(energy=bin_edges[0:-1], count=bin_values))

hist_df.to_csv(args.output, index=False)
