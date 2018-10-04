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
args = parser.parse_args()

completions_dataset = pd.read_csv(args.completions_dataset)

#pl.plot(completions_dataset['boundary_count'], completions_dataset['fraction_completed'])
columns = ['boundary_count', 'fraction_correct', 'fraction_false_positives', 'fraction_false_negatives']
completions_dataset = completions_dataset[columns]
completions_dataset = completions_dataset.set_index('boundary_count')
completions_dataset.plot(marker='o')

pl.ylabel("Fraction of correct predictions")
pl.xlabel("Number of task boundaries")

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
