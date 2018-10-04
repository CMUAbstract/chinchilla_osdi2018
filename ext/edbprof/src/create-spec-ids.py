#!/usr/bin/python

import argparse
import pandas as pd
import os

parser = argparse.ArgumentParser(
    description="Create a file in each instance directory identifying the instance")
parser.add_argument('specs_dataset',
    help="Input dataset with the the list of spec ids (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to mark completion (dummy)")
parser.add_argument('--dir', '-d', required=True,
    help="Directory where the instances to be identified are")
parser.add_argument('--filename', '-f', required=True,
    help="Name of output files with the instance id (CSV)")
args = parser.parse_args()

specs_df = pd.read_csv(args.specs_dataset)

for i, row in specs_df.iterrows():
    spec_id = row['spec_id']
    path = os.path.join(args.dir, spec_id, args.filename)
    fout = open(path, "w")
    fout.write("spec_id,boundary_count,sample_index\n") # CSV header
    fout.write(",".join([spec_id, str(row['boundary_count']), str(row['sample_index'])]) + "\n")

open(args.output, "w") # dummy for make
