#!/usr/bin/python

import sys
import argparse
import math
import pandas as pd
import numpy as np
import os

from scipy.stats import norm
import scipy.integrate

parser = argparse.ArgumentParser(
            description="Check how likely tasks are to complete")
parser.add_argument('path_energy_dataset',
            help="input dataset with task path energies (CSV)")
parser.add_argument('energy_capacity_dataset',
            help="dataset describing energy capacity (CSV)")
parser.add_argument('--energy-dists-dir',
            help="directory with input datasets with PDFs for the path energy distributions (CSV)")
parser.add_argument('--output', '-o',
            help="output dataset with task path energies and estimated success probability")
parser.add_argument('--min-success-probability', type=float, default=0.95,
            help="minimum acceptable success probability for a path to pass the check")
parser.add_argument('--verbose', action='store_true',
            help="verbose logging output")
args = parser.parse_args()

# We are interested in P(cost < start) or P(cost - start < 0) = CDF(D),
# where random variable D = C - S.

path_energy_costs = pd.read_csv(args.path_energy_dataset)

energy_capacity_params = pd.read_csv(args.energy_capacity_dataset)
print("energy capacity: ", energy_capacity_params)
energy_capacity_mean = energy_capacity_params['mean'][0]
energy_capacity_var = energy_capacity_params['var'][0]

p_success_column = []
outcome_column = []

num_passed = 0
num_failed = 0

for idx, row in path_energy_costs.iterrows():

    # support dist exprs and legacy normal dist
    if args.energy_dists_dir:
        path_id = row['task'] + '--' + str(row['path'])
        if args.verbose:
            print("path: ", path_id)

        pdf_data = pd.read_csv(os.path.join(args.energy_dists_dir, path_id + '.csv'))
        X = pdf_data['energy'] # x-axis of the PDF

        # TODO: compare two distributions, don't collapse the energy capacity to
        # its expectation; dist compare would involve integration (?)

        # if capacity is out of range, then the result is definite
        if energy_capacity_mean < X.iloc[0]:
            print("capacity out of range: below")
            p_success = 0.0
        elif energy_capacity_mean > X.iloc[-1]:
            print("capacity out of range: above")
            p_success = 1.0
        else: # in range
            pdf_y_data = pdf_data['pdf']
            energy_capacity_idx = int(round((energy_capacity_mean - X.iloc[0]) / (X.iloc[1] - X.iloc[0])))
            p_success = scipy.integrate.simps(pdf_y_data[:energy_capacity_idx], X[:energy_capacity_idx])
            if args.verbose:
                print("x-index:", energy_capacity_idx, "p_success", p_success)

            # NOTE: this happens when PDF crosses into negative semi-axis of the x-axis,
            # which happens when normals with high-ish variance and near-zero mean
            # are involved in the calculation. The workaround is to scale (TODO: what
            # is the precise statistical interpretation of the workaround).
            p_total = scipy.integrate.simps(pdf_y_data, X)
            if p_total < 1.0:
                if p_total < 0.95:
                    print("WARNING: Integral(PDF) = " + str(p_total) + ": scaling P(success)")
                p_success /= p_total
    else:
        e_mean = row['energy_mean']
        e_var = row['energy_var']

        diff_dist = norm(loc=e_mean - energy_capacity_mean,
                         scale=math.sqrt(e_var) + energy_capacity_var)

        p_success = diff_dist.cdf(0.0)
        if args.verbose:
            print("path e (", e_mean, ",", e_var, ")")

    if args.verbose:
        print("P(success) = ", p_success)

    if args.verbose:
        print("PATH (", row['task'], row['path'], "):", end='')

    outcome = p_success > args.min_success_probability
    if outcome:
        if args.verbose:
            print("PASSED")
        num_passed += 1
    else:
        if args.verbose:
            print("FAILED")
        num_failed += 1

    p_success_column.append(p_success)
    outcome_column.append(outcome)

p_success_dataset = pd.DataFrame(dict(task=path_energy_costs['task'],
                                      path=path_energy_costs['path'],
                                      elapsed_sec=path_energy_costs['elapsed_sec'],
                                      p_success=p_success_column,
                                      outcome=outcome_column))

p_success_dataset.to_csv(args.output, index=False)

print("Results:", num_failed, "/", (num_passed + num_failed),
      "paths failed at threshold", args.min_success_probability)
