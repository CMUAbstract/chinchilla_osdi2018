#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl

parser = argparse.ArgumentParser(
    description="Pretty-print a path logged by task energy estimator pass")
parser.add_argument('path',
    help="Input file with the raw path string")
parser.add_argument('--output', '-o',
    help="Output file with the formatted path")
args = parser.parse_args()

path = open(args.path).read()

path = path.replace(';', '\n;')
path = path.replace('+', '\n  +')
path = path.replace('|', '\n    |')

print(path)

if args.output:
    fout = open(args.output, "w")
    fout.write(path)
