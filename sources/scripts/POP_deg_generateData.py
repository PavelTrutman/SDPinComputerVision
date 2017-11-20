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
  dim = 2

  # degree of f
  degs = [1, 2, 3, 4, 5, 6, 7]

  # relaxation order
  rs = [1, 1, 2, 2, 3, 3, 4]

  # number of different data for each dimension
  unique = 50

  # number of execution of each unique data
  repeat = 50

  coefsAll = np.zeros(len(degs), dtype=np.object)
  startAll = np.zeros(len(degs), dtype=np.object)
  SDPSize = []

  for degIdx in range(len(degs)):
    deg = degs[degIdx]
    r = rs[degIdx]
    variables = polyopt.polalg.generateVariablesUpDegree(2*r, dim)
    coefsDim = np.zeros((len(variables), unique), dtype=np.object)
    startDim = np.zeros((len(variables) - 1, unique), dtype=np.object)
    problem = polyopt.POPSolver({tuple([0]*dim): 0}, [{tuple([0]*dim): 0}], r)
    for j in range(unique):
      coefsDim[:, j] = np.random.uniform(-1, 1, (len(variables), ))
      startDim[:, j] = np.squeeze(problem.getFeasiblePointFromRadius(1))
    coefsAll[degIdx] = coefsDim
    startAll[degIdx] = startDim
    SDPSize.append(len(variables))

  scipy.io.savemat('data/POP_deg_coefs.mat', {'coefs': coefsAll, 'start': startAll, 'dim': dim, 'unique': unique, 'repeat': repeat, 'degs': degs, 'rs': rs, 'SDPSize': SDPSize})
