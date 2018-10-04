#!/usr/bin/python

import argparse
import os
import pandas as pd

parser = argparse.ArgumentParser(
    description="Aggregate per-placer quantities across a range of capacity values")
parser.add_argument('instance_list',
    help='File with list of energy capacity instance names (CSV)')
parser.add_argument('--dir',
    help='Directory with the datasets for all instances')
parser.add_argument('--instance-dataset-name',
    help='File names for datasets stored in the given directory')
parser.add_argument('--quantity',
    help='Row/column name of the quantity being aggregated')
parser.add_argument('--output', '-o',
    help='Output filename for aggregate dataset (CSV)')
args = parser.parse_args()

instances = pd.read_csv(args.instance_list)

agg_dataset = pd.DataFrame()
for idx, row in instances.iterrows():
    instance_name = row['instance'] 

    completions_dataset_filename = os.path.join(args.dir, instance_name, args.instance_dataset_name)
    completions_dataset = pd.read_csv(completions_dataset_filename)

    flipped_completions_dataset = pd.DataFrame()
    for completions_idx, completions_row in completions_dataset.iterrows():
        flipped_completions_dataset = pd.concat([flipped_completions_dataset,
                                                 completions_row.T], axis=1)
    flipped_completions_dataset.columns = flipped_completions_dataset.loc['placer']
    flipped_completions_dataset = flipped_completions_dataset.loc[args.quantity]
    flipped_completions_dataset = pd.DataFrame(flipped_completions_dataset).T
    flipped_completions_dataset.index = pd.Index([row['capacity']], name='capacity')

    agg_dataset = pd.concat([agg_dataset, flipped_completions_dataset])

agg_dataset.to_csv(args.output, index=True)
