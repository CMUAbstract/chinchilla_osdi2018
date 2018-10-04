#!/usr/bin/python

import argparse
import sys
import os
import pandas as pd

parser = argparse.ArgumentParser(
            description="Generate a makefile with rules that aggregate targets across instances")
parser.add_argument('targets', nargs='+',
            help="List of targets to aggregate")
parser.add_argument('--instances', '-i',
            help="Input dataset with a column of instance names (CSV)")
parser.add_argument('--column', '-c',
            help="Column name for the instances list data series")
parser.add_argument('--dir', '-d',
            help="Directory with instance folders")
parser.add_argument('--output', '-o', required=True,
            help="Name of the output makefile")
args = parser.parse_args()

if args.column is not None:
    header = 0 # first row is the header
else:
    header = None # no header

instances_dataset = pd.read_csv(args.instances, header=header)
if args.column is not None:
    instances = instances_dataset[args.column]
else:
    instances = instances_dataset.iloc[:, 0]

makefile = open(args.output, "w")

# TODO: should we define all targets in the actual makefile using INSTANCES var?
makefile.write('INSTANCES = ' + ' '.join(instances) + '\n\n')

for target in args.targets:

    def compose_instance_dir(instance):
        if args.dir:
            return os.path.join(args.dir, instance)
        return instance

    prereqs = map(lambda s: os.path.join(compose_instance_dir(s), target), instances)
    prereqs_str = " ".join(prereqs)
    makefile.write(target + ": " + prereqs_str + "\n\n")
