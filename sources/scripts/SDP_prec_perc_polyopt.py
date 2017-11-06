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
  dims = matData['dims']
  unique = matData['unique']
  bound = matData['bound']
  percs = matData['percs'].tolist()
  matrices = matData['matrices']

  iters = np.empty((len(dims, )), dtype=np.object)

  for dimIdx, dim in reversed(list(enumerate(dims))):
    print(str(dim) + ': ', end='', flush=True)
    objective = np.ones((dim, 1))
    startPoint = np.zeros((dim, 1))
    itersDim = np.zeros((unique, len(percs)))
    matricesDim = matrices[dimIdx]
    for j in range(unique):
      problem = polyopt.SDPSolver(objective, [matricesDim[:, j]])
      problem.bound(bound)
      ac = problem.dampedNewton(startPoint)
      problem = polyopt.SDPSolver(objective, [matricesDim[:, j]])
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
          itersDim[j, thresholdIdx] = k
          if thresholdIdx != len(percs) - 1:
            thresholdIdx += 1
            threshold = dist*percs[thresholdIdx]
          else:
            break
      print('.', end='', flush=True)
    iters[dimIdx] = itersDim
    print()

  scipy.io.savemat('data/SDP_prec_perc_results.mat', {'iters': iters})
