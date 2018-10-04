#!/usr/bin/python

import argparse
import pandas as pd
import numpy as np
import re
import os

parser = argparse.ArgumentParser(
    description="Aggregate predicted program completion by Pth datasets across instances")
parser.add_argument('completion_datasets', nargs='+',
    help="Input datasets with program completion counts (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save aggregated completion dataset")
parser.add_argument('--instances', required=True,
    help="Input dataset with additional ininstance info keyed by instance ID (CSV)")
args = parser.parse_args()

instances_dataset = pd.read_csv(args.instances)

instances = []
outcomes = pd.DataFrame()
exec_times = []

for dataset_filename in args.completion_datasets:

    print("dataset_filename=", dataset_filename)

    # filename will be instances/*/*.csv, we extract the *
    spec_id = os.path.basename(os.path.dirname(dataset_filename))

    dataset = pd.read_csv(dataset_filename)
    dataset['completed'] = dataset['completion_prob'] >= dataset['pth']

    k = 0
    d_by_pth = dataset.groupby('pth')
    for pth, sub_pth in d_by_pth:
        program_completed = np.all(sub_pth['completed'])

        row = pd.DataFrame(dict(spec_id=spec_id, pth=pth,
                                completed_predicted=program_completed),
                           index=[k])
        k += 1
        outcomes = outcomes.append(row)


print("outcomes=", outcomes)
print("instances_datset=", instances_dataset)
result_dataset = outcomes.join(instances_dataset.set_index('spec_id'), on='spec_id')

#outcomes = outcomes.set_index('instance')
#instances_dataset["instance"] = instances_dataset['spec_id'] # copy index column
#instances_dataset = instances_dataset.set_index('instance')
#
#result_dataset = pd.concat([instances_dataset, outcomes], axis=1)
result_dataset.to_csv(args.output, index=False)
