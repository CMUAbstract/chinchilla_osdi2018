#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Aggregate app completions by boundary count")
parser.add_argument('completions_dataset',
    help="Input dataset with observed app completions for a set of placements (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save aggregated dataset (CSV)")
args = parser.parse_args()

completions_dataset = pd.read_csv(args.completions_dataset)

completions_by_boundary_count = completions_dataset.groupby('boundary_count')

completed_observed = completions_by_boundary_count[['completed']].sum()
total = completions_by_boundary_count['completed'].count()
completed_observed['total'] = total

completed_observed['fraction_completed'] = completed_observed['completed'] / total

completed_observed.to_csv(args.output)
