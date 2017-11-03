#!/usr/bin/python3

"""
Generates matrices for SDP state of the art comparision.

by Pavel Trutman, pavel.trutman@cvut.cz
"""

import scipy.io
import polyopt
import numpy as np

if __name__ == '__main__':

  dim = 20

  # number of different data for each dimension
  unique = 1000

  # number of execution of each unique data
  repeat = 50

  # bound
  bound = 1e3

  # precision
  precs = [10**i for i in [0, -3, -6, -9]]

  matricesDim = np.zeros((dim + 1, unique), dtype=np.object)
  for j in range(unique):
    matricesDim[0, j] = np.eye(dim)
    for i in range(1, dim + 1):
      matricesDim[i, j] = polyopt.utils.randomSymetric(dim)

  scipy.io.savemat('data/SDP_prec_eps_matrices.mat', {'matrices': matricesDim, 'dim': dim, 'unique': unique, 'repeat': repeat, 'bound': bound, 'precs': precs})
