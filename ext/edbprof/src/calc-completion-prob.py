#!/usr/bin/python

import argparse
import pandas as pd

# TODO: once factored, this will include dist.py only
from dist_expr_evaluator import DistExprEvaluator

parser = argparse.ArgumentParser(
    description="Calculate probability that a path completes " +
                "(evaluate the CDF at energy capacity)")
parser.add_argument('cdf_dataset',
    help="Input dataset with the distribution (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the statistics dataset (CSV)")
parser.add_argument('--path', '-p', required=True,
    help="Dataset with the path identifier (CSV)")
parser.add_argument('--capacity', '-c', required=True,
    help="Dataset with energy capacity of the device(CSV)")
args = parser.parse_args()

path_df = pd.read_csv(args.path)
path_row = path_df.loc[0]
path = path_row['path']
task = path_row['task']
tail = path_row['tail']

energy_capacity_params = pd.read_csv(args.capacity)
print("energy capacity: ", energy_capacity_params)
energy_capacity_mean = energy_capacity_params['mean'][0]
energy_capacity_var = energy_capacity_params['var'][0]

cdf_df = pd.read_csv(args.cdf_dataset)

dist = DistExprEvaluator.Dist(grid=None,
                              pdf_data_x=cdf_df['energy'].as_matrix(), 
                              cdf_data_y=cdf_df['cdf'].as_matrix())

completion_prob = dist.eval_cdf(energy_capacity_mean)

completion_prob_df = pd.DataFrame(dict(path=path, task=task, tail=tail,
                                       completion_prob=completion_prob), index=[0])
completion_prob_df.to_csv(args.output, index=False)
