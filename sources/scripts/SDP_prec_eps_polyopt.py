#!/usr/bin/python3

"""
Run performace tests for polyopt.

by Pavel Trutman, pavel.trutman@cvut.cz
"""

import timeit
import polyopt
import scipy.io
import numpy as np

if __name__ == '__main__':

  # load data
  matData = scipy.io.loadmat('data/SDP_prec_eps_matrices.mat', struct_as_record=False, squeeze_me=True)
  dim = matData['dim']
  unique = matData['unique']
  repeat = matData['repeat']
  bound = matData['bound']
  precs = matData['precs'].tolist()
  matrices = matData['matrices']

  timesAll = np.zeros(len(precs), dtype=np.object)
  itersAll = np.zeros(len(precs), dtype=np.object)

  for precIdx, prec in reversed(list(enumerate(precs))):
    print('{}: '.format(prec), end='', flush=True)
    objective = np.ones((dim, 1))
    startPoint = np.zeros((dim, 1))
    times = np.empty((unique, repeat))
    iters = np.empty((unique, repeat))
    for j in range(unique):
      problem = polyopt.SDPSolver(objective, [matrices[:, j]])
      problem.bound(bound)
      ac = problem.dampedNewton(startPoint)
      for i in range(repeat):
        problem = polyopt.SDPSolver(objective, [matrices[:, j]])
        problem.bound(bound)
        problem.eps = prec
        timeStart = timeit.default_timer()
        problem.mainFollow(ac)
        times[j, i] = timeit.default_timer() - timeStart
        iters[j, i] = problem.iterations
      print('.', end='', flush=True)
    print()
    timesAll[precIdx] = times
    itersAll[precIdx] = iters

  scipy.io.savemat('data/SDP_prec_eps_results.mat', {'times': timesAll, 'iters': itersAll})
