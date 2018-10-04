#!/usr/bin/python

import argparse
import os
import pandas as pd

parser = argparse.ArgumentParser(
    description="Aggregate accuracy stats across a range of capacity values")
parser.add_argument('instance_list',
    help='File with list of energy capacity instance names (CSV)')
parser.add_argument('--dir',
    help='Directory with the accuracy stats datasets for all instances (from checker-recall phase)')
parser.add_argument('--accuracy-dataset-name',
    help='File names for accuracy datasets stored in the given directory')
parser.add_argument('--output', '-o',
    help='Output filename for aggregate dataset with accuracy stats (CSV)')
args = parser.parse_args()

instances = pd.read_csv(args.instance_list)

agg_dataset = pd.DataFrame()
for idx, row in instances.iterrows():
    instance_name = row['instance'] 

    accuracy_dataset_filename = os.path.join(args.dir, instance_name, args.accuracy_dataset_name)
    accuracy_dataset = pd.read_csv(accuracy_dataset_filename)

    accuracy_dataset['capacity'] = row['capacity']
    agg_dataset = pd.concat([agg_dataset, accuracy_dataset])

agg_dataset.to_csv(args.output, index=False)
