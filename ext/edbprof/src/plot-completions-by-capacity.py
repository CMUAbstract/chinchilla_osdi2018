#!/usr/bin/python

import argparse
import os
import pandas as pd
import numpy as np
import pylab as pl

from plot import *

parser = argparse.ArgumentParser(
    description="Plot app completions vs capacity")
parser.add_argument('completions',
    help='Input dataset with app completions (CSV)')
parser.add_argument('--output', '-o',
    help='Output file where to save the plot (format by extention)')
args = parser.parse_args()

completions = pd.read_csv(args.completions)

fig = pl.figure()
ax = fig.add_subplot(111)

cm = pl.get_cmap('gray')

completions = completions.set_index('capacity')
completions.plot(marker='o')

pl.title('Predicted application completions')
pl.ylabel("Completed (boolean)")
pl.xlabel("Energy capacity available on device (uJ)")
pl.legend(loc=0)

#pl.setp(ax.get_xticklabels(), visible=False)

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
