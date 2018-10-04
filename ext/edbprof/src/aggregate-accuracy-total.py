#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Calculate false-positive/negative stast from accuracy dataset")
parser.add_argument('accuracy_dataset',
    help="Input dataset with observed and predicted program completion outcomes grouped by boundary count (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save accuracy stats dataset (CSV)")
parser.add_argument('--range', nargs=2, metavar=['FROM', 'TO'],
    type=int, help="X-axis range (boundary count)")
args = parser.parse_args()

accuracy_by_boundary_count = pd.read_csv(args.accuracy_dataset)

if args.range:
    accuracy_by_boundary_count = accuracy_by_boundary_count.set_index('boundary_count')
    accuracy_by_boundary_count = accuracy_by_boundary_count.iloc[args.range[0]:args.range[1]]

count_columns = ["total", "correct", "false_positives", "false_negatives",
                 "completed_observed", "failed_observed"]
accuracy = accuracy_by_boundary_count[count_columns].sum()
accuracy = pd.DataFrame(accuracy).T

total = accuracy["total"]
accuracy["fraction_correct"] = accuracy["correct"] / total
accuracy["fraction_false_positives"] = accuracy["false_positives"] / total
accuracy["fraction_false_negatives"] = accuracy["false_negatives"] / total

accuracy.to_csv(args.output, index=False)
