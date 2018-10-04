#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Calculate whether program completes " + 
                "based on completion probabilies of paths")
parser.add_argument('completion_prob_dataset',
    help="Input dataset with the path completion probabilities (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the outcome dataset (CSV)")
parser.add_argument('--threshold', '-t', type=float, required=True,
    help="Probability threshold that classifies into an outcome")
args = parser.parse_args()

comp_prob_df = pd.read_csv(args.completion_prob_dataset)
outcome = comp_prob_df['completion_prob'].min() >= args.threshold

outcome_df = pd.DataFrame(dict(completed=outcome), index=[0])
outcome_df.to_csv(args.output, index=False)
