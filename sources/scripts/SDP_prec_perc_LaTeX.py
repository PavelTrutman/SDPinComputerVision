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
  dim = matData['dim']
  unique = matData['unique']
  bound = matData['bound']
  percs = matData['percs']
  eps = matData['eps']
  matrices = matData['matrices']
  iters = resData['iters']

  # export to LaTeX
  with open('data/SDP_prec_perc_iters.dat', 'wt') as fIters:
    formatStrIters = '{:f} '*len(percs) + '\n'
    for i in range(unique):
      fIters.write(formatStrIters.format(*(iters[i, :]*100).tolist()))

  with open('macros/SDP_prec_perc.tex', 'wt') as f:
    f.write('\\newcommand{{\\importSDPPrecPercUnique}}{{{0:d}}}\n'.format(unique))
    f.write('\\newcommand{{\\importSDPPrecPercBound}}{{\\ensuremath{{10^{{{0:.0f}}}}}}}\n'.format(np.log10(bound)))
    f.write('\\newcommand{{\\importSDPPrecPercDim}}{{{0:d}}}\n'.format(dim))
    f.write('\\newcommand{{\\importSDPPrecPercEps}}{{\\ensuremath{{10^{{{0:d}}}}}}}\n'.format(int(np.log10(eps))))
    for percIdx, perc in enumerate(percs):
      f.write(('\\newcommand{{\\importSDPPrecPercPerc' + 'I'*(percIdx + 1) + '}}{{\\ensuremath{{10^{{{:d}}}}}}}\n').format(int(np.log10(perc*100))))
