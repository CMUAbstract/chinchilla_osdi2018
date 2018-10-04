#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl

parser = argparse.ArgumentParser(
    description="Plot app completions as a function of boundary count")
parser.add_argument('completions_dataset',
    help="Input dataset with app completions grouped by boundary count(CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save plot (format by extension)")
parser.add_argument('--range', '-r', nargs=2, metavar=['FROM', 'TO'],
    type=int, help="X-axis range")
args = parser.parse_args()

completions_dataset = pd.read_csv(args.completions_dataset)

completions_dataset = completions_dataset.set_index('boundary_count')

if args.range:
    completions_dataset = completions_dataset.iloc[args.range[0]:args.range[1]]

pl.plot(completions_dataset.index, completions_dataset['fraction_completed'],
        marker='o')

pl.ylabel("Fraction of valid placements")
pl.xlabel("Number of task boundaries")

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
