#!/usr/bin/python

import argparse
import re
import pandas as pd

parser = argparse.ArgumentParser(
            description="Calculate energy cost from an EDB watchpoint trace")
parser.add_argument('in_file',
            help="Input file with the energy delta result from a watchpoint trace (CSV)")
parser.add_argument('blk_file',
            help="Input file with the block instructions (to get replication count)")
parser.add_argument('out_file',
            help="Output file with the energy cost statistics (CSV)")
parser.add_argument('--capacitance', type=float, required=True,
            help="Size of energy storage capacitor on the device (uF)")
parser.add_argument('--replicate', action='store_true',
            help="Wether to eeplicate the blocks to improve measurement accuracy " + \
                 "(requires --instructions-per-trial)")
parser.add_argument('--instructions-per-trial', type=int, default=1000,
            help="Maximum number of instructions that finish on one capacitor charge")
args = parser.parse_args()

#if args.replicate:
#    block_instr_count = 0
#    for line in  open(args.blk_file):
#        block_instr_count += 1
#    num_replicas = max(1, int(args.instructions_per_trial / block_instr_count))
#else:
#    num_replicas = 1
num_replicas = 1

d = pd.read_csv(args.in_file)
d["delta_voltage_V"] = d["voltage_start_V"] - d["voltage_end_V"]
d["delta_energy_uJ"] = 0.5 * args.capacitance * (d["voltage_start_V"]**2 - d["voltage_end_V"]**2)
d["block_energy_uJ"] = d["delta_energy_uJ"] / num_replicas

print(d["block_energy_uJ"].describe())

d.to_csv(args.out_file, index=False, float_format='%e')
