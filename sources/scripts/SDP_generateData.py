#!/usr/bin/python3

"""
Generates matrices for SDP state of the art comparision.

by Pavel Trutman, pavel.trutman@fel.cvut.cz
"""

import scipy.io
import polyopt.utils
import numpy as np

if __name__ == '__main__':

  # set of dimensions
  dims = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]

  # number of different data for each dimension
  unique = 50

  # number of execution of each unique data
  repeat = 50

  # bound
  bound = 1e3

  matricesAll = np.zeros(len(dims), dtype=np.object)

  for dimIdx in range(len(dims)):
    dim = dims[dimIdx]
    matricesDim = np.zeros((dim + 1, unique), dtype=np.object)
    for j in range(unique):
      matricesDim[0, j] = np.eye(dim)
      for i in range(1, dim + 1):
        matricesDim[i, j] = polyopt.utils.randomSymetric(dim)
    matricesAll[dimIdx] = matricesDim

  scipy.io.savemat('data/SDP_matrices.mat', {'matrices': matricesAll, 'dims': dims, 'unique': unique, 'repeat': repeat, 'bound': bound})
