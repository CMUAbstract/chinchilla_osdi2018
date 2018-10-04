#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Generate a LaTeX table with checker accuracy results")
parser.add_argument('accuracy_dataset',
    help="Input dataset with checker accuracy (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save plot (format by extension)")
args = parser.parse_args()

accuracy_dataset = pd.read_csv(args.accuracy_dataset)
accuracy_dataset = accuracy_dataset.iloc[0]

#r"""
#\begin{tabular}{lrrrr}
#"""

row = ""
row += "%total, correct, false_positives, false_negatives\n"
row += "%.0f" % accuracy_dataset['total']
row += "  & 100\\% "
row += r" & "
row += "%.0f" % accuracy_dataset['correct']
row += " & %.0f\\%% " % (accuracy_dataset['fraction_correct'] * 100)
row += r" & "
row += "%.0f" % accuracy_dataset['false_negatives']
row += " & %.0f\\%% " % (accuracy_dataset['fraction_false_negatives'] * 100)
row += r" & "
row += "%.0f" % accuracy_dataset['false_positives']
row += " & %.0f\\%% " % (accuracy_dataset['fraction_false_positives'] * 100)
row += "\n"

#r"""
#\end{tabular}
#"""

fout = open(args.output, "w")
fout.write(row)
