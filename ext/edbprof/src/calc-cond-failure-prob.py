#!/usr/bin/python

import argparse
import pandas as pd
import numpy as np

parser = argparse.ArgumentParser(
    description="Calculate probability of completion given start energy")
parser.add_argument('func_energy_dist',
    help="Input dataset with function energy CDF (CSV)")
parser.add_argument('--output', '-o',
    help="Output file where to save conditional probability (CSV)")
parser.add_argument('--capacitance', type=float, required=True,
            help="Size of energy storage capacitor on the device (uF)")
parser.add_argument('--brown-out', type=float, required=True,
            help="Voltage threshold at which the device MCU stops running (V)")
parser.add_argument('--turn-on-voltage', type=float, required=True,
            help="Voltage rating of the regulator (i.e. max cap voltage) (V)")
args = parser.parse_args()

func_energy_dist = pd.read_csv(args.func_energy_dist)

ENERGY_COLUMN = "energy"
energy = func_energy_dist[ENERGY_COLUMN]

func_cols = filter(lambda c: c not in [ENERGY_COLUMN] and \
                         not c.endswith("-pdf"),
                   func_energy_dist.columns)
funcs = [f for f in map(lambda c: c.replace("-cdf", ""), func_cols)]

cond_prob_dataset = open(args.output, "w")
cond_prob_dataset.write("start_energy,%s\n" % ",".join(funcs));

MAX_START_ENERGY = 0.5 * args.capacitance * (args.turn_on_voltage**2 - args.brown_out**2)

start_energy = np.arange(0, MAX_START_ENERGY, 0.05)
print("start energy range: ", start_energy[0], start_energy[-1])

for start_energy in start_energy:
    print("\rstart energy: ", start_energy, end='')

    cond_prob_dataset.write("%e" % start_energy)

    for func in funcs:

        func_energy_cdf = func_energy_dist[func + "-cdf"]

        # Find the CDF(start_energy), but where CDF is discretized,
        # and start_energy value might fall in between discrete points.
        j = 0
        while j < len(func_energy_cdf) and energy[j] < start_energy:
            j += 1
        if j == len(func_energy_cdf):
            p_succ_given_start_energy = 1 # CDF(max energy) = 1
        else:
            p_succ_given_start_energy = func_energy_cdf[j]

        cond_prob_dataset.write(",%e" % p_succ_given_start_energy)

    cond_prob_dataset.write("\n")
