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
  matData = scipy.io.loadmat('data/POP_deg_coefs.mat', squeeze_me=True, struct_as_record=True)
  timesDataPolyopt = scipy.io.loadmat('data/POP_deg_timesPolyopt.mat', squeeze_me=True, struct_as_record=True)
  timesDataGloptipoly = scipy.io.loadmat('data/POP_deg_timesGloptipoly.mat', squeeze_me=True, struct_as_record=True)
  dim = matData['dim']
  unique = matData['unique']
  repeat = matData['repeat']
  rs = matData['rs'].tolist()
  degs = matData['degs'].tolist()
  SDPSize = matData['SDPSize'].tolist()
  timesPolyopt = timesDataPolyopt['times']
  timesGloptipoly = timesDataGloptipoly['times']
 
  # compute the stats
  avgPolyopt = np.empty((len(degs)))
  avgGloptipoly = np.empty((len(degs)))
  for degIdx in range(len(degs)):
    deg = degs[degIdx]
    r = rs[degIdx]
    avgPolyopt[degIdx] = np.mean(timesPolyopt[degIdx].min(axis=1))
    avgGloptipoly[degIdx] = np.mean(timesGloptipoly[degIdx].min(axis=1))

  # export to LaTeX
  with open('tables/POP_deg_performance.tex', 'wt') as fTable, open('data/POP_deg_performance.dat', 'wt') as fGraph:
    fTable.write('\\begin{tabular}{|c|c||c|r@{.}lr@{.}l|}\n')
    fTable.write('  \\hline\n')
    fTable.write('  \\multirow{2}{*}{\\textbf{Degree}} & \\textbf{Relaxation} & \\textbf{Dimension of} & \\multicolumn{4}{c|}{\\textbf{Toolbox}}\\\\\n')
    fTable.write('  \\cline{4-7}\n')
    fTable.write('  & \\textbf{order} & \\textbf{the SDP} & \\multicolumn{2}{c}{\\textbf{Polyopt}} & \\multicolumn{2}{c|}{\\textbf{Gloptipoly} \\cite{gloptipoly}}\\\\\n')
    fTable.write('  \hline\hline\n')
    for degIdx in range(len(degs)):
      deg = degs[degIdx]
      r = rs[degIdx]
      fTable.write('  {deg:d} & {r:d} & {sdp:d} & \\hspace{{1mm}} {polyopt:#.3g} s & \\hspace{{11mm}} {gloptipoly:#.3g} s\\\\\n'.format(deg=deg, r=r, sdp=SDPSize[degIdx], polyopt=avgPolyopt[degIdx], gloptipoly=avgGloptipoly[degIdx]).replace('.', '&'))
      fGraph.write('{deg:d} {polyopt} {gloptipoly}\n'.format(deg=deg, polyopt=avgPolyopt[degIdx], gloptipoly=avgGloptipoly[degIdx]))
    fTable.write('  \\hline')
    fTable.write('\\end{tabular}\n')

  with open('macros/POP_deg_performance.tex', 'wt') as f:
    f.write('\\newcommand{{\\importPOPDegPerformanceUnique}}{{{0:d}}}\n'.format(unique))
    f.write('\\newcommand{{\\importPOPDegPerformanceRepeat}}{{{0:d}}}\n'.format(repeat))
    f.write('\\newcommand{{\\importPOPDegPerformanceDegMin}}{{{0:d}}}\n'.format(min(degs)))
    f.write('\\newcommand{{\\importPOPDegPerformanceDegMax}}{{{0:d}}}\n'.format(max(degs)))
    f.write('\\newcommand{{\\importPOPDegPerformanceDim}}{{{0:d}}}\n'.format(dim))
