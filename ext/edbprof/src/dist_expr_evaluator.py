#!/usr/bin/python

import re
import numpy as np
import pandas as pd
import scipy.stats as stats
import scipy.integrate

SHIFT_WIDTH = 2

OP_SUM = '+'
OP_MULT = '*'
OP_MIX = '&'
OP_WEIGHT = '^'
OPS = [OP_SUM, OP_MULT, OP_MIX, OP_WEIGHT]

ZERO_THRESHOLD = 0.00001

def truncate_zero_tail(x):
    for j in range(len(x) - 1, 0, -1):
        if x[j] > ZERO_THRESHOLD:
            break
    return x[0:j + 1]

class Grid:
    def __init__(self, left, right, step):
        self.left = left
        self.right = right
        self.step = step

        self.array = np.arange(left, right, step)

#TODO: factor into parser and evaluator
class DistExprEvaluator:
    cache = {}

    # TODO: factor into dist.py
    class Dist:

        def __init__(self, grid, pdf_data_x=None, pdf_data_y=None, cdf_data_y=None):
            self.grid = grid
            self.pdf_data_x = pdf_data_x
            self.pdf_data_y = pdf_data_y
            self.cdf_data_y = cdf_data_y


            if self.pdf_data_x is not None and self.pdf_data_y is not None:
                assert len(self.pdf_data_y) == len(self.pdf_data_x)
                # normalize
                pdf_total = scipy.integrate.simps(pdf_data_y, self.pdf_data_x)
                self.pdf_data_y /= pdf_total

            if self.pdf_data_x is not None and self.cdf_data_y is not None:
                assert len(self.cdf_data_y) == len(self.pdf_data_x)

            # NOTE: self.hash is assigned upon evaluation. This distribution
            # can only be constructed as a result of an evaluation.

            #print("dist: ", self)
            #print("pdf_data=", pdf_data)

        def pdf(self):
            assert len(self.pdf_data_y) == len(self.pdf_data_x)
            return self.pdf_data_x, self.pdf_data_y

        def cdf(self):
            if self.cdf_data_y is None:
                cdf_data_y = np.zeros(len(self.pdf_data_x))
                cdf_data_y[0] = 0.0
                for i in range(1, len(self.pdf_data_x)):
                    cdf_data_y[i] = scipy.integrate.simps(self.pdf_data_y[:i], self.pdf_data_x[:i])
                self.cdf_data_y = cdf_data_y
            return self.pdf_data_x, self.cdf_data_y

        def find_index(self, x):
            assert self.pdf_data_x is not None
            #print("value=", x)
            # Find discrete point closest to energy capacity
            for idx in range(len(self.pdf_data_x)):
                #print("idx=", idx, "val=", self.pdf_data_x[idx], "y=", self.cdf_data_y[idx])
                if self.pdf_data_x[idx] >= x:
                    return idx
            return len(self.pdf_data_x) - 1

        def eval_cdf(self, x):
            assert self.cdf_data_y is not None
            return self.cdf_data_y[self.find_index(x)]

        def expectation(self):
            pdf_data_x, pdf_data_y = self.pdf()
            return scipy.integrate.simps(pdf_data_y * pdf_data_x, pdf_data_x)

        def max(self):
            pdf_data_x, pdf_data_y = self.pdf()
            pdf_data_y_nonzero = truncate_zero_tail(pdf_data_y)
            return pdf_data_x[len(pdf_data_y_nonzero) - 1]

        def indent(self, level):
            return " " * level * SHIFT_WIDTH

        def __hash__(self):
            return self.hash

    class NormDist(Dist):
        def __init__(self, mean, var, grid):
            self.mean = mean
            self.var = var
            self.pdf_data_x = None
            self.pdf_data_y = None
            self.grid = grid

            # TODO: This is very ugly, but the numerical calculations are
            # invalid otherwise, because the input is below the resolution
            # threshold.
            var += grid.step

            self.dist = stats.norm(mean, var)

            self.hash = hash(type(self)) + hash(self.mean) + hash(self.var)

            #print("norm dist: ", self)
            DistExprEvaluator.Dist.__init__(self, grid)

        def pdf(self):
            if self.pdf_data_y is None:
                self.pdf_data_y = truncate_zero_tail(self.dist.pdf(self.grid.array))
                self.pdf_data_x = np.arange(0, len(self.pdf_data_y) * self.grid.step, self.grid.step)[0:len(self.pdf_data_y)]
            assert len(self.pdf_data_y) == len(self.pdf_data_x)
            return self.pdf_data_x, self.pdf_data_y

        def expectation(self):
            return self.mean

        def print(self, level):
            print(self.indent(level), "(N %f %f)" % (self.mean, self.var))

    class WeightedDist(Dist):
        def __init__(self, dist, weight):
            self.dist = dist
            self.weight = weight

            self.hash = hash(type(self)) + hash(self.dist) + hash(weight)

            #print("weighted dist: ", self)
            DistExprEvaluator.Dist.__init__(self, dist.grid)

        def pdf(self):
            #print("weighting pdf of:", self.dist)
            pdf_data_x, pdf_data_y = self.dist.pdf()
            assert len(pdf_data_y) == len(pdf_data_x)
            return pdf_data_x, pdf_data_y * self.weight

        def __repr__(self):
            return "WeightedDist(" + repr(self.dist) + "," + str(self.weight) + ")"

        def print(self, level):
            indent = self.indent(level)
            print(indent, "(^")
            self.dist.print(level + 1)
            print(self.indent(level + 1), self.weight)
            print(indent, ")")

    class MultDist(Dist):
        def __init__(self, dist, reps):
            self.dist = dist
            self.reps = reps

            self.hash = hash(type(self)) + hash(self.dist) + hash(self.reps)

            #print("mult dist: ", self)
            DistExprEvaluator.Dist.__init__(self, dist.grid)

        def pdf(self):
            raise Exception("MultDist doesn't have pdf_data, it evaluates to Dist");

        def __repr__(self):
            return "MultDist(" + repr(self.dist) + "," + str(self.reps) + ")"

        def print(self, level):
            indent = self.indent(level)
            print(indent, "(*")
            self.dist.print(level + 1)
            print(self.indent(level + 1), self.reps)
            print(indent, ")")

    class ZeroDist(Dist):
        def __init__(self):

            self.hash = 0 # does not change hash of composite dists

            #print("zero dist: ", self)
            DistExprEvaluator.Dist.__init__(self, None, None)

        def expectation(self):
            return 0.0

        def print(self, level):
            print(self.indent(level), "(Z)")

    class HistDist(Dist):
        def __init__(self, data_id, grid, evaluator):
            self.data_id = data_id
            self.pdf_data_x, self.pdf_data_y = evaluator.load_hist_data(data_id)

            self.hash = hash(type(self)) + hash(self.data_id)

            DistExprEvaluator.Dist.__init__(self, grid, self.pdf_data_x, self.pdf_data_y)

        def pdf(self):
            assert len(self.pdf_data_y) == len(self.pdf_data_x)
            return self.pdf_data_x, self.pdf_data_y

        def print(self, level):
            print(self.indent(level), "(H %r)" % (self.data_id))

    class CompositeDist(Dist):
        def __init__(self, op, dists):
            self.dists = dists
            self.op = op

            self.hash = hash(type(self)) + sum(map(hash, self.dists))

            DistExprEvaluator.Dist.__init__(self, None, None)

        def print(self, level):
            indent = self.indent(level)
            print(indent, "(" + self.op)
            for dist in self.dists:
                dist.print(level + 1)
            print(indent, ")")

    class SumDist(CompositeDist):
        def __init__(self, dists):
            DistExprEvaluator.CompositeDist.__init__(self, OP_SUM, dists)

    class MixDist(CompositeDist):
        def __init__(self, dists):
            DistExprEvaluator.CompositeDist.__init__(self, OP_MIX, dists)

    # TODO: move the hist contruction out of here
    def __init__(self, grid,
                 hist_data_path=None, hist_data_column=None,
                 collapse=False, verbose=False):
        """Construct a distribution representation object

            hist_data_path: pattern for the path to the data file (CSV) with raw data
                            for the raw-histogram-type of distribution objects,
                            e.g. 'instances/%id/energy.csv'. where %id expands to data ID.

            collapse: whether to collapse distributions to their expected values
                      and add the values, instead of convolving the PDF data array
        """
        self.grid = grid

        self.hist_data_path = hist_data_path
        self.hist_data = {}
        self.collapse = collapse

        self.verbose = verbose

    def set_collapse(self, val):
        if self.verbose:
            print("collapse=", val)
        self.collapse = val

    def load_hist_data(self, data_id):
        if data_id not in self.hist_data:
            path = self.hist_data_path.replace('%id', data_id)
            d = pd.read_csv(path)
            self.hist_data[data_id] = d.loc[:,'energy'].values, d.loc[:,'count'].values
        return self.hist_data[data_id]

    def is_number(self, s):
        return re.match(r'^[0-9Ee.-]+$', s)

    def tokenize(self, s):
        toks = []
        tok = ''
        for c in s:
            if re.match(r'^\s|\(|\)$', c):
                if tok:
                    toks.append(tok)
                    tok = ''
                if re.match(r'^\s$', c) is None:
                    toks.append(c)
                continue
            else:
                tok += c
        if tok != '':
            toks.append(tok)
        return toks

    def parse_list(self, s):
        l = []
        level = 0
        elem = []
        for c in s:

            if c == '(':
                if level > 0:
                    elem += [c]

                level += 1

            elif c == ')':
                level -= 1

                if level > 0:
                    elem += [c]

                if level == 1:
                    l.append(elem)
                    elem = []
            elif level <= 1:
                l.append(c)
            else:
                elem += [c]

        return l

    def expr_hash(self, expr):
        h = 0
        for token in expr:
            h += hash(token)
        return h

    def simplify(self, expr):
        if isinstance(expr, self.CompositeDist):
            children = expr.dists
            expr.dists = []
            while len(children):
                dist = children.pop()
                if type(dist) == type(expr):
                    children += dist.dists
                else:
                    expr.dists.append(dist)

            unprocessed_children = expr.dists

        elif isinstance(expr, self.WeightedDist):
            unprocessed_children = [expr.dist]

        elif isinstance(expr, self.MultDist):
            unprocessed_children = [expr.dist]

        else:
            unprocessed_children = []

        for dist in unprocessed_children:
            self.simplify(dist)

        return expr

    def do_eval_expr(self, expr):
        #print("eval: ", expr)
        #expr.print(level=0)

        h = hash(expr)
        if h is not None and h in self.cache:
            return self.cache[h]


        if type(expr) is self.SumDist:
            v = self.convolve(list(map(self.do_eval_expr, expr.dists)))
        elif type(expr) is self.MixDist:
            v = self.mix(list(map(self.do_eval_expr, expr.dists)))
        elif type(expr) is self.WeightedDist:
            v = self.WeightedDist(self.do_eval_expr(expr.dist), expr.weight)
        elif type(expr) is self.MultDist:
            v = self.convolve([self.do_eval_expr(expr.dist)] * expr.reps)
        else:
            v = expr

        # Evaluation does not change the hash -- that's what makes the cache useful
        v.hash = h

        #print("val=", v)
        if h is not None:
            self.cache[h] = v
        return v

    def parse_expr(self, expr):
        args = self.parse_list(expr)
        op = args[0]
        if op == 'N':
            v = self.NormDist(float(args[1]), float(args[2]), self.grid)
        elif op == 'H':
            v = self.HistDist(args[1], self.grid, evaluator=self)
        elif op == 'Z':
            v = self.ZeroDist()
        elif op == '^':
            assert len(args) == 3
            v = self.WeightedDist(self.parse_expr(args[1]), float(args[2]))
        elif op == '+':
            v = self.SumDist(list(map(self.parse_expr, args[1:])))
        elif op == '&':
            v = self.MixDist(list(map(self.parse_expr, args[1:])))
        elif op == '*':
            # TODO: could avoid building the whole list (although, that's cheap)
            assert len(args) == 3
            v = self.MultDist(self.parse_expr(args[1]), int(args[2]))
        else:
            raise Exception("Unrecognized operator: '" + str(op) + "'")

        return v

    def eval_expr(self, e):
        """ Evaluate distribution expresion into a PDF"""
        if self.verbose:
            print("expr=", e)

        if self.verbose:
            print("parsing expression")
        e_tree = self.parse_expr(self.tokenize(e))
        if self.verbose:
            print("parsed expression:")
            e_tree.print(level=0)

        if self.verbose:
            print("simplifying")
        e_tree = self.simplify(e_tree)
        if self.verbose:
            print("simplified:")
            e_tree.print(level=0)

        if self.verbose:
            print("evaluating")
        return self.do_eval_expr(e_tree)

    def collapse_filter(self, d):
        if type(d) is DistExprEvaluator.NormDist:
            return True
        elif self.collapse:
            return type(d) is DistExprEvaluator.HistDist
        else:
            return False

    def mix(self, dists):
        if self.verbose:
            print("mixing: ", dists, "len(dists)=", len(dists))
        dists = list(filter(lambda d: type(d.dist) is not self.ZeroDist, dists))

        assert len(dists) > 0 # trying to mix a bunch of zero dists?

        if self.verbose:
            print("filter len(dists)=", len(dists))

        # TODO: HACK: PathEnergyEstimator adds the loop-exit-path as ZeroDist
        # with weight equal to the weight of every other path (this weight is 1
        # / (total_paths - 1), excluding the loop exit path. The reasoning is
        # that the loop-exit path already has zero energy, so we can safely add
        # it, with whatever probability. So, we need to exclude that path here.

        # Mixing with a zero dist is a no-op
        if len(dists) == 1:
            dist = dists[0]
            assert dist.weight - 1.0 < 0.0000001 # float comparison
            if self.verbose:
                print("mixing with a zero-dist: returning unmodified dist:", dist.dist)
            return dist.dist

        # Mixing with a zero dist is mixing with N(0, 0)
        #if len(dists) == 1:
        #    dist = dists[0]
        #    pdf_data = dist.weight * dist.pdf_data
        #    return DistExprEvaluator.Dist(pdf_data, self.X, self.x_step)

        weighted_pdfs = np.zeros((len(self.grid.array), len(dists)))
        for i, dist in enumerate(dists):
            assert type(dist) is DistExprEvaluator.WeightedDist
            pdf_data_x, pdf_data_y = dist.pdf()
            weighted_pdfs[:,i] = np.concatenate([pdf_data_y, np.zeros(len(self.grid.array) - len(pdf_data_y))])

        pdf_data = np.sum(weighted_pdfs, axis=1)
        assert len(pdf_data) == len(self.grid.array)

        pdf_data_y = truncate_zero_tail(pdf_data)
        pdf_data_x = np.arange(0, len(pdf_data_y) * self.grid.step, self.grid.step)[0:len(pdf_data_y)]

        return DistExprEvaluator.Dist(self.grid, pdf_data_x, pdf_data_y)
        

    def convolve(self, dists):

        if self.verbose:
            print("convolving", list(dists), "num dists=", len(dists))

        dists = list(filter(lambda d: type(d) is not self.ZeroDist, dists))

        if self.verbose:
            print("num non-zero dists=", len(dists))

        # Convolving with a zero dist is a no-op
        if len(dists) == 1:
            if self.verbose:
                print("convolving with a zero-dist: returning unmodified dist:", dists[0])
            return dists[0]

        # Convolving normals has a shortcut: closed-form expression for the result

        collapsed = list(filter(self.collapse_filter, dists))
        noncollapsed = list(filter(lambda d: not self.collapse_filter(d), dists))

        if len(collapsed) > 0:
            exp_value = sum(map(lambda d: d.expectation(), collapsed))

            # variance, for non-normal distributions, use variance 0
            var = sum(map(lambda d: d.var,
                          filter(lambda dd: type(dd) is DistExprEvaluator.NormDist, collapsed)))

            conved_collapsed = DistExprEvaluator.NormDist(exp_value, var, self.grid)

            if self.verbose:
                print("collapsed=", len(collapsed), "total=", len(dists))
            if len(collapsed) == len(dists):
                return conved_collapsed

            dists = [conved_collapsed] + noncollapsed
        else:
            dists = noncollapsed

        pdf_data_x, pdf_data_y = dists[0].pdf()
        pdf_data_y = truncate_zero_tail(pdf_data_y)

        for i in range(1, len(dists)):
            pdf_data_x_B, pdf_data_y_B = dists[i].pdf()
            pdf_data_y = np.convolve(pdf_data_y, pdf_data_y_B * self.grid.step)
            pdf_data_y = truncate_zero_tail(pdf_data_y)

        pdf_data_x = np.arange(0, len(pdf_data_y) * self.grid.step, self.grid.step)[0:len(pdf_data_y)]

        if self.verbose:
            print("pdf_data len=", len(pdf_data_x), len(pdf_data_y))
        assert len(pdf_data_y) == len(pdf_data_x)
        return DistExprEvaluator.Dist(self.grid, pdf_data_x, pdf_data_y)
