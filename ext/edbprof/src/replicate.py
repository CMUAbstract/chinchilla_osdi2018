#!/usr/bin/python

# We measure the cost of multiple copies of the block pasted back to
# back, because of the limited resolution (can't measure the cost of
# short sequences of instructions).

import os
import argparse
import re
import hashlib

parser = argparse.ArgumentParser(
            description="Replicate basic block instructions for measurement harness")
parser.add_argument('in_source',
            help="Input assembly source code of a block")
parser.add_argument('out_source',
            help="Output assembly source file with replicated instructions")
parser.add_argument('--instructions-per-trial', type=int, default=1000,
            help="Maximum number of instructions that finish on one capacitor charge")
args = parser.parse_args()

block = ""
block_instr_count = 0
for line in  open(args.in_source, "r"):
    block += line
    block_instr_count += 1

replication_count = max(1, int(args.instructions_per_trial / block_instr_count))

bb_file_p = open(args.out_source, "w")
bb_file_p.write("/* replication count: %d */\n" % replication_count);

for i in range(replication_count):
    bb_file_p.write(block)
