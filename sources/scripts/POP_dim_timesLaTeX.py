#!/usr/bin/python3

"""
Prepare table, datafile for GNUPlot and so on of time measurements of SDP.

by Pavel Trutman, pavel.trutman@fel.cvut.cz
"""

import scipy.io
import numpy as np
import sys

if __name__ == '__main__':

  # load data
  matData = scipy.io.loadmat('data/POP_dim_coefs.mat', squeeze_me=True, struct_as_record=True)
  timesDataPolyopt = scipy.io.loadmat('data/POP_dim_timesPolyopt.mat', squeeze_me=True, struct_as_record=True)
  timesDataGloptipoly = scipy.io.loadmat('data/POP_dim_timesGloptipoly.mat', squeeze_me=True, struct_as_record=True)
  dims = matData['dims'].tolist()
  unique = matData['unique']
  repeat = matData['repeat']
  r = matData['r']
  d = matData['d']
  SDPSize = matData['SDPSize'].tolist()
  timesPolyopt = timesDataPolyopt['times']
  timesGloptipoly = timesDataGloptipoly['times']
 
  # compute the stats
  avgPolyopt = np.empty((len(dims)))
  avgGloptipoly = np.empty((len(dims)))
  for dimIdx in range(len(dims)):
    dim = dims[dimIdx]
    avgPolyopt[dimIdx] = np.mean(timesPolyopt[dimIdx].min(axis=1))
    avgGloptipoly[dimIdx] = np.mean(timesGloptipoly[dimIdx].min(axis=1))

  # export to LaTeX
  digits = 7
  with open('tables/POP_dim_performance.tex', 'wt') as fTable, open('data/POP_dim_performance.dat', 'wt') as fGraph:
    fTable.write('\\begin{tabular}{|c||c|ll|}\n')
    fTable.write('  \\hline\n')
    fTable.write('  \\textbf{Number of} & \\textbf{Dimension of} & \\multicolumn{2}{c|}{\\textbf{Toolbox}}\\\\\n')
    fTable.write('  \\cline{3-4}\n')
    fTable.write('  \\textbf{variables} & \\textbf{the SDP} & \\multicolumn{1}{c}{\\textbf{Polyopt}} & \\multicolumn{1}{c|}{\\textbf{Gloptipoly} \\cite{gloptipoly}}\\\\\n')
    fTable.write('  \hline\hline\n')
    for dimIdx in range(len(dims)):
      dim = dims[dimIdx]
      frmPolyopt = '{:#.3g}'.format(avgPolyopt[dimIdx]).ljust(digits, '0')
      frmGloptipoly = '{:#.3g}'.format(avgGloptipoly[dimIdx]).ljust(digits, '0')
      fTable.write('  {dim:d} & {sdp:d} & \\hspace{{1mm}} \\num{{{polyopt}}} s & \\hspace{{11mm}} \\num{{{gloptipoly}}} s\\\\\n'.format(dim=dim, sdp=SDPSize[dimIdx], polyopt=frmPolyopt, gloptipoly=frmGloptipoly))
      fGraph.write('{dim:d} {polyopt} {gloptipoly}\n'.format(dim=dim, polyopt=avgPolyopt[dimIdx], gloptipoly=avgGloptipoly[dimIdx]))
    fTable.write('  \\hline')
    fTable.write('\\end{tabular}\n')

  with open('macros/POP_dim_performance.tex', 'wt') as f:
    f.write('\\newcommand{{\\importPOPDimPerformanceUnique}}{{{0:d}}}\n'.format(unique))
    f.write('\\newcommand{{\\importPOPDimPerformanceRepeat}}{{{0:d}}}\n'.format(repeat))
    f.write('\\newcommand{{\\importPOPDimPerformanceDimMin}}{{{0:d}}}\n'.format(min(dims)))
    f.write('\\newcommand{{\\importPOPDimPerformanceDimMax}}{{{0:d}}}\n'.format(max(dims)))
    f.write('\\newcommand{{\\importPOPDimPerformanceD}}{{{0:d}}}\n'.format(d))
    f.write('\\newcommand{{\\importPOPDimPerformanceR}}{{{0:d}}}\n'.format(r))
