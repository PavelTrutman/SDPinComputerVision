#!/usr/bin/python3

"""
Generate macros about LADIO experimets.

by Pavel Trutman, pavel.trutman@fel.cvut.cz
"""

import scipy.io
import numpy as np

if __name__ == '__main__':

  # load data
  data = scipy.io.loadmat('data/app_LADIO.mat', struct_as_record=False, squeeze_me=True)['data']
 
  numCam = data.K.shape[0]
  num3D = data.X.shape[1]

  # export to LaTeX
  with open('macros/app_LADIO.tex', 'wt') as f:
    f.write('\\newcommand{{\\importAppLADIONumCameras}}{{\\num{{{0:d}}}}}\n'.format(numCam))
    f.write('\\newcommand{{\\importAppLADIONumPoints}}{{\\num{{{0:d}}}}}\n'.format(num3D))
