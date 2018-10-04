#!/usr/bin/python

import argparse
import os
import pandas as pd
import numpy as np
import pylab as pl

parser = argparse.ArgumentParser(
    description="Aggregate app execution times under different boundary placements")
parser.add_argument('random_placements',
    help='Input dataset with app execution time for a set of random placements (CSV)')
parser.add_argument('manual_placements',
    help='Input dataset with app execution time for a manual placement (CSV)')
parser.add_argument('greedy_placements',
    help='Input dataset with app execution time for a greedy placement (CSV)')
parser.add_argument('--output', '-o',
    help='Output file where to save the dataset with aggregated exec times (CSV)')
parser.add_argument('--completed', '-c', action='store_true',
    help='Include only terminating trials')
args = parser.parse_args()

random_placements = pd.read_csv(args.random_placements)
if args.completed:
    random_placements = random_placements[random_placements['completed'] == True]
random_placements['placer'] = 'random'

manual_placements = pd.read_csv(args.manual_placements)
manual_placements['placer'] = 'manual'
if not np.isnan(manual_placements['elapsed_sec'][0]):
    manual_placements['completed'] = [True]

greedy_placements = pd.read_csv(args.greedy_placements)
greedy_placements['placer'] = 'greedy'
if not np.isnan(greedy_placements['elapsed_sec'][0]):
    greedy_placements['completed'] = [True]

all_exec_times = pd.DataFrame()
for placements in [random_placements, manual_placements, greedy_placements]:
    all_exec_times = pd.concat([all_exec_times, placements])
all_exec_times = all_exec_times.sort_values(by='elapsed_sec')
all_exec_times['idx'] = range(0, len(all_exec_times))

all_exec_times.to_csv(args.output, index=False)
