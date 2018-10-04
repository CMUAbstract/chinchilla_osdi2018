#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Add a column to a dataset")
parser.add_argument('dataset',
    help="Input datasets to be labeled (CSV)")
parser.add_argument('--column', '-c', required=True,
    help="Name of column to add")
parser.add_argument('--value', '-v',
    help="Value to fill into the new column")
parser.add_argument('--value-file',
    help="File with a dataset that cointains the label (CSV)")
parser.add_argument('--value-column',
    help="Column in the dataset that contains the value (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save resulting dataset (CSV)")
args = parser.parse_args()

d = pd.read_csv(args.dataset)
if args.value_file is not None:
    vf = pd.read_csv(args.value_file)
    value = vf[args.value_column][0]
else:
    value = args.value
d[args.column] = value
d.to_csv(args.output, index=False)
