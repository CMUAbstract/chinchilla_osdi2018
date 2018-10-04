#!/usr/bin/python

# Execute edb.py one BB at a time
# Written by: Preeti U Murthy <preetium>
import argparse
import sys
import re
import subprocess
import numpy as np
import pandas as pd
import os

parser = argparse.ArgumentParser(
            description="Calculate energy cost of all paths")
parser.add_argument('paths_file',
            help="Input file with the list of paths")
parser.add_argument('profile_file',
            help="Output file with path energy costs (CSV)")
parser.add_argument('--block-hash-map', '-m',
            help="File with a map from block name to block hash")
parser.add_argument('--blocks-dir', '-b',
            help="Input directory with stats files for each block")
parser.add_argument('--suffix', default='.energy-stats.csv',
            help="Suffix to append after block hash to construct name of energy stats file")
args = parser.parse_args()

def get_energy_for_path(func_name, path):
    path_energy_mean = 0
    path_energy_var = 0

    for blk in path:
        blk, repetitions = blk.split('*')
        repetitions = int(repetitions)
        blk_key = func_name + ":" + blk
        if blk_key not in block_hash_map:
            return None # path filtered out by request

        blk_hash = block_hash_map[blk_key]

        blk_stats_fname = os.path.join(args.blocks_dir, blk_hash + args.suffix)
        blk_stats = pd.read_csv(blk_stats_fname)

        block_energy = blk_stats['block_energy_J']
        path_energy_mean += repetitions * block_energy.mean()
        path_energy_var += repetitions * block_energy.std()**2

    return path_energy_mean, path_energy_var

# Read block id -> block hash map into a dictionary
block_hash_map = {}
for line in open(args.block_hash_map, "r"):
    block_name, block_hash = line.split()
    block_hash_map[block_name] = block_hash

fp_energy = open(args.profile_file, "w")
fp_energy.write("func,path,e_mean_J,e_var\n")

# go through the path file and generate energy per path
for line in open(args.paths_file,'r+'):
    line = line.strip()
    if len(line) == 0:
        continue

    func_name, path = line.split(':')
    path = path.split()
    path_energy = get_energy_for_path(func_name, path)
    if path_energy is None: # path was filtered out by request
        continue
    path_energy_mean, path_energy_var = path_energy
    line = line.rstrip('\n')
    fp_energy.write('"%s","%s",%e,%e\n' % \
            (func_name, line, path_energy_mean, path_energy_var))
