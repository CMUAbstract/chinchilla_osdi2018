#!/usr/bin/python

import os
import pandas as pd
import argparse

parser = argparse.ArgumentParser(
    description="Extract a group from a datset")
parser.add_argument('dataset',
    help="Input file with the dataset (CSV)")
parser.add_argument('--column', required=True,
    help="Column which identifies the group to extract (CSV)")
parser.add_argument('--value', required=True, type=float,
    help="Value that identifies the group to extract (CSV)")
parser.add_argument('--type',
    help="Value that identifies the group to extract (CSV)")
parser.add_argument('--output', '-o',
    help="Output filename to save the extracted dataset (CSV)")
args = parser.parse_args()

if args.type == 'float':
    type_func = float
elif args.type == 'int':
    type_func = int
else:
    type_func = str

d = pd.read_csv(args.dataset)

g = d.groupby(args.column)
for v, subset in g:
    if v == type_func(args.value):
        r = subset

r.to_csv(args.output, index=False)

