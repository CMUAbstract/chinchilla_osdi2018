#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl
import numpy as np
import sys
from scipy.integrate import simps

parser = argparse.ArgumentParser(
    description="Calculate probability of failure of a task")
parser.add_argument('func_energy_dist',
    help="Dataset with func energy distribution (CSV)")
parser.add_argument('start_energy_dist',
    help="Dataset with starting energy distribution (CSV)")
parser.add_argument('--output', '-o',
    help="Output dataset with task completion probability (CSV)")
args = parser.parse_args()

func_energy_dist = pd.read_csv(args.func_energy_dist)
start_energy_dist = pd.read_csv(args.start_energy_dist)

ENERGY_COLUMN = "energy"
energy = func_energy_dist[ENERGY_COLUMN]

completion_prob_dataset = open(args.output, "w")
completion_prob_dataset.write("func,p_completes\n");

p_success = 0.0
for func in start_energy_dist:

    # A hacky naming convention. The problem is that the pass doesn't
    # know about tasks, but only about functions.
    task = func.replace('TASK_', '').lower()
    task_cdf_col = task + "-cdf"

    # Hack to tolerate start energy and func energy datasets collected for
    # different sets of functions
    if task_cdf_col not in func_energy_dist:
        continue

    func_energy_cdf = func_energy_dist[task + "-cdf"]

    p_success = 0.0
    for start_energy in start_energy_dist[func]:

        # Find the CDF(start_energy), but where CDF is discretized,
        # and start_energy value might fall in between discrete points.
        j = 0
        while j < len(func_energy_cdf) and energy[j] < start_energy:
            j += 1
        if j == len(func_energy_cdf):
            p_succ_given_start_energy = 1 # CDF(max energy) = 1
        else:
            p_succ_given_start_energy = func_energy_cdf[j]

        # Treat start energy as discrete
        p_start_energy = 1.0 / len(start_energy_dist[func])

        p_success += p_start_energy * p_succ_given_start_energy

    print("P(%s completes) = %f" % (func, p_success))

    completion_prob_dataset.write("%s,%e\n" % (func, p_success))
