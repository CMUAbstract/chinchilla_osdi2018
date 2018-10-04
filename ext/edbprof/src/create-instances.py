#!/usr/bin/python

import os
import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Create list of instances as a makefile var")
parser.add_argument('instances_dataset',
            help="Input dataset with a list of instances (CSV)")
parser.add_argument('--columns', '-c', nargs='+',
            help="List of columns that identify an instance (first column must be the ID)")
parser.add_argument('--var', '-v',
            help="Variable name to store the list in (Makefile syntax)")
parser.add_argument('--output', '-o',
            help="Output file where to write the list of paths in Makefile syntax")
parser.add_argument('--dir', '-d',
            help="Directory where to the instance directories are")
args = parser.parse_args()


def create_dir(path):
    if not os.path.isdir(path):
        os.mkdir(path)

create_dir(args.dir)

id_column = args.columns[0]

rules = open(args.output, 'w')
rules.write(args.var + ' = \\\n')

d = pd.read_csv(args.instances_dataset)
for idx, row in d.iterrows():
    instance_id = row[id_column]

    instance_dir = os.path.join(args.dir, instance_id)
    rules.write("\t" + instance_dir + " \\\n")

    create_dir(instance_dir)

    instance_id_path = os.path.join(instance_dir, 'instance.csv')

    fout = open(instance_id_path, "w")
    fout.write(",".join(args.columns) + "\n") # CSV header
    fout.write(",".join(map(lambda c: str(row[c]), args.columns)) + "\n")
