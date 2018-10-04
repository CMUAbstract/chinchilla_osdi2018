#!/usr/bin/python

import argparse
import pandas as pd

# TODO: once factored, this will include dist.py only
from dist_expr_evaluator import DistExprEvaluator

parser = argparse.ArgumentParser(
    description="Calculate CDF of a distribution from its PDF")
parser.add_argument('dist_dataset',
    help="Input dataset with the distribution (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the statistics dataset (CSV)")
args = parser.parse_args()

dist_df = pd.read_csv(args.dist_dataset)

dist = DistExprEvaluator.Dist(grid=None,
                              pdf_data_x=dist_df['energy'], 
                              pdf_data_y=dist_df['count'])

cdf_data_x, cdf_data_y = dist.cdf()

cdf_df = pd.DataFrame(dict(energy=cdf_data_x, cdf=cdf_data_y))
cdf_df.to_csv(args.output, index=False)
