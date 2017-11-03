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
  dim = matData['dim']
  unique = matData['unique']
  repeat = matData['repeat']
  bound = matData['bound']
  precs = matData['precs']
  matrices = matData['matrices']
  times = resData['times']
  iters = resData['iters']

  # compute the stats
  minTimes = np.empty((len(precs), unique))
  minIters = np.empty((len(precs), unique))
  for prec, precIdx in zip(precs, range(len(precs))):
    minTimes[precIdx, :] = times[precIdx].min(axis=1)
    minIters[precIdx, :] = iters[precIdx].min(axis=1)

  # export to LaTeX
  with open('data/SDP_prec_eps_times.dat', 'wt') as fTimes, open('data/SDP_prec_eps_iters.dat', 'wt') as fIters:
    formatStrTimes = '{:f} '*len(precs) + '\n'
    formatStrIters = '{:f} '*len(precs) + '\n'
    for i in range(unique):
      fTimes.write(formatStrTimes.format(*np.log10(minTimes[:, i]).tolist()))
      fIters.write(formatStrIters.format(*minIters[:, i].tolist()))

  with open('macros/SDP_prec_eps.tex', 'wt') as f:
    f.write('\\newcommand{{\\importSDPPrecEpsUnique}}{{{0:d}}}\n'.format(unique))
    f.write('\\newcommand{{\\importSDPPrecEpsRepeat}}{{{0:d}}}\n'.format(repeat))
    f.write('\\newcommand{{\\importSDPPrecEpsBound}}{{\\ensuremath{{10^{{{0:.0f}}}}}}}\n'.format(np.log10(bound)))
    f.write('\\newcommand{{\\importSDPPrecEpsDim}}{{{0:d}}}\n'.format(dim))
    for precIdx, prec in zip(range(len(precs)), precs):
      f.write(('\\newcommand{{\\importSDPPrecEpsPrec' + 'I'*(precIdx + 1) + '}}{{\\ensuremath{{10^{{{0:d}}}}}}}\n').format(int(np.log10(prec))))
