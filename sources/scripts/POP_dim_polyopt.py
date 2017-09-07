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
  matData = scipy.io.loadmat('data/POP_dim_coefs.mat', squeeze_me=True, struct_as_record=True)
  dims = matData['dims'].tolist()
  unique = matData['unique']
  repeat = matData['repeat']
  d = matData['d']
  r = matData['r']
  coefs = matData['coefs']
  start = matData['start']

  timesAll = np.zeros(len(dims), dtype=np.object)
  resultsAll = np.zeros(len(dims), dtype=np.object)

  for dimIdx in range(len(dims)):
    dim = dims[dimIdx]
    print('{}: '.format(dim), end='', flush=True)
    coefsDim = coefs[dimIdx]
    startDim = start[dimIdx]
    objective = np.ones((dim, 1))
    startPoint = np.zeros((dim, 1))
    times = np.empty((unique, repeat))
    results = np.empty((unique, repeat), dtype=np.object)
    for j in range(unique):
      variables = polyopt.polalg.generateVariablesUpDegree(d, dim)
      f = {}
      for v, c in zip(variables, coefsDim[:, j]):
        f[v] = c
      g = {tuple([0]*dim): 1}
      for i in range(dim):
        t = [0]*dim
        t[i] = 2
        g[tuple(t)] = -1
      startUnique = startDim[:, j][:, np.newaxis]
      for i in range(repeat):
        timeStart = timeit.default_timer()
        problem = polyopt.POPSolver(f, [g], r)
        res = problem.solve(startUnique)
        times[j, i] = timeit.default_timer() - timeStart
        results[j, i] = res
      print('.', end='', flush=True)
    print()
    timesAll[dimIdx] = times
    resultsAll[dimIdx] = results

  scipy.io.savemat('data/POP_dim_timesPolyopt.mat', {'times': timesAll, 'results': resultsAll})
