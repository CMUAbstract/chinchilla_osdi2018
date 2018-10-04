#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Join predicted and observed datasets")
parser.add_argument('predicted_dataset',
    help="Input dataset with predicted outcomes (CSV)")
parser.add_argument('observed_dataset',
    help="Input dataset with observedoutcomes (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save joined dataset (CSV)")
args = parser.parse_args()

result = pd.DataFrame()

d_predicted = pd.read_csv(args.predicted_dataset)
d_observed = pd.read_csv(args.observed_dataset)

if d_observed['outcome'][0]:
    observed_column = [True]
else:
    observed_column = [False]
observed_column *= len(d_predicted)

result = pd.concat([d_predicted, pd.DataFrame(dict(observed_completes=observed_column))], axis=1)

result.to_csv(args.output, index=False)
