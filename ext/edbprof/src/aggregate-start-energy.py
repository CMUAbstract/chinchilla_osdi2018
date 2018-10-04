#!/usr/bin/python

import argparse
import pandas as pd
import re
import os

parser = argparse.ArgumentParser(
    description="Aggregate start energy from multiple tasks into one dataset")
parser.add_argument('start_energy_dataset', nargs='+',
    help="Input datasets with start energy (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save start energy dataset")
parser.add_argument('--capacitance', type=float, required=True,
            help="Size of energy storage capacitor on the device (uF)")
parser.add_argument('--brown-out', type=float, required=True,
            help="Voltage threshold at which the device MCU stops running (V)")
args = parser.parse_args()

EMPTY_ENERGY_LEVEL_UJ = 0.5 * args.capacitance * args.brown_out**2

agg_se_dataset = pd.DataFrame()
for se_dataset_path in args.start_energy_dataset:
    se_dataset = pd.read_csv(se_dataset_path)

    # Extract task name from dataset filename
    # The dataset filenames are 'instance/id/file.csv', we extract 'id'
    task = os.path.basename(os.path.dirname(se_dataset_path))
    assert task is not None and len(task) > 0
    task = m.group('task')

    energy_level_uJ = 0.5 * args.capacitance * se_dataset["watchpoint_vcap"]**2
    energy_amount_uJ = energy_level_uJ - EMPTY_ENERGY_LEVEL_UJ

    energy_amount = pd.DataFrame({task: energy_amount_uJ})

    agg_se_dataset = pd.concat([agg_se_dataset, energy_amount], axis=1)

agg_se_dataset.to_csv(args.output, index=False, float_format='%e')
