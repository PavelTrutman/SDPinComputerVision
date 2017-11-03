#!/usr/bin/python3

"""
Run performace tests for polyopt.

by Pavel Trutman, pavel.trutman@cvut.cz
"""

import polyopt
import scipy.io
import numpy as np

if __name__ == '__main__':

  # load data
  matData = scipy.io.loadmat('data/SDP_prec_perc_matrices.mat', struct_as_record=False, squeeze_me=True)
  dim = matData['dim']
  unique = matData['unique']
  bound = matData['bound']
  percs = matData['percs'].tolist()
  matrices = matData['matrices']

  iters = np.zeros((unique, len(percs)))

  objective = np.ones((dim, 1))
  startPoint = np.zeros((dim, 1))
  for j in range(unique):
    problem = polyopt.SDPSolver(objective, [matrices[:, j]])
    problem.bound(bound)
    ac = problem.dampedNewton(startPoint)
    problem = polyopt.SDPSolver(objective, [matrices[:, j]])
    problem.bound(bound)
    problem.eps = 1e-9
    problem.saveX = True
    xStar = problem.mainFollow(ac)

    xAll = problem.xAll

    dist = np.linalg.norm(xStar - ac)
    thresholdIdx = 0
    threshold = dist*percs[thresholdIdx]
    itersMax = xAll.shape[1]
    for k in range(itersMax):
      xLocal = xAll[:, k][:, np.newaxis]
      d = np.linalg.norm(xStar - xLocal)
      if d < threshold:
        iters[j, thresholdIdx] = k/itersMax
        if thresholdIdx != len(percs) - 1:
          thresholdIdx += 1
          threshold = dist*percs[thresholdIdx]
        else:
          break
    print('.', end='', flush=True)

  scipy.io.savemat('data/SDP_prec_perc_results.mat', {'iters': iters})
