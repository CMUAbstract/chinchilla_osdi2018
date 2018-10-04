#!/usr/bin/python

import argparse
import numpy as np
import pandas as pd
import scipy.integrate

parser = argparse.ArgumentParser(
    description="Interporlate energy historgram into a discritization grid and normalize")
parser.add_argument('hist_dataset',
    help="Input dataset with energy histogram data (CSV)")
parser.add_argument('--output', '-o',
    help="Output file where to save the interpolated histogram dataset (CSV)")
parser.add_argument('--grid', '-g', nargs=3, metavar=['FROM', 'TO', 'STEP'],
    type=float, required=True,
    help='Grid of discrete points at which to interpolate')
args = parser.parse_args()

hist_dataset = pd.read_csv(args.hist_dataset)

grid = np.arange(args.grid[0], args.grid[1], args.grid[2])

hist_data = np.interp(grid, hist_dataset['energy'], hist_dataset['count'],
                      left=0, right=0)

norm_hist_data = hist_data / scipy.integrate.simps(hist_data, grid)

hist_data_df = pd.DataFrame(dict(energy=grid, count=norm_hist_data))
hist_data_df.to_csv(args.output, index=False)
