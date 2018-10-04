#!/usr/bin/python

import argparse
import pandas as pd
import numpy as np

parser = argparse.ArgumentParser(
    description="Aggregate checker accuracy as a function of boundary count")
parser.add_argument('accuracy_dataset',
    help="Input dataset with checker accuracy for a set of placements (CSV)")
parser.add_argument('--group', '-g', required=True,
    help="Name of column to group by")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save aggregated dataset (CSV)")
args = parser.parse_args()

accuracy_dataset = pd.read_csv(args.accuracy_dataset)
#accuracy_dataset = accuracy_dataset.dropna(subset=['completed_observed'])
#accuracy_dataset = accuracy_dataset[(accuracy_dataset['completed_observed'] == True) | \
                                    #(accuracy_dataset['completed_observed'] == False)]
#print("accuracy=", accuracy_dataset)

accuracy_grouped = accuracy_dataset.groupby(args.group)

completed_predicted = accuracy_grouped['completed_predicted'].sum()
completed_observed = accuracy_grouped['completed_observed'].sum()

total = accuracy_grouped['spec_id'].count()

agg_accuracy_dataset = pd.DataFrame()
for group, accuracy in accuracy_grouped:
    total = accuracy['spec_id'].count()

    completed_observed = accuracy['completed_observed'].sum()
    failed_observed = (~accuracy['completed_observed']).sum()

    correct = ((accuracy['completed_predicted'] & accuracy['completed_observed']) | \
               (~accuracy['completed_predicted'] & ~accuracy['completed_observed'])).sum()
    false_negatives = (~accuracy['completed_predicted'] & accuracy['completed_observed']).sum()
    false_positives = (accuracy['completed_predicted'] & ~accuracy['completed_observed']).sum()

    accuracy_group = pd.DataFrame(dict(total=[total], correct=[correct],
                                     false_negatives=[false_negatives],
                                     false_positives=[false_positives],
                                     completed_observed=completed_observed,
                                     failed_observed=failed_observed,
                                     fraction_correct=[correct / total],
                                     fraction_false_negatives=[false_negatives / total],
                                     fraction_false_positives=[false_positives / total]),
                                 index=pd.Index([group], name='group'))

    agg_accuracy_dataset = pd.concat([agg_accuracy_dataset, accuracy_group], axis=0)

agg_accuracy_dataset.to_csv(args.output, index=True)
