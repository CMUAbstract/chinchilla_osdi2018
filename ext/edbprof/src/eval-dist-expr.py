#!/usr/bin/python

import argparse
import re
import numpy as np
import scipy.stats as stats
import pandas as pd
import os
import time

from dist_expr_evaluator import Grid, DistExprEvaluator
from dist_eval_args import *

parser = argparse.ArgumentParser(
    description="Evaluate the distribution expressions for path energies")
parser.add_argument('expr_dataset',
    help="Input dataset with path energy expression (CSV) or an expression")
parser.add_argument('--output', '-o',
    help="Output file where to save PDF data for the energy distribution (CSV)")
parser.add_argument('--grid', '-g', nargs=3, metavar=('FROM', 'TO', 'STEP'),
    type=float, required=True,
    help='Grid of discrete points at which to interpolate')
parser.add_argument('--verbose', action='store_true',
    help='Output paths for diagnosis')
add_dist_eval_args(parser)

args = parser.parse_args()

if args.expr_dataset[-4:] != '.csv':
    expr = args.expr_dataset
    task_id = 0
    path_idx = 0
else:
    expr_dataset = pd.read_csv(args.expr_dataset)
    expr = expr_dataset.iloc[0]['energy_expr']
    task_id = expr_dataset.iloc[0]['task']
    path_idx= expr_dataset.iloc[0]['path']

expr_evaluator = DistExprEvaluator(Grid(*args.grid),
                                   hist_data_path=args.hist_data_path,
                                   hist_data_column=args.hist_data_column,
                                   verbose=args.verbose)

start_time = time.time()

dist = expr_evaluator.eval_expr(expr)
pdf_data_x, pdf_data_y = dist.pdf()
d = pd.DataFrame(dict(energy=pdf_data_x, count=pdf_data_y))
elapsed_time_sec = time.time() - start_time

d.to_csv(args.output, index=False)
