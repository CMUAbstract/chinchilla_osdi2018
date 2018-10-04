#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Calculate false-positive/negative stast from accuracy dataset")
parser.add_argument('accuracy_dataset',
    help="Input dataset with observed and predicted program completion outcomes (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save accuracy stats dataset (CSV)")
args = parser.parse_args()

accuracy = pd.read_csv(args.accuracy_dataset)

total = accuracy.count()[0]
correct = ((accuracy['completed_predicted'] & accuracy['completed_observed']) | \
           (~accuracy['completed_predicted'] & ~accuracy['completed_observed'])).sum()
false_negatives = (~accuracy['completed_predicted'] & accuracy['completed_observed']).sum()
false_positives = (accuracy['completed_predicted'] & ~accuracy['completed_observed']).sum()

stats_dataset = pd.DataFrame(dict(total=[total], correct=[correct],
                                 false_negatives=[false_negatives],
                                 false_positives=[false_positives]),
                             index=[0])

stats_dataset.to_csv(args.output, index=False)
