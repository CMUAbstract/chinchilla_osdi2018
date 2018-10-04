#!/usr/bin/python

import argparse
import pandas as pd
import numpy as np
import os

parser = argparse.ArgumentParser(
    description="Generate instance directories for Pth axis")
parser.add_argument('list', type=float, nargs='*',
    help="List of values")
parser.add_argument('--range', type=float, nargs=3, metavar=['FROM', 'TO', 'STEP'],
    help="Range of Pth values (FROM TO STEP)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the list of Pth instances (CSV)")
parser.add_argument('--var', '-v', required=True,
    help="Makefile variable that will hold holds list of instances")
parser.add_argument('--dir', '-d', required=True,
    help="Directory where to create instance directories")
args = parser.parse_args()

if len(args.list) == 0:
    pth_list = np.arange(args.range[0], args.range[1], args.range[2])
else:
    pth_list = args.list

fout = open(args.output, 'w')
#fout.write("pth,id\n")

fout.write(args.var + " = \\\n")

for pth in pth_list:
    instance_id = "pth-%.4f" % pth
    instance_dir = os.path.join(args.dir, instance_id)

    if not os.path.isdir(instance_dir):
        os.mkdir(instance_dir)

    #fout.write(",".join([str(pth), instance_id]) + "\n")
    fout.write("\t" + instance_dir + " \\\n")

    id_file_path = os.path.join(instance_dir, "instance.csv")
    fid_out = open(id_file_path, 'w')
    fid_out.write("instance_id,pth\n") # CSV header
    fid_out.write(",".join([instance_id, str(pth)]) + "\n")
