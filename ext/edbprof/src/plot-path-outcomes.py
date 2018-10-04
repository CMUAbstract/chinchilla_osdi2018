#!/usr/bin/python

import os
import pylab as pl
import pandas as pd
import argparse

#from colormaps import cmaps

parser = argparse.ArgumentParser(
    description="Plot path predictions relative to capacitor size")
parser.add_argument('path_outcomes_dataset',
    help="Input file with the path predicted (CSV)")
parser.add_argument('--capacity',
    help="Dataset with energy storage capacity (CSV)")
parser.add_argument('--out', '-o',
    help="Output filename to save the figure to (extension indicates format)")
args = parser.parse_args()

d = pd.read_csv(args.path_outcomes_dataset)

f, ax = pl.subplots(1, 2, figsize=(12,6), sharey=True)

d_observed_completes = d[d['observed_completes'] == True]

cmap = pl.get_cmap('Blues')
COLORS = [cmap(0.6), cmap(0.9)]

#df_observed_completes = pd.DataFrame()

def plot_category(idx, observed):
    d_observed_cat = d[d['observed_completes'] == observed]
    d_by_spec = d_observed_cat.groupby('spec_id')
    c = 0
    k = 0
    for spec, d_subset in d_by_spec:
        #df_observed_completes = pd.concat([df_observed_completes, d_subset['max_value'].sort_values()])
        energy = d_subset['max_value'].sort_values()
        ax[idx].bar(range(k, k + len(energy)), energy, color=COLORS[c])
        k += len(energy)
        c = (c + 1) % 2

#ax[0].set_title('Observed: Program Terminated')
plot_category(0, True)

#ax[1].set_title('Observed: Program Did Not Terminate')
plot_category(1, False)

#df_observed_completes.index = range(len(df_observed_completes))
#ax[0].bar(range(len(df_observed_completes)), df_observed_completes.iloc[:,0], width=1)

for a in ax:

    capacity_dataset = pd.read_csv(args.capacity)
    capacity = capacity_dataset['mean'][0]
    a.axhline(capacity, color='red', label='Energy Capacity')

    a.set_xlabel("Path")

    a.set_yscale('log')

    a.legend()

ax[0].set_ylabel("Energy (uJ)")

#ymax = max([a.get_ylim()[1] for a in ax])
#for a in ax:
#    a.set_ylim(ymax=1000)


#pl.legend()

if args.out is None:
    pl.show()
else:
    pl.savefig(args.out, bbox_inches='tight')
