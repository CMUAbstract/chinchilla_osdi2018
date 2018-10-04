#!/usr/bin/python

import argparse
import pandas as pd
import pylab as pl
import numpy as np
import sys
from scipy.integrate import simps
from scipy import stats
import math

parser = argparse.ArgumentParser(
    description="Calculate probability of failure of a task")
parser.add_argument('path_dataset',
    help="Dataset with function energy costs and frequencies (CSV)")
parser.add_argument('start_energy_dist',
    help="Dataset with starting energy distribution (CSV)")
parser.add_argument('--output', '-o',
    help="Output dataset with task completion probability (CSV)")
args = parser.parse_args()

ENERGY_COLUMN = "energy"

path_dataset = pd.read_csv(args.path_dataset)
start_energy_dist = pd.read_csv(args.start_energy_dist)

completion_prob_dataset = open(args.output, "w")
completion_prob_dataset.write("func,p_completes\n");

for func in start_energy_dist:

    # A hacky naming convention. The problem is that the pass doesn't
    # know about tasks, but only about functions.
    task = func.replace('TASK_', '').lower()
    task_cdf_col = task + "-cdf"

    # Hack to tolerate start energy and func energy datasets collected for
    # different sets of functions
    #if task_cdf_col not in func_energy_dist:
    #    continue

    FUNC_COLUMN = "func"
    paths = path_dataset[path_dataset[FUNC_COLUMN] == task]

    #print("func %s: paths %u" % (task, len(paths)))

    p_func_succ = 0.0
    for start_energy in start_energy_dist[func].dropna():

        p_func_succ_given_start_energy = 0.0
        for i, path in paths.iterrows():
            path_e_mean = path["mean"]
            path_e_sd = math.sqrt(path["var"])
            path_weight = path["weight"]

            #print("path: mean %.2f sd %.2f weight %.2f" %
            #(path_e_mean, path_e_sd, path_weight))

            p_path_succ_given_start_energy = stats.norm.cdf(start_energy,
                    loc=path_e_mean, scale=path_e_sd)
            #print("cdf(start energy %.2f)=%.2f" % 
            #     (start_energy, p_path_succ_given_start_energy))
            p_func_succ_given_start_energy += path_weight * p_path_succ_given_start_energy
            #print("p(func succ | start e %.2f)=%.2f" %
            #        (start_energy, p_func_succ_given_start_energy))

        # Treat start energy as discrete
        p_start_energy = 1.0 / len(start_energy_dist[func])

        #print("p(start_energy %.4f)=%.4f" % (start_energy, p_start_energy))
        p_func_succ += p_start_energy * p_func_succ_given_start_energy
        #print("p(func succ)=%.4f" % (p_func_succ))

        #print("p(start energy) = p(%.2f) = %.2f" %
        #(start_energy, p_start_energy))

    print("P(%s completes) = %f" % (func, p_func_succ))

    completion_prob_dataset.write("%s,%e\n" % (func, p_func_succ))
