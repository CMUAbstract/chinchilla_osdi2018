#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Aggregate checker accuracy as a function of boundary count")
parser.add_argument('accuracy_dataset',
    help="Input dataset with checker accuracy for a set of placements (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save aggregated dataset (CSV)")
args = parser.parse_args()

accuracy_dataset = pd.read_csv(args.accuracy_dataset)

accuracy_by_boundary_count = accuracy_dataset.groupby('boundary_count')

completed_predicted = accuracy_by_boundary_count['completed_predicted'].sum()
completed_observed = accuracy_by_boundary_count['completed_observed'].sum()

total = accuracy_by_boundary_count['spec_id'].count()

agg_accuracy_dataset = pd.DataFrame()
for boundary_count, accuracy in accuracy_by_boundary_count:
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
                                 index=pd.Index([boundary_count], name='boundary_count'))

    agg_accuracy_dataset = pd.concat([agg_accuracy_dataset, accuracy_group], axis=0)

agg_accuracy_dataset.to_csv(args.output, index=True)
