#!/usr/bin/python3

"""
Prepare datafile for GNUPlot and so on of time measurements of SDP.

by Pavel Trutman, pavel.trutman@cvut.cz
"""

import scipy.io
import numpy as np

if __name__ == '__main__':

  # load data
  matData = scipy.io.loadmat('data/SDP_prec_perc_matrices.mat', struct_as_record=False, squeeze_me=True)
  resData = scipy.io.loadmat('data/SDP_prec_perc_results.mat', struct_as_record=False, squeeze_me=True)
  dims = matData['dims']
  unique = matData['unique']
  bound = matData['bound']
  percs = matData['percs']
  eps = matData['eps']
  matrices = matData['matrices']
  iters = resData['iters']

  results = np.empty((len(percs), len(dims)))

  for dimIdx, dim in enumerate(dims):
    itersDim = iters[dimIdx]
    results[:, dimIdx] = itersDim.mean(axis=0)

  # export to LaTeX
  with open('data/SDP_prec_perc_iters.dat', 'wt') as fIters:
    formatStrIters = '{:g} ' + ' {:f}'*len(dims) + '\n'
    fIters.write('1 '*(len(dims) + 1) + '\n')
    for percIdx, perc in enumerate(percs):
      fIters.write(formatStrIters.format(perc, *results[percIdx, :].tolist()))

  with open('macros/SDP_prec_perc.tex', 'wt') as f:
    f.write('\\newcommand{{\\importSDPPrecPercUnique}}{{{0:d}}}\n'.format(unique))
    f.write('\\newcommand{{\\importSDPPrecPercBound}}{{\\ensuremath{{10^{{{0:.0f}}}}}}}\n'.format(np.log10(bound)))
    f.write('\\newcommand{{\\importSDPPrecPercDims}}{{{:s}}}\n'.format(', '.join(str(dim) for dim in dims)))
    f.write('\\newcommand{{\\importSDPPrecPercEps}}{{\\ensuremath{{10^{{{0:d}}}}}}}\n'.format(int(np.log10(eps))))
    for dimIdx, dim in enumerate(dims):
      f.write(('\\newcommand{{\\importSDPPrecPercDim' + 'I'*(dimIdx + 1) + '}}{{{:d}}}\n').format(dim))
