def add_dist_eval_args(parser):
    parser.add_argument('--hist-data-path',
        help='File path pattern to the files with data (CSV) for the raw ' +
              'histogram type distribution objects, %id expands to the ' +
              'distribution identifier')
    parser.add_argument('--hist-data-column',
        help='Column name in the dataset pointed to by --hist-data-path')
    parser.add_argument('--num-hist-bins', type=int,
        help='Number of histogram bins to use')
