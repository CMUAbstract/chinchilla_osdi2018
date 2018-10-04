#!/usr/bin/python

import argparse
import os
import pandas as pd
import numpy as np

parser = argparse.ArgumentParser(
    description="Generate range of energy capacities for checker-recall experiment")
parser.add_argument('--range', nargs=3, metavar=['FROM', 'TO', 'STEP'],
    required=True, type=float,
    help='Range of energy capacities (uJ)')
parser.add_argument('--output-makefile',
    help='Makefile with list of checker-validation (inner) and checker-recall (outer) instances')
parser.add_argument('--output-instances',
    help='Dataset with list of checker-recall (outer) instances (CSV)')
parser.add_argument('--instances-dir',
    help='Directory where to generate energy capacity instances')
parser.add_argument('boundary_specs',
    help='Input dataset with list of boundary placements (from checker-validation phase')
args = parser.parse_args()

# Assume the same dir naming convention in checker-validation phase
boundary_spec_instances_dir = args.instances_dir
boundary_specs = pd.read_csv(args.boundary_specs)
makefile = open(args.output_makefile, "w")

outer_instances = []
capacities = []

for capacity in np.arange(*args.range):

    instance_id = "cap-" + ("%.4f" % capacity)
    outer_instances.append(instance_id)
    capacities.append(capacity)

    energy_capacity_instance_dir = os.path.join(args.instances_dir, instance_id)
    energy_capacity_filename = os.path.join(energy_capacity_instance_dir, "energy-capacity.csv")
    print("generating energy capacity instance:", energy_capacity_filename)

    if not os.path.isdir(energy_capacity_instance_dir):
        os.mkdir(energy_capacity_instance_dir)

    energy_capacity = pd.DataFrame(dict(mean=float(capacity), var=0), index=[0])
    energy_capacity.to_csv(energy_capacity_filename, index=False)

# inner instances: per boundary spec (from checker-validation)
inner_instances = []
for idx, row in boundary_specs.iterrows():
    boundary_spec_instance = row['spec_id']
    inner_instances.append(boundary_spec_instance)

makefile.write("OUTER_INSTANCES = " + " ".join(outer_instances) + "\n")
makefile.write("INNER_INSTANCES = " + " ".join(inner_instances) + "\n")

outer_instances_dataset = pd.DataFrame(dict(capacity=capacities, instance=outer_instances))
outer_instances_dataset.to_csv(args.output_instances, index=False)
