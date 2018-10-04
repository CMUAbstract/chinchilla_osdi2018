#!/usr/bin/python

import argparse
import pandas as pd
import numpy as np

parser = argparse.ArgumentParser(
    description="Calculate False-Pos/False-Neg between predictions and observations")
parser.add_argument('outcomes_dataset',
    help="Input dataset with the predicted and observed outcomes (CSV)")
parser.add_argument('--output', '-o', required=True,
    help="Output file where to save the accuracy dataset (CSV)")
parser.add_argument('--spec-id', '-s', required=True,
    help="Dataset with boudandary spec identifier (CSV)")
args = parser.parse_args()

spec_id_df = pd.read_csv(args.spec_id)
spec_id = spec_id_df.loc[0]['spec_id']
spec_boundary_count = spec_id_df.loc[0]['boundary_count']
spec_sample_index = spec_id_df.loc[0]['sample_index']

outcomes_all_df = pd.read_csv(args.outcomes_dataset)

outcomes_by_pth_df = outcomes_all_df.groupby('pth')

accuracy_df = pd.DataFrame()

for pth, outcomes_df in outcomes_by_pth_df:

    predicted = outcomes_df['predicted_completes'].as_matrix()
    observed = outcomes_df['observed_completes'].as_matrix()

    num_correct = np.sum(observed == predicted)
    num_fp = np.sum((observed == True) & (predicted == False))
    num_fn = np.sum((observed == False) & (predicted == True))

    total = num_fp + num_fn + num_correct 

    assert total == len(predicted) == len(observed)

    frac_correct = num_correct / total
    frac_fp = num_fp / total
    frac_fn = num_fn / total

    pth_accuracy_df = pd.DataFrame(dict(spec_id=spec_id,
                                    boundary_count=spec_boundary_count,
                                    sample_index=spec_sample_index,
                                     pth=pth,
                                    total=total,
                                    num_correct=num_correct,
                                    frac_correct=frac_correct,
                                    num_fp=num_fp, frac_fp=frac_fp, 
                                    num_fn=num_fn, frac_fn=frac_fn),
                                index = [0])
    accuracy_df = pd.concat([accuracy_df, pth_accuracy_df])

accuracy_df.to_csv(args.output, index=False)
