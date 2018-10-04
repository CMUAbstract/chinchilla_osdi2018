#!/usr/bin/python

import argparse
import pandas as pd
import re
import os

parser = argparse.ArgumentParser(
    description="Calculate predicted program completion from path failure probability")
parser.add_argument('failure_prob_dataset',
    help="Input dataset with path failure probability (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save predicted completion dataset (CSV)")
args = parser.parse_args()

failure_prob = pd.read_csv(args.failure_prob_dataset)

# Treat every task and every path equally; simply threshold
program_completed = (~failure_prob['outcome']).sum() == 0
print("count passed ", failure_prob['outcome'].sum()) 

completion_dataset = pd.DataFrame(dict(completed=program_completed), index=[0])
completion_dataset.to_csv(args.output, index=False)
