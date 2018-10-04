#!/usr/bin/python

import argparse
import re
import pandas as pd
import os

from block_map import BlockMap

parser = argparse.ArgumentParser(
    description="Compute stats for block energy and aggregate into one file")
parser.add_argument('block_map',
    help="Input file with the map from block name to block hash")
parser.add_argument('--output', '-o', required=True,
    help="Output file to which to save aggregated block energy dataset (CSV)")
parser.add_argument('--block-dir', '-d', required=True,
    help="Input directory with block energy dataset in CSV")
parser.add_argument('--energy-filename', required=True,
    help="Extension in the name sof block energy files")
args = parser.parse_args()

block_map = BlockMap(args.block_map)

fout = open(args.output, "w")
fout.write("func,block_name,block_hash,energy_mean,energy_sd\n")

for block_hash, func_name_pairs in block_map.items():
    for func_name_pair in func_name_pairs:
        func, block_name = func_name_pair
        block_fname = os.path.join(args.block_dir, str(block_hash), args.energy_filename)
        block_energy_dataset = pd.read_csv(block_fname)
        block_energy = block_energy_dataset['block_energy_uJ']

        fout.write("%s,%s,%s,%e,%e\n" % \
            (func, block_name, block_hash, block_energy.mean(), block_energy.std()))
