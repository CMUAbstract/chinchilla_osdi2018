#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Calculate whether a path terminates" + 
                "based on completion probabily")
parser.add_argument('completion_prob_dataset',
    help="Input dataset with the path completion probabilities (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the outcome dataset (CSV)")
parser.add_argument('--threshold', '-t', type=float,
    help="Probability threshold that classifies into an outcome")
parser.add_argument('--threshold-instance',
    help="Dataset with probability threshold that classifies into an outcome")
args = parser.parse_args()

if args.threshold:
    threshold = args.threshold
else:
    threshold_df = pd.read_csv(args.threshold_instance)
    threshold = threshold_df.loc[0]['pth']

comp_prob_df = pd.read_csv(args.completion_prob_dataset)
comp_prob_df['predicted_completes'] = comp_prob_df['completion_prob'] >= threshold
comp_prob_df['pth'] = threshold

comp_prob_df.to_csv(args.output, index=False)
