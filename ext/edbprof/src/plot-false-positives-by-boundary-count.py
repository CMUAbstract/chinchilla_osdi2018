#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl

from plot import *

parser = argparse.ArgumentParser(
    description="Plot app completions as a function of boundary count")
parser.add_argument('completions_dataset',
    help="Input dataset with app completions grouped by boundary count(CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save plot (format by extension)")
parser.add_argument('--placer',
    help="Name of placer to indicate boundary count for")
parser.add_argument('--boundary-placement',
    help="Input dataset with boundary placement for plotting boundary count (CSV)")
parser.add_argument('--boundary-count-range', type=int, nargs=2,
    metavar=['XMIN', 'XMAX'],
    help="X-axis range")
args = parser.parse_args()

completions_dataset = pd.read_csv(args.completions_dataset)

#pl.plot(completions_dataset['boundary_count'], completions_dataset['fraction_completed'])
columns = ['boundary_count', 'fraction_correct', 'fraction_false_positives', 'fraction_false_negatives']
completions_dataset = completions_dataset[columns]
completions_dataset = completions_dataset.set_index('boundary_count')

false_positives = completions_dataset['fraction_false_positives'] * 100

label = PRETTY_ACCURACY_NAMES['fraction_false_positives']
#label = ""
pl.plot(completions_dataset.index, false_positives,
        label=label, color='k')

if args.boundary_placement:
    boundary_placement = pd.read_csv(args.boundary_placement)
    boundary_count = boundary_placement.count()[0]
    print("boundary_count=", boundary_count)
    pl.axvline(boundary_count, linestyle='--', color='gray',
               label='Number of boundaries\nauto-placed by ' + PRETTY_PLACER_NAMES[args.placer])
    pl.legend(loc=0)

pl.title("False-positive rate of CleanCut boundary validator")
pl.ylabel("False-positive rate (%)")
pl.xlabel("Number of boundaries in random task boundary placements")

if args.boundary_count_range:
    pl.xlim(args.boundary_count_range)
else:
    pl.xlim(xmin=0)

pl.ylim((0,100))

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
