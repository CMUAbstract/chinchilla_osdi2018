#!/usr/bin/python

import argparse
import os
import pandas as pd
import pylab as pl

from plot import *

parser = argparse.ArgumentParser(
    description="Plot checker accuracy vs energy capacity")
parser.add_argument('accuracy_dataset',
    help='Input dataset with aggregate accuracy stats (CSV)')
parser.add_argument('--output', '-o',
    help='Output file where to save the plot (format by extension)')
parser.add_argument('--markers', action='store_true', default=True,
    help="Marker for datapoints (e.g. 'o')")
args = parser.parse_args()

accuracy_dataset = pd.read_csv(args.accuracy_dataset)
accuracy_dataset = accuracy_dataset.set_index('capacity')

cm = pl.get_cmap('gray')

pl.title("Checker accuracy on random boundary placements")
pl.xlabel("Energy capacity available on the device (uJ)")
pl.ylabel("Fraction of boundary placements")

columns = ['fraction_correct', 'fraction_false_positives', 'fraction_false_negatives']
#columns = ['correct', 'false_positives', 'false_negatives']
markers = ['s', '^', 'v']
for idx, column in enumerate(columns):
    marker = markers[idx] if args.markers else None
    pl.plot(accuracy_dataset.index, accuracy_dataset[column],
            label=PRETTY_ACCURACY_NAMES[column],
            marker=marker, markevery=16, color=cm(idx * 1.0 / len(accuracy_dataset.columns)))

pl.legend(loc=0)

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
