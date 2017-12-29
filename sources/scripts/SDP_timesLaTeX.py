#!/usr/bin/python3

"""
Prepare table, datafile for GNUPlot and so on of time measurements of SDP.

by Pavel Trutman, pavel.trutman@fel.cvut.cz
"""

import scipy.io
import numpy as np

if __name__ == '__main__':

  # load data
  matData = scipy.io.loadmat('data/SDP_matrices.mat')
  timesDataPolyopt = scipy.io.loadmat('data/SDP_timesPolyopt.mat')
  timesDataSedumi = scipy.io.loadmat('data/SDP_timesSedumi.mat')
  timesDataMosek = scipy.io.loadmat('data/SDP_timesMosek.mat')
  dims = matData['dims'][0].tolist()
  unique = matData['unique'][0,0].tolist()
  repeat = matData['repeat'][0,0].tolist()
  bound = matData['bound'][0,0].tolist()
  matrices = matData['matrices'][0]
  timesPolyopt = timesDataPolyopt['times'][0]
  timesSedumi = timesDataSedumi['times'][0]
  timesMosek = timesDataMosek['times'][0]
  resultsPolyopt = timesDataPolyopt['results'][0]
  resultsSedumi = timesDataSedumi['results'][0]
  resultsMosek = timesDataMosek['results'][0]
 
  # compute the stats
  avgPolyopt = np.empty((len(dims)))
  avgSedumi = np.empty((len(dims)))
  avgMosek = np.empty((len(dims)))
  for dimIdx in range(len(dims)):

    # check correctness
    for j in range(unique):
      for i in range(repeat):
        rPolyopt = sum(resultsPolyopt[dimIdx][j, i])
        rSedumi = sum(resultsSedumi[dimIdx][j, i])
        rMosek = sum(resultsMosek[dimIdx][j, i])
        assert ((rPolyopt/rSedumi < 1 + 1e-3) & (rPolyopt/rSedumi > 1 - 1e-3)), 'Values of objective functions differ.'
        assert ((rPolyopt/rMosek < 1 + 1e-3) & (rPolyopt/rMosek > 1 - 1e-3)), 'Values of objective functions differ.'
        assert ((rMosek/rSedumi < 1 + 1e-3) & (rMosek/rSedumi > 1 - 1e-3)), 'Values of objective functions differ.'

    dim = dims[dimIdx]
    avgPolyopt[dimIdx] = np.mean(timesPolyopt[dimIdx].min(axis=1))
    avgSedumi[dimIdx] = np.mean(timesSedumi[dimIdx].min(axis=1))
    avgMosek[dimIdx] = np.mean(timesMosek[dimIdx].min(axis=1))

  # export to LaTeX
  digits = 7
  with open('tables/SDP_performance.tex', 'wt') as fTable, open('data/SDP_performance.dat', 'wt') as fGraph:
    fTable.write('\\begin{tabular}{|c||lll|}\n')
    fTable.write('  \\hline\n')
    fTable.write('  \\textbf{Problem} & \\multicolumn{3}{c|}{\\textbf{Toolbox}}\\\\\n')
    fTable.write('  \\cline{2-4}\n')
    fTable.write('  \\textbf{size} & \\multicolumn{1}{c}{\\textbf{Polyopt}} & \\multicolumn{1}{c}{\\textbf{SeDuMi} \\cite{sedumi}} & \\multicolumn{1}{c|}{\\textbf{MOSEK} \\cite{mosek}}\\\\\n')
    fTable.write('  \hline\hline\n')
    for dimIdx in range(len(dims)):
      dim = dims[dimIdx]
      frmPolyopt = '{:#.3g}'.format(avgPolyopt[dimIdx]).ljust(digits, '0')
      frmSedumi = '{:#.3g}'.format(avgSedumi[dimIdx]).ljust(digits, '0')
      frmMosek = '{:#.3g}'.format(avgMosek[dimIdx]).ljust(digits, '0')
      fTable.write('  {dim:d} & \\hspace{{1mm}} \\num{{{polyopt}}} s & \\hspace{{6mm}} \\num{{{sedumi}}} s & \\hspace{{5mm}} \\num{{{mosek}}} s\\\\\n'.format(dim=dim, polyopt=frmPolyopt, sedumi=frmSedumi, mosek=frmMosek))
      fGraph.write('{dim:d} {polyopt} {sedumi} {mosek}\n'.format(dim=dim, polyopt=avgPolyopt[dimIdx], sedumi=avgSedumi[dimIdx], mosek=avgMosek[dimIdx]))
    fTable.write('  \\hline')
    fTable.write('\\end{tabular}\n')

  with open('macros/SDP_performance.tex', 'wt') as f:
    f.write('\\newcommand{{\\importSDPPerformanceUnique}}{{{0:d}}}\n'.format(unique))
    f.write('\\newcommand{{\\importSDPPerformanceRepeat}}{{{0:d}}}\n'.format(repeat))
    f.write('\\newcommand{{\\importSDPPerformanceBound}}{{\\ensuremath{{10^{{{0:.0f}}}}}}}\n'.format(np.log10(bound)))
    f.write('\\newcommand{{\\importSDPPerformanceDimMin}}{{{0:d}}}\n'.format(min(dims)))
    f.write('\\newcommand{{\\importSDPPerformanceDimMax}}{{{0:d}}}\n'.format(max(dims)))
