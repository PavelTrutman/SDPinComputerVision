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
  matData = scipy.io.loadmat('data/POP_deg_coefs.mat', squeeze_me=True, struct_as_record=True)
  dim = matData['dim']
  unique = matData['unique']
  repeat = matData['repeat']
  degs = matData['degs'].tolist()
  rs = matData['rs'].tolist()
  coefs = matData['coefs']
  start = matData['start']

  timesAll = np.zeros(len(degs), dtype=np.object)
  resultsAll = np.zeros(len(degs), dtype=np.object)

  for degIdx in range(len(degs)):
    deg = degs[degIdx]
    r = rs[degIdx]
    print('{}: '.format(deg), end='', flush=True)
    coefsDeg = coefs[degIdx]
    startDeg = start[degIdx]
    objective = np.ones((deg, 1))
    startPoint = np.zeros((deg, 1))
    times = np.empty((unique, repeat))
    results = np.empty((unique, repeat), dtype=np.object)
    for j in range(unique):
      variables = polyopt.polalg.generateVariablesUpDegree(r, dim)
      f = {}
      for v, c in zip(variables, coefsDeg[:, j]):
        f[v] = c
      g = {tuple([0]*dim): 1}
      for i in range(dim):
        t = [0]*dim
        t[i] = 2
        g[tuple(t)] = -1
      startUnique = startDeg[:, j][:, np.newaxis]
      for i in range(repeat):
        timeStart = timeit.default_timer()
        problem = polyopt.POPSolver(f, [g], r)
        res = problem.solve(startUnique)
        times[j, i] = timeit.default_timer() - timeStart
        results[j, i] = res
      print('.', end='', flush=True)
    print()
    timesAll[degIdx] = times
    resultsAll[degIdx] = results

  scipy.io.savemat('data/POP_deg_timesPolyopt.mat', {'times': timesAll, 'results': resultsAll})
