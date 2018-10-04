#!/usr/bin/python

import os
import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Split energy distribution expressions into folders")
parser.add_argument('expr_dataset', nargs='+',
            help="Input dataset with a list of expressions (CSV)")
parser.add_argument('--var', '-v',
            help="Variable name to store the list in (Makefile syntax)")
parser.add_argument('--output', '-o',
            help="Output file where to write the list of paths in Makefile syntax")
parser.add_argument('--dir', '-d',
            help="Directory where to create directories for each expression")
args = parser.parse_args()


def create_dir(path):
    if not os.path.isdir(path):
        os.mkdir(path)

create_dir(args.dir)

rules = open(args.output, 'w')
rules.write(args.var + ' = \\\n')

for expr_dataset_filename in args.expr_dataset:
    d = pd.read_csv(expr_dataset_filename)
    for idx, row in d.iterrows():
        path_id = str(row['path']) + '--' + row['task'] + '--' + str(row['tail'])
        expr = row['energy_expr']

        dir_path = os.path.join(args.dir, path_id)
        create_dir(dir_path)

        expr_file_path = os.path.join(dir_path, 'expr.csv')
        path_file_path = os.path.join(dir_path, 'path.csv')
        path_elems_file_path = os.path.join(dir_path, 'path.txt')

        rules.write(dir_path + " \\\n")

        fout = open(expr_file_path, "w")
        fout.write("path,task,tail,energy_expr\n") # CSV header
        fout.write(",".join([str(row['path']), row['task'], row['tail'], '"' + row['energy_expr'] + '"']) + "\n")

        fout = open(path_file_path, "w")
        fout.write("path,task,tail\n") # CSV header
        fout.write(",".join([str(row['path']), row['task'], row['tail']]) + "\n")

        fout = open(path_elems_file_path, "w")
        fout.write(row['path_elems'])
