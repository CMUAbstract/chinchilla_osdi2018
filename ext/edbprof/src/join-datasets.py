#!/usr/bin/python

import argparse
import pandas as pd

def csv_list(s):
    return s.split(',')

parser = argparse.ArgumentParser(
    description="Join datasets")
parser.add_argument('datasets', nargs='+',
    help="Input datasets to join (CSV)")
parser.add_argument('--on', type=csv_list,
    help="Column(s) name to join on (comma-delimited list)")
parser.add_argument('--how', default='left',
    help="Join mode")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save accuracy dataset (CSV)")
args = parser.parse_args()

d = pd.read_csv(args.datasets[0])

for i in range(1, len(args.datasets)):
    d_right = pd.read_csv(args.datasets[i])

    if args.on is not None:
        d_right = d_right.set_index(args.on)

    d = d.join(d_right, on=args.on, how=args.how)

d.to_csv(args.output, index=False)
