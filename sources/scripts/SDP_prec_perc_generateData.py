#!/usr/bin/python3

"""
Generates matrices for SDP state of the art comparision.

by Pavel Trutman, pavel.trutman@cvut.cz
"""

import scipy.io
import polyopt
import numpy as np

if __name__ == '__main__':

  # dimension of the problem
  dim = 20

  # number of different data for each dimension
  unique = 10000

  # bound
  bound = 1e3

  # precisison
  eps = 1e-9

  # percentages
  percs = [float(x)/100.0 for x in [10, 1, 0.1, 0.01, 0.001, 0.0001]]

  matricesDim = np.zeros((dim + 1, unique), dtype=np.object)
  for j in range(unique):
    matricesDim[0, j] = np.eye(dim)
    for i in range(1, dim + 1):
      matricesDim[i, j] = polyopt.utils.randomSymetric(dim)

  scipy.io.savemat('data/SDP_prec_perc_matrices.mat', {'matrices': matricesDim, 'dim': dim, 'unique': unique, 'bound': bound, 'percs': percs, 'eps': eps})
