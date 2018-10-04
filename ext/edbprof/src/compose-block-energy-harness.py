#!/usr/bin/python

import argparse
import re
import random

from nvmem import *

parser = argparse.ArgumentParser(
            description="Compose the source code of the harness binary for measuring block energy")
parser.add_argument('template',
            help="Path to assembly code file with placeholder macro")
parser.add_argument('block',
            help="Path to asm file with the block instructions")
parser.add_argument('--out', '-o', required=True,
            help="Output file with the source code for the harness binary")
parser.add_argument('--replicate', action='store_true',
            help="Wether to eeplicate the blocks to improve measurement accuracy " + \
                 "(requires --instructions-per-trial)")
parser.add_argument('--instructions-per-trial', type=int, default=1000,
            help="Maximum number of instructions that finish on one capacitor charge")
parser.add_argument('--randomize-addrs', action='store_true',
            help="Wether to randomize the addresses of non-volatile memory accesses (anti-caching)")
args = parser.parse_args()

BLOCK_PLACEHOLDER = r"BLOCK_PLACEHOLDER"

random.seed(42) # so that output is deterministic

harness = open(args.out, "w")

block_placeholder_found = False

for line in open(args.template):
    if re.search(BLOCK_PLACEHOLDER, line):
        block_placeholder_found = True
        block_instr_count = 0
        for line in  open(args.block):
            block_instr_count += 1

        num_replicas = max(1, int(args.instructions_per_trial / block_instr_count))
        harness.write("; replication count: %d\n" % num_replicas);
        for r in range(num_replicas):
            for line in open(args.block):

                if args.randomize_addrs:
                    # Mitigate cache effects by choosing a random address in the given range
                    if re.search(EDBPROF_NVMEM_REGION_SYM, line):
                        offset = int(random.random() * (EDBPROF_NVMEM_REGION_SIZE / 2 - 1)) * 2
                        line = line.replace(EDBPROF_NVMEM_REGION_SYM, EDBPROF_NVMEM_REGION_SYM + ("+%u" % offset))
                harness.write(line)
    else:
        harness.write(line)

if not block_placeholder_found:
    raise Exception("Block placeholder not found in app source: " + BLOCK_PLACEHOLDER)
