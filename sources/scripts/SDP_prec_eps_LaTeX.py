#!/usr/bin/python3

"""
Prepare datafile for GNUPlot and so on of time measurements of SDP.

by Pavel Trutman, pavel.trutman@cvut.cz
"""

import scipy.io
import numpy as np

if __name__ == '__main__':

  # load data
  matData = scipy.io.loadmat('data/SDP_prec_eps_matrices.mat', struct_as_record=False, squeeze_me=True)
  resData = scipy.io.loadmat('data/SDP_prec_eps_results.mat', struct_as_record=False, squeeze_me=True)
  dims = matData['dims'].tolist()
  unique = matData['unique']
  bound = matData['bound']
  precs = matData['precs']
  matrices = matData['matrices']
  iters = resData['iters']

  # compute the stats
  resIters = np.empty((len(dims), len(precs)))
  for dimIdx, dim in enumerate(dims):
    resIters[dimIdx, :] = iters[dimIdx].mean(axis=1)

  # export to LaTeX
  with open('data/SDP_prec_eps.dat', 'wt') as f:
    formatStr = '{:g}' + ' {:f}'*len(dims) + '\n'
    for precIdx, prec in enumerate(precs):
      f.write(formatStr.format(prec, *resIters[:, precIdx].tolist()))

  with open('macros/SDP_prec_eps.tex', 'wt') as f:
    f.write('\\newcommand{{\\importSDPPrecEpsUnique}}{{\\num{{{0:d}}}}}\n'.format(unique))
    f.write('\\newcommand{{\\importSDPPrecEpsBound}}{{\\ensuremath{{10^{{{0:.0f}}}}}}}\n'.format(np.log10(bound)))
    f.write('\\newcommand{{\\importSDPPrecEpsDims}}{{{:s}}}\n'.format(', '.join(str(dim) for dim in dims)))
    for dimIdx, dim in enumerate(dims):
      f.write(('\\newcommand{{\\importSDPPrecEpsDim' + 'I'*(dimIdx + 1) + '}}{{{:d}}}\n').format(dim))
