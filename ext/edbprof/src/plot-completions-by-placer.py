#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl

from plot import *

parser = argparse.ArgumentParser(
    description="Plot app completions as a function of boundary count")
parser.add_argument('random_completions_dataset',
    help="Input dataset with app completions grouped by boundary count(CSV)")
parser.add_argument('greedy_placement',
    help="Input dataset Greedy boundary placement (CSV)")
parser.add_argument('manual_placement',
    help="Input dataset manual boundary placement (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save plot (format by extension)")
parser.add_argument('--range', nargs=2, metavar=['FROM', 'TO'],
    type=int, help="X-axis range (boundary count)")
args = parser.parse_args()

random_completions_dataset = pd.read_csv(args.random_completions_dataset)
greedy_placement = pd.read_csv(args.greedy_placement)
manual_placement = pd.read_csv(args.manual_placement)

num_boundaries_greedy = greedy_placement.count()[0]
num_boundaries_manual = manual_placement.count()[0]

print("num boundaries:", "greedy", num_boundaries_greedy,
                         "manual", num_boundaries_manual)

random_completions_dataset.set_index('boundary_count')

if args.range:
    random_completions_dataset = random_completions_dataset[args.range[0]:args.range[1]]

#random_boundary_counts = random_completions_dataset['boundary_count']
random_boundary_counts = random_completions_dataset.index

cm = pl.get_cmap('gray')

pl.plot(random_boundary_counts, random_completions_dataset['fraction_completed'],
        color='black', marker='o', label=PRETTY_PLACER_NAMES['random'])

pl.axvline(num_boundaries_greedy, label=PRETTY_PLACER_NAMES['greedy'],
           linestyle='--', color=cm(0.75))
pl.axvline(num_boundaries_manual, label=PRETTY_PLACER_NAMES['manual'],
           linestyle='--', color=cm(0.25))

# don't end the plot at a vertical line
pl.xlim(xmax=max(random_boundary_counts.max(), num_boundaries_greedy, num_boundaries_manual) + 1)

pl.ylabel("Fraction of valid placements")
pl.xlabel("Nubmer of task boundaries")
pl.legend(loc=0)

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
