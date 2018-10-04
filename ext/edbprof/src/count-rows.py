#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Count number of rows in a dataset")
parser.add_argument('dataset',
    help="Input datasets to be labeled (CSV)")
parser.add_argument('--column', '-c', required=True,
    help="Name of column to store result in")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save resulting count dataset (CSV)")
args = parser.parse_args()

d = pd.read_csv(args.dataset)
count = d.count()[0]
result_dict = dict()

result_dict[args.column] = count
result = pd.DataFrame(result_dict, index=[0])

result.to_csv(args.output, index=False)
