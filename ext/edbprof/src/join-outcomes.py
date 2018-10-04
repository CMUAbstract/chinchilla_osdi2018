#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Join predicted with observed outcomes per path, " +
                "infering ground truth outcome for a path from " +
                "the observed outcome for the program")
parser.add_argument('predicted_dataset',
    help="Input dataset with the predicted path completion outcomes (CSV)")
parser.add_argument('observed_dataset',
    help="Input dataset with the observed program completion outcome (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the outcome dataset (CSV)")
args = parser.parse_args()

predicted_df = pd.read_csv(args.predicted_dataset)
observed_df = pd.read_csv(args.observed_dataset)

joined_df = predicted_df

# Infer: take the program's value as the value for each path
joined_df['observed_completes'] = observed_df.loc[0]['outcome']

joined_df.to_csv(args.output, index=False)
