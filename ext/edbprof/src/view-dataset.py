#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Load and display a dataset")
parser.add_argument('dataset',
    help="Input file with the dataset (CSV)")
parser.add_argument('--describe', '-d', action='store_true',
    help="Show descriptive statistics")
parser.add_argument('--width', '-w', type=int, default=1024,
    help="Display width for Pandas display options (CSV)")
parser.add_argument('--rows', '-r', type=int, default=1024,
    help="Max rows to display")
args = parser.parse_args()

pd.set_option('display.width', args.width)
pd.set_option('display.max_rows', args.rows)

d = pd.read_csv(args.dataset)
print(d)
if args.describe:
    print(d.describe())
