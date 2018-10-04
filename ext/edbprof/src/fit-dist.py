#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
            description="Fit a distribution to a data series")
parser.add_argument('series',
            help="input dataset with data series (CSV)")
parser.add_argument('--column', required=True
            help="name of the column in the dataset to operate on")
parser.add_argument('--output', '-o',
            help="output dataset with distribution parameters (CSV)")
parser.add_argument('--dist', type=str.upper,
            default='NORM', choices=['NORM'],
            help="distribution to fit")
args = parser.parse_args()

d = pd.read_csv(args.series)

if args.dist == "NORM":
    mean = d[args.column].mean()
    var = d[args.column].std() ** 2

    params = pd.DataFrame(dict(mean=mean, var=var))

params.to_csv(args.output, index=False)
