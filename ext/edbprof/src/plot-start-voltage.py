#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl

parser = argparse.ArgumentParser(
    description="Plot start energy histogram")
parser.add_argument('start_energy_dataset',
    help="Input dataset with start energy (CSV)")
parser.add_argument('--output', '-o',
    help="Output file where to save start energy histogram plot")
args = parser.parse_args()

start_energy_dataset = pd.read_csv(args.start_energy_dataset)

start_energy_dataset["watchpoint_vcap"].hist()
pl.title("Start energy histogram")
pl.xlabel("Energy (J?)")
pl.ylabel("Count")
pl.xlim((1.8,2.4))

if args.output is not None:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
