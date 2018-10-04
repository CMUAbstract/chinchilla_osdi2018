#!/usr/bin/python

import argparse
import sys
import re
import pandas as pd

parser = argparse.ArgumentParser(
            description="Map task IDs (assigned by path profiler) to task names")
parser.add_argument('path_profile',
            help="Path frequency profile (CSV)")
parser.add_argument('--output', '-o',
            help="Output file with path frequency profile with task names (CSV)")
parser.add_argument('--task-id-map', required=True,
            help="File with map from task ID to task name (CSV)")
args = parser.parse_args()

task_names = {}
task_id_map_dataset = pd.read_csv(args.task_id_map)
for idx, row in task_id_map_dataset.iterrows():
    func = row['func']
    task_id = row['task_id']
    if func not in task_names:
        task_names[func] = {}
    task_names[func][task_id] = row['task_name']

prof = pd.read_csv(args.path_profile)
prof['task_id'] = prof.apply(lambda row: task_names[row['func']][row['task_id']], axis=1)

prof.to_csv(args.output, index=False)
