#!/usr/bin/python

import argparse
import pylab as pl
import pandas as pd

parser = argparse.ArgumentParser(
    description="Plot the PDF of a distribution")
parser.add_argument('dist_pdf_dataset',
    help="Input file withthe PDF points (CSV)")
parser.add_argument('--output', '-o',
    help="Output file with the plot (format from extension)")
parser.add_argument('--range', nargs=2, type=float,
    help="X-axis range")

args = parser.parse_args()

pdf_data = pd.read_csv(args.dist_pdf_dataset)
pdf_data = pdf_data.set_index('energy')

if args.range:
    pdf_data = pdf_data[(args.range[0] <= pdf_data.index) & (pdf_data.index <= args.range[1])]

pl.plot(pdf_data.index, pdf_data['pdf'],
        color='k')

pl.title("Probability distribution for energy of one path")
pl.xlabel("Energy (uJ)")
pl.ylabel("Probability Density Function (PDF)")

if args.output:
    pl.savefig(args.output, bbox_inches='tight')
else:
    pl.show()
