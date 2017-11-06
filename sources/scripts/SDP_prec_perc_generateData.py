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
  dims = [5, 10, 15, 20]

  # number of different data for each dimension
  unique = 1000

  # bound
  bound = 1e3

  # precisison
  eps = 1e-9

  # percentages
  percs = [1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8, 1e-9]

  matrices = np.empty((len(dims)), dtype=np.object)
  for dimIdx, dim in enumerate(dims):
    matricesDim = np.zeros((dim + 1, unique), dtype=np.object)
    for j in range(unique):
      matricesDim[0, j] = np.eye(dim)
      for i in range(1, dim + 1):
        matricesDim[i, j] = polyopt.utils.randomSymetric(dim)
    matrices[dimIdx] = matricesDim

  scipy.io.savemat('data/SDP_prec_perc_matrices.mat', {'matrices': matrices, 'dims': dims, 'unique': unique, 'bound': bound, 'percs': percs, 'eps': eps})
