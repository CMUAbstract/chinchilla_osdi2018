#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl
import seaborn as sb

parser = argparse.ArgumentParser(
    description="Plot conditional probability of completion given start energy")
parser.add_argument('cond_prob_comp',
    help="Input dataset with conditional probability of failure (CSV)")
parser.add_argument('--output', '-o',
    help="Output file where to save plot")
args = parser.parse_args()

cond_prob_comp = pd.read_csv(args.cond_prob_comp)

cond_prob_comp = cond_prob_comp.set_index("start_energy")
cond_prob_comp.plot()

pl.xlabel("Energy (uJ)")
pl.ylabel("Probability")

if args.output is not None:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
