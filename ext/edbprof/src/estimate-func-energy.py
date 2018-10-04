#!/usr/bin/python2
# v2 because no pymix package for python 3 in AUR

import argparse
import pandas as pd
import numpy as np
import math
import mixture as mix
from scipy.integrate import simps

parser = argparse.ArgumentParser(
    description="Calculate function energy distribution aggregating across modules")
parser.add_argument('func_energy_dataset', nargs='+',
    help="Datasets with dist params from the func energy estimator pass")
parser.add_argument('--output', '-o', required=True,
    help="Output file to save function enery distribution to (CSV)")
args = parser.parse_args()

FUNC_COLUMN = "func"

# Range of energy values to construct PDF/CDF over in units of standard
# deviations from (max) mean energy among paths
ENERGY_RANGE_NUM_STDDEV = 5

# First pass: figure out the x-dimension for the PDF/CDF, i.e. the energy range
for func_energy_dataset_file in args.func_energy_dataset:
    func_energy_dataset = pd.read_csv(func_energy_dataset_file)

    # TODO: could we use grouping and apply instead of unique+for?
    functions = np.unique(func_energy_dataset[FUNC_COLUMN])

    energy_range_upper = None
    for func in functions:
        paths = func_energy_dataset[func_energy_dataset[FUNC_COLUMN] == func]
        max_energy = paths["mean"].max() + \
                       ENERGY_RANGE_NUM_STDDEV * math.sqrt(paths["var"].max())
        if energy_range_upper is None or max_energy > energy_range_upper:
            energy_range_upper = max_energy

energy_range_step = 0.001
energy_range_lower = 0
energy = np.arange(energy_range_lower, energy_range_upper, energy_range_step)

print("Energy range: [%f,%f] step %f" % \
        (energy_range_lower, energy_range_upper, energy_range_step))

func_energies_dataset = pd.DataFrame()

# Second pass: construct the mixture model and calc PDF and CDF
for func_energy_dataset_file in args.func_energy_dataset:
    func_energy_dataset = pd.read_csv(func_energy_dataset_file)

    print("Module: %s" % func_energy_dataset_file)

    # TODO: could we use grouping and apply instead of unique+for?
    functions = np.unique(func_energy_dataset[FUNC_COLUMN])

    for func in functions:
        path_dists = []
        path_weights = []
        print("Function %s:" % func)
        paths = func_energy_dataset[func_energy_dataset[FUNC_COLUMN] == func]
        for i, path in paths.iterrows():
            mean = path["mean"]
            sd = math.sqrt(path["var"])
            weight = path["weight"]

            print("Adding path dist: mean %f sd %f weight %f" % (mean, sd, weight))

            path_dist = mix.NormalDistribution(mean, sd)
            path_dists.append(path_dist)
            path_weights.append(weight)

        m = mix.MixtureModel(len(path_dists), path_weights, path_dists)

        ds = mix.DataSet()
        ds.fromList(energy)
        ds.internalInit(m)

        logpdf = m.pdf(ds)
        pdf = [math.exp(p) for p in logpdf]
        cdf = np.zeros(len(pdf))
        for i, r in enumerate(energy):
            cdf[i] = simps(pdf[0:i+1], energy[0:i+1])

        func_energies_dataset = \
                pd.concat([func_energies_dataset,
                    pd.DataFrame({func + "-cdf": cdf}),
                    pd.DataFrame({func + "-pdf": pdf})], axis=1)

func_energies_dataset = pd.concat([pd.DataFrame({'energy': energy}),
                                   func_energies_dataset], axis=1)
func_energies_dataset.to_csv(args.output, index=False, float_format='%e')
