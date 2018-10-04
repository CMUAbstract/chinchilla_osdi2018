#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl
import seaborn as sb

parser = argparse.ArgumentParser(
    description="Plot binned failure counts")
parser.add_argument('binned_outcomes',
    help="Input dataset with binned outcomes (CSV)")
parser.add_argument('--output', '-o',
    help="Output file where to save the plot")
args = parser.parse_args()

binned_outcomes = pd.read_csv(args.binned_outcomes)

binned_outcomes = binned_outcomes.set_index("energy_bottom")
binned_outcomes[["successes_frac_1", "successes_frac_2"]].plot()

if args.output is not None:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
