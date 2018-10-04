#!/usr/bin/python

import argparse
import pandas as pd
import re
import os

parser = argparse.ArgumentParser(
    description="Aggregate observed/predicted program completion datasets across instances")
parser.add_argument('completion_datasets', nargs='+',
    help="Input datasets with program completion counts (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save aggregated completion dataset")
parser.add_argument('--instances', required=True,
    help="Input dataset with additional ininstance info keyed by instance ID (CSV)")
parser.add_argument('--mode', required=True, type=str.upper,
    choices=['OBSERVED', 'PREDICTED'],
    help="Which dataset type to aggregate")
args = parser.parse_args()

instances_dataset = pd.read_csv(args.instances)

instances = []
outcomes = []
exec_times = []

for dataset_filename in args.completion_datasets:

    print("dataset_filename=", dataset_filename)

    dataset = pd.read_csv(dataset_filename)

    # TODO: unify by homogenizing input datasets, remove mode switch
    if args.mode == 'OBSERVED':
        # Each row in the dataset corresponds to one run of the program to completion
        times = dataset["elapsed_sec"]
        program_completed = times.count() > 0
        exec_time = times.mean()
        exec_times.append(exec_time)

    elif args.mode == 'PREDICTED':

        program_completed = dataset['completed'][0]

    else:
        raise Exception("Unknown mode: " + args.mode)

    # filename will be instances/*/*.csv, we extract the *
    instances.append(os.path.basename(os.path.dirname(dataset_filename)))
    outcomes.append(program_completed)

# join keyed on instance ID
outcomes = pd.DataFrame(dict(instance=instances, completed=outcomes))

# we're not predicting execution times
if args.mode == 'OBSERVED':
    outcomes['elapsed_sec'] = exec_times

outcomes = outcomes.set_index('instance')
instances_dataset["instance"] = instances_dataset['spec_id'] # copy index column
instances_dataset = instances_dataset.set_index('instance')

result_dataset = pd.concat([instances_dataset, outcomes], axis=1)
result_dataset.to_csv(args.output, index=False)
