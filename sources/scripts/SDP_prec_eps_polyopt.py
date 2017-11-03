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
  dims = matData['dims'].tolist()
  unique = matData['unique']
  bound = matData['bound']
  precs = matData['precs'].tolist()
  matrices = matData['matrices']

  iters = np.zeros((len(dims), ), dtype=np.object)
  for dimIdx, dim in reversed(list(enumerate(dims))):
    print('dim: ', dim)
    matricesDim = matrices[dimIdx]
    itersDim = np.empty((len(precs), unique))
    for precIdx, prec in reversed(list(enumerate(precs))):
      print('{}: '.format(prec), end='', flush=True)
      objective = np.ones((dim, 1))
      startPoint = np.zeros((dim, 1))
      for j in range(unique):
        problem = polyopt.SDPSolver(objective, [matricesDim[:, j]])
        problem.bound(bound)
        ac = problem.dampedNewton(startPoint)
        problem.iterations = 0
        problem.eps = prec
        problem.mainFollow(ac)
        itersDim[precIdx, j] = problem.iterations
        print('.', end='', flush=True)
      print()
    iters[dimIdx] = itersDim

  scipy.io.savemat('data/SDP_prec_eps_results.mat', {'iters': iters})
