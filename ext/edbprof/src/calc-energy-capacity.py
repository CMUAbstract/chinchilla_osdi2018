#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
            description="Calculate energy capacity from trace of start voltage")
parser.add_argument('start_voltage',
            help="input trace of start voltage (CSV)")
parser.add_argument('--output', '-o',
            help="output dataset with distribution parameters (CSV)")
parser.add_argument('--capacitance', type=float, required=True,
            help="size of energy storage capacitor on the device (uF)")
parser.add_argument('--brown-out', type=float, required=True,
            help="voltage threshold at which the device MCU stops running (V)")
parser.add_argument('--drop-initial-samples', type=int, default=0,
            help="number of initial samples to disregard (they seem disproportionately noisy)")
args = parser.parse_args()

d = pd.read_csv(args.start_voltage)
d = d[args.drop_initial_samples:]

start_voltage = d['watchpoint_vcap']

start_energy = 0.5 * args.capacitance * (start_voltage ** 2 - args.brown_out ** 2)

start_energy_mean = start_energy.mean()
start_energy_var = start_energy.std() ** 2

params = pd.DataFrame(dict(mean=start_energy_mean, var=start_energy_var), index=[0])

params.to_csv(args.output, index=False)
