#!/usr/bin/python

import argparse
import sys
import re
import pandas as pd

parser = argparse.ArgumentParser(
            description="Split path frequency profile for a program into per-module profiles")
parser.add_argument('program_path_profile',
            help="Path frequency profile for the whole program")
parser.add_argument('--suffix', '-s', required=True,
            help="Suffix for output files with per-module profiles")
args = parser.parse_args()

program_prof = pd.read_csv(args.program_path_profile)

for mod, group in program_prof.groupby('mod'):
    group.to_csv(mod + args.suffix, index=False)

