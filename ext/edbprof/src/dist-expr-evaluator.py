#!/usr/bin/python

import argparse
import re
import numpy as np
import scipy.stats as stats
import pandas as pd
import os
import time

from dist_expr_evaluator import Grid, DistExprEvaluator
from dist_eval_args import *
from cli import split_args

parser = argparse.ArgumentParser(
    description="Server that evaluates distribution expressions for path energies")
parser.add_argument('in_pipe',
    help="Input pipe for requests")
parser.add_argument('out_pipe',
    help="Output pipe for responses")
parser.add_argument('--grid', '-g', nargs=3, metavar=('FROM', 'TO', 'STEP'),
    type=float, required=True,
    help='Grid of discrete points at which to interpolate')
parser.add_argument('--verbose', action='store_true',
    help='Output paths for diagnosis')
add_dist_eval_args(parser)

args = parser.parse_args()

def log(*m):
    if args.verbose:
        print(*m)

SERVER_VERSION = "0.1"

# Command parsers
cmd_parsers = {}

parser_version = argparse.ArgumentParser(
    description="Report version of the server")
cmd_parsers["version"] = parser_version

parser_evalmax = argparse.ArgumentParser(
    description="Evaluate distribution expression into a PDF and find max value from the PDF")
parser_evalmax.add_argument('expr',
    help="Distribution expression to evaluate")
parser_evalmax.add_argument('--collapse', '-c', action='store_true',
    help="Collapse distributions to their expectations for faster evaluation")
cmd_parsers["evalmax"] = parser_evalmax

# collapse -> expr -> value
eval_cache = { False: {}, True: {} }

in_pipe = open(args.in_pipe, "r")
out_pipe = open(args.out_pipe, "w")

def reply(s):
    out_pipe.write(s + "\n")
    out_pipe.flush()

expr_evaluator = DistExprEvaluator(Grid(*args.grid),
                                   hist_data_path=args.hist_data_path,
                                   hist_data_column=args.hist_data_column,
                                   verbose=args.verbose)


# Command handler implementations
cmd_handlers = {}

def handle_version(args):
    log("request:", cmd)
    reply(SERVER_VERSION)
cmd_handlers["version"] = handle_version

def handle_evalmax(args):
    if args.expr not in eval_cache[args.collapse]:
        log("cache miss")

        start_time = time.time()
        log("server evaluating expr, collapse=", args.collapse)
        expr_evaluator.set_collapse(args.collapse)
        dist = expr_evaluator.eval_expr(args.expr)
        log("server evaluation done\n")
        #expected_energy = dist.expectation()
        log("server computing max value\n")
        max_energy = dist.max()
        log("server max computation done:", max_energy)
        elapsed_time_sec = time.time() - start_time

        eval_cache[args.collapse][args.expr] = max_energy

    else:
        log("cache hit")
        max_energy = eval_cache[args.collapse][args.expr]
        elapsed_time_sec = 0

    reply_msg = " ".join([str(max_energy), str(elapsed_time_sec)])
    log("reply: ", reply_msg)
    reply(reply_msg)
cmd_handlers["evalmax"] = handle_evalmax

cmd = "nop"
while True:
    log("Listening...")
    req = in_pipe.readline().strip()

    if req is None or req == "":
        log("EOF")
        break

    cmd_with_args = req.split(maxsplit=1)
    if len(cmd_with_args) == 1:
        cmd = cmd_with_args[0]
        cargs = ''
    elif len(cmd_with_args) == 2:
        cmd, cargs = cmd_with_args
    else:
        log("invalid command:", cmd_with_args)

    log("request:", cmd, cargs[:min(16, len(cargs))], " ...")

    if cmd not in cmd_handlers:
        log("invalid command:", cmd)

    cmd_handlers[cmd](cmd_parsers[cmd].parse_args(split_args(cargs)))
