#!/usr/bin/python3

"""
Run performace tests for polyopt.

by Pavel Trutman, pavel.trutman@fel.cvut.cz
"""

import timeit
import polyopt
import scipy.io
import numpy as np

if __name__ == '__main__':

  # load data
  matData = scipy.io.loadmat('data/SDP_matrices.mat')
  dims = matData['dims'][0].tolist()
  unique = matData['unique'][0,0].tolist()
  repeat = matData['repeat'][0,0].tolist()
  bound = matData['bound'][0,0].tolist()
  matrices = matData['matrices'][0]
  
  timesAll = np.zeros(len(dims), dtype=np.object)
  resultsAll = np.zeros(len(dims), dtype=np.object)

  for dimIdx in range(len(dims)):
    dim = dims[dimIdx]
    print('{}: '.format(dim), end='', flush=True)
    matricesDim = matrices[dimIdx]
    objective = np.ones((dim, 1))
    startPoint = np.zeros((dim, 1))
    times = np.empty((unique, repeat, 2))
    results = np.empty((unique, repeat), dtype=np.object)
    for j in range(unique):
      for i in range(repeat):
        timeStartOffline = timeit.default_timer()
        problem = polyopt.SDPSolver(objective, [matricesDim[:, j]])
        problem.bound(bound)
        timeStartOnline = timeit.default_timer()
        r = problem.solve(startPoint, problem.dampedNewton)
        timeEnd = timeit.default_timer()
        times[j, i, 0] = timeStartOnline - timeStartOffline
        times[j, i, 1] = timeEnd - timeStartOnline
        results[j, i] = r
      print('.', end='', flush=True)
    print()
    timesAll[dimIdx] = times
    resultsAll[dimIdx] = results

  scipy.io.savemat('data/SDP_timesPolyopt.mat', {'times': timesAll, 'results': resultsAll})
