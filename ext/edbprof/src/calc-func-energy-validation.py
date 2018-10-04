#!/usr/bin/python

from functools import reduce

import argparse
import pandas as pd

import pylab as pl

parser = argparse.ArgumentParser(
        description="Calculate energy consumed between a watchpoint pair")
parser.add_argument('trace_file', help='file with watchpoihnt trace')
parser.add_argument('-o', '--output',
            help="file to which to save the plot (extension specifies format)")
parser.add_argument('--capacitor', '-c', type=float, default=10,
                    help='device capacitor (uF)')
args = parser.parse_args()

trace = pd.read_csv(args.trace_file)

E = []
v_begin = None
for idx, row in trace.iterrows():
    vcap = row['watchpoint_vcap']
    if row['watchpoint_id'] == 0:
       v_begin = vcap
    if row['watchpoint_id'] == 1 and v_begin is not None:
        # v_begin now corresponds to the *most recent* watchpoint #0,
        # which is what we want given our example app: watchpint #1
        # is only output on the path of interest, watchpoint #0 is
        # always output, because we can't know whether the path is
        # of interest or not at that point.

        v_end = vcap

        if v_begin < v_end:
            continue

        delta_e = 0.5 * args.capacitor * (v_begin**2 - v_end**2) # uJ

        print("v_begin=", v_begin, "v_end=", v_end, "delta_e=", delta_e)

        E.append(delta_e)


E_df = pd.DataFrame(dict(energy=E))

#print(E_df)

def geomean(nums):
    return (reduce(lambda x, y: x*y, nums))**(1.0/len(nums))

print(E_df.describe())

E_df.hist(bins=25)

if args.output:
    pl.savefig(args.output)
else:
    pl.show()
