#!/usr/bin/python

import argparse
import pandas as pd

# TODO: once factored, this will include dist.py only
from dist_expr_evaluator import DistExprEvaluator

parser = argparse.ArgumentParser(
    description="Calculate statistics about a distribution")
parser.add_argument('dist_dataset',
    help="Input dataset with the distribution (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the statistics dataset (CSV)")
parser.add_argument('--path', '-p', required=True,
    help="Dataset with the path identifier (CSV)")
args = parser.parse_args()

path_df = pd.read_csv(args.path)
path_row = path_df.loc[0]
task = path_row['task']
path = path_row['path']

dist_df = pd.read_csv(args.dist_dataset)

dist = DistExprEvaluator.Dist(grid=None,
                              pdf_data_x=dist_df['energy'], 
                              pdf_data_y=dist_df['count'])

exp_value = dist.expectation()
max_value = dist.max()

stats = pd.DataFrame(dict(task=task, path=path,exp_value=exp_value, max_value=max_value), index=[0])
stats.to_csv(args.output, index=False)
