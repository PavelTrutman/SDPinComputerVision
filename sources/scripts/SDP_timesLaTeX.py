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
 
  # compute the stats
  avgPolyopt = np.empty((len(dims)))
  avgSedumi = np.empty((len(dims)))
  avgMosek = np.empty((len(dims)))
  for dimIdx in range(len(dims)):
    dim = dims[dimIdx]
    avgPolyopt[dimIdx] = np.mean(timesPolyopt[dimIdx].min(axis=1))
    avgSedumi[dimIdx] = np.mean(timesSedumi[dimIdx].min(axis=1))
    avgMosek[dimIdx] = np.mean(timesMosek[dimIdx].min(axis=1))

  # export to LaTeX
  with open('tables/SDP_performance.tex', 'wt') as fTable, open('data/SDP_performance.dat', 'wt') as fGraph:
    fTable.write('\\begin{tabular}{|c||ccc|}\n')
    fTable.write('  \\hline\n')
    fTable.write('  \\textbf{Dimension} & \\textbf{Polyopt} & \\textbf{SeDuMi} \\cite{sedumi} & \\textbf{MOSEK} \\cite{mosek}\\\\\n')
    fTable.write('  \hline\hline\n')
    for dimIdx in range(len(dims)):
      dim = dims[dimIdx]
      fTable.write('  {dim:d} & {polyopt:#.3g} s & {sedumi:#.3g} s & {mosek:#.3g} s\\\\\n'.format(dim=dim, polyopt=avgPolyopt[dimIdx], sedumi=avgSedumi[dimIdx], mosek=avgMosek[dimIdx]))
      fGraph.write('{dim:d} {polyopt} {sedumi} {mosek}\n'.format(dim=dim, polyopt=avgPolyopt[dimIdx], sedumi=avgSedumi[dimIdx], mosek=avgMosek[dimIdx]))
    fTable.write('  \\hline')
    fTable.write('\\end{tabular}\n')
