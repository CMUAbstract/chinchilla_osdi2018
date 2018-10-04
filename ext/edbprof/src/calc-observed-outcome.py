#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Make one outcome boolean from a completion times dataset")
parser.add_argument('completion_times_dataset',
    help="Input dataset with the completion times (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the outcome dataset (CSV)")
args = parser.parse_args()

completion_times_df = pd.read_csv(args.completion_times_dataset)
outcome = len(completion_times_df) > 0

outcome_df = pd.DataFrame(dict(outcome=outcome), index=[0])
outcome_df.to_csv(args.output, index=False)
