#!/usr/bin/python

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Calculate checker prediction accuracy")
parser.add_argument('predicted_dataset',
    help="Input dataset with predictions of program completion (CSV)")
parser.add_argument('observed_dataset',
    help="Input dataset with observations of program completion (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save accuracy dataset (CSV)")
args = parser.parse_args()

predicted = pd.read_csv(args.predicted_dataset)
observed = pd.read_csv(args.observed_dataset)


INSTANCE_ID_COLUMN = 'spec_id'

#predicted = predicted.set_index(INSTANCE_ID_COLUMN)
observed = observed.set_index(INSTANCE_ID_COLUMN)

predicted = predicted.rename(columns={'completed': 'completed_predicted'})
observed = observed.rename(columns={'completed': 'completed_observed'})

observed = observed[list(filter(lambda c: c not in ['boundary_count', 'sample_index'], observed.columns))]

#observed = observed.dropna(subset=['spec_id'])
print(observed)
#observed = observed.dropna(thresh=3)
#observed = observed.set_index('spec_id')
#predicted = predicted.set_index('spec_id')
print(observed)
print(predicted)
#accuracy_dataset = pd.concat([predicted, observed], axis=1)
accuracy_dataset = predicted.join(observed, on='spec_id')

# to have the two completed_* columns appear next to each other
accuracy_dataset.sort_index(axis=1, inplace=True)

accuracy_dataset.to_csv(args.output, index=True)
