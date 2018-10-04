#!/usr/bin/python

import argparse
import pandas as pd
import numpy as np

parser = argparse.ArgumentParser(
    description="Aggregate per-path accuracy accross placements")
parser.add_argument('accuracy_dataset',
    help="Input dataset with the accuracy stats per placement (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the aggregated accuracy dataset (CSV)")
args = parser.parse_args()

accuracy_all_df = pd.read_csv(args.accuracy_dataset)
accuracy_by_pth = accuracy_all_df.groupby('pth')

accuracy_df = pd.DataFrame(index = ['total', 'num_fp', 'num_fn', 'num_correct', 'frac_correct', 'frac_fp', 'frac_fn', 'pth'])

for pth, accuracy_pth_df in accuracy_by_pth:

    agg_accuracy = accuracy_pth_df[['total', 'num_fp', 'num_fn', 'num_correct']].sum()

    total = agg_accuracy['total']
    num_correct = agg_accuracy['num_correct']
    num_fp = agg_accuracy['num_fp']
    num_fn = agg_accuracy['num_fn']

    agg_accuracy['frac_correct'] = num_correct / total
    agg_accuracy['frac_fp'] = num_fp / total
    agg_accuracy['frac_fn'] = num_fn / total
    agg_accuracy['pth'] = pth

    agg_accuracy.name = pth

    #print(agg_accuracy.index)
    #agg_accuracy = agg_accuracy.T
    #agg_accuracy_df = pd.DataFrame(agg_accuracy, index=[pth])
    #print(agg_accuracy_df)

    accuracy_df = pd.concat([accuracy_df, agg_accuracy], axis=1)

accuracy_df.index.name = 'pth'
accuracy_df = accuracy_df.T
accuracy_df.to_csv(args.output, index=True)
