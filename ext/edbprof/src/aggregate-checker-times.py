#!/usr/bin/python

import argparse
import pandas as pd
import re
import os

parser = argparse.ArgumentParser(
    description="Aggregate times checker took to predict outcome")
parser.add_argument('failure_prob_datasets', nargs='+',
    help="Input datasets (failure probabilities) with checker time column (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save aggregated completion dataset")
parser.add_argument('--instances', required=True,
    help="Input dataset with additional ininstance info keyed by instance ID (CSV)")
args = parser.parse_args()

instances_dataset = pd.read_csv(args.instances)

instances = []
outcomes = []
exec_times = []

elapsed_sec = []

for dataset_filename in args.failure_prob_datasets:
    dataset = pd.read_csv(dataset_filename)

    # filename will be instances/*/*.csv, we extract the *
    instances.append(os.path.basename(os.path.dirname(dataset_filename)))

    total_time = dataset['elapsed_sec'].sum()
    elapsed_sec.append(total_time)

# join keyed on instance ID
checker_time = pd.DataFrame(dict(instance=instances, checker_time_s=elapsed_sec))

checker_time = checker_time.set_index('instance')
instances_dataset["instance"] = instances_dataset['spec_id'] # copy index column
instances_dataset = instances_dataset.set_index('instance')

result_dataset = pd.concat([instances_dataset, checker_time], axis=1)
result_dataset.to_csv(args.output, index=False)
