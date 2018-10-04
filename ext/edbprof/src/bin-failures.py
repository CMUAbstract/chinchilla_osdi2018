#!/usr/bin/python

import argparse
import pandas as pd
import numpy as np

parser = argparse.ArgumentParser(
    description="Aggregate task failures into bins by start voltage")
parser.add_argument('task_outcome',
    help="Input dataset with task outcomes(CSV)")
parser.add_argument('--capacitance', type=float, required=True,
            help="Size of energy storage capacitor on the device (uF)")
parser.add_argument('--brown-out', type=float, required=True,
            help="Voltage threshold at which the device MCU stops running (V)")
parser.add_argument('--output', '-o',
    help="Output file with binned task failure counts")
args = parser.parse_args()

task_outcome = pd.read_csv(args.task_outcome)

START_VOLTAGE_COLUMN = "start_voltage"
SUCCEEDED_COLUMN = "succeeded"
TASK_COLUMN = "task_id"

voltage = task_outcome[START_VOLTAGE_COLUMN]
voltage_range = voltage.min(), voltage.max()

print("voltage_range=", voltage_range)
NUM_BINS = 50
step = float(voltage_range[1] - voltage_range[0]) / NUM_BINS
voltage_bins = np.arange(voltage_range[0], voltage_range[1], step)

d_binned_outcomes = pd.DataFrame(
        columns=["voltage_bottom", "voltage_top",
                 "energy_bottom", "energy_top",
                 "successes_frac_1",
                 "successes_frac_2"
                 ])

def voltage_to_energy(v):
    return 0.5 * args.capacitance * (v**2 - args.brown_out**2)

for bin_bottom in voltage_bins:
    bin_top = bin_bottom + step

    NUM_TASKS=2
    successes_frac_tasks = {}
    for task in range(NUM_TASKS):
        #print("task outcome[%d]=" % (task + 1), task_outcome[TASK_COLUMN] == task + 1)
        task_outcome_filtered = task_outcome[task_outcome[TASK_COLUMN] == task + 1]
        print("len(task outcome)[%d]=" % (task + 1), task_outcome_filtered.count())

        bin_outcomes = task_outcome_filtered[
                (float(bin_bottom) <= task_outcome[START_VOLTAGE_COLUMN]) &
                (task_outcome[START_VOLTAGE_COLUMN] < float(bin_top))]

        successes = bin_outcomes[SUCCEEDED_COLUMN].dropna()

        print("successes=", successes)

        if len(successes) > 0:
            successes_frac = float(sum(successes)) / len(successes)
        else:
            successes_frac = float('nan')

        print("successes_frac=", successes_frac)
        successes_frac_tasks[task] = successes_frac
                          
    d_binned_outcomes = pd.concat([d_binned_outcomes,
              pd.DataFrame(dict(
                  voltage_bottom=bin_bottom,
                  voltage_top=bin_top,
                  energy_bottom=voltage_to_energy(bin_bottom),
                  energy_top=voltage_to_energy(bin_top),
                  successes_frac_1=successes_frac_tasks[0],
                  successes_frac_2=successes_frac_tasks[1]),
              index=[1])])

print(d_binned_outcomes)
d_binned_outcomes.to_csv(args.output, index=False)
