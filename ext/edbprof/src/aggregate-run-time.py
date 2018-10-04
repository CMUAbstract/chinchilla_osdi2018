#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Aggregate execution times of checker and placer on the single instance")
parser.add_argument('checker_times_dataset',
    help="Input dataset with checker times (CSV)")
parser.add_argument("placer_times_dataset",
    help="Input dataset with placer times (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the table (.tex)")
args = parser.parse_args()

checker_times = pd.read_csv(args.checker_times_dataset)
placer_times = pd.read_csv(args.placer_times_dataset)

checker_times.columns = ['checker_run_time']
placer_times.columns = ['placer_run_time']

times = pd.concat([checker_times, placer_times], axis=1)
times.to_csv(args.output, index=False)
