#!/usr/bin/python3

"""
Generates matrices for POP state of the art comparision.

by Pavel Trutman, pavel.trutman@fel.cvut.cz
"""

import scipy.io
import polyopt
import numpy as np
import numpy.random

if __name__ == '__main__':

  # set of dimensions
  dims = [1, 2, 3, 4, 5]

  # degree of f
  d = 2

  # relaxation order
  r = 1

  # number of different data for each dimension
  unique = 30

  # number of execution of each unique data
  repeat = 30

  coefsAll = np.zeros(len(dims), dtype=np.object)
  startAll = np.zeros(len(dims), dtype=np.object)
  SDPSize = []

  for dimIdx in range(len(dims)):
    dim = dims[dimIdx]
    variables = polyopt.polalg.generateVariablesUpDegree(2*r, dim)
    coefsDim = np.zeros((len(variables), unique), dtype=np.object)
    startDim = np.zeros((len(variables) - 1, unique), dtype=np.object)
    problem = polyopt.POPSolver({tuple([0]*dim): 0}, [{tuple([0]*dim): 0}], r)
    for j in range(unique):
      coefsDim[:, j] = np.random.uniform(-1, 1, (len(variables), ))
      startDim[:, j] = np.squeeze(problem.getFeasiblePointFromRadius(1))
    coefsAll[dimIdx] = coefsDim
    startAll[dimIdx] = startDim
    SDPSize.append(len(variables))

  scipy.io.savemat('data/POP_dim_coefs.mat', {'coefs': coefsAll, 'start': startAll, 'dims': dims, 'unique': unique, 'repeat': repeat, 'd': d, 'r': r, 'SDPSize': SDPSize})
