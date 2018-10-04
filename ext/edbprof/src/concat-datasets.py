#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Concatenate multiple datasets (in rows dimension)")
parser.add_argument('datasets', nargs='+',
    help="Input datasets to be concatenated (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save concatenated dataset (CSV)")
args = parser.parse_args()

result = pd.DataFrame()

for dataset_file in args.datasets:
    d = pd.read_csv(dataset_file)

    result = pd.concat([result, d])

result.to_csv(args.output, index=False)
