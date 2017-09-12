#!/usr/bin/python3

"""
Load and prepare data for the P3P problem.

by Pavel Trutman, pavel.trutman@fel.cvut.cz
"""

import click
import random
import scipy.io
import itertools
import numpy as np
import numpy.matlib
import scipy.linalg

# size of the generated data
camSelNum = 20
tripletsSelNum = 100
pointSelNum = 3

# file paths
fileLadioPath = 'data/app_LADIO.mat'
fileCamsPath = 'data/app_P3P_cams.mat'
fileSolAGPath = 'data/app_P3P_solAG.mat'
fileSolPolyoptPath = 'data/app_P3P_solPolyopt.mat'
fileResultsPath = 'data/app_P3P_results.mat'

# command line arguments parsing
@click.group()
def cli():
  pass


@cli.command()
def generateLatexMacros():
  """
  Generates macros for LaTeX.

  Returns:
    None
  """

  # export to LaTeX
  with open('macros/app_P3P.tex', 'wt') as f:
    f.write('\\newcommand{{\\importAppPPPNumCameras}}{{\\num{{{0:d}}}}}'.format(camSelNum))
    f.write('\\newcommand{{\\importAppPPPNumPoints}}{{\\num{{{0:d}}}}}'.format(tripletsSelNum))


@cli.command()
def prepareData():
  """
  Processes the data from the Ladio project and selects the points and computes the P3P polynomial coefficients.

  Returns:
    None
  """

  # load the data
  data = scipy.io.loadmat(fileLadioPath, struct_as_record=True)
  X = data['data']['X'][0, 0].astype('float64')
  Xid = data['data']['Xid'][0, 0].astype('int')
  u = data['data']['u'][0, 0][0]
  uid = data['data']['uid'][0, 0][0]
  inliers = data['data']['inliers'][0, 0][0]
  K = data['data']['K'][0, 0][0]
  R = data['data']['R'][0, 0][0]
  C = data['data']['C'][0, 0][0]
  camNum = K.shape[0]

  saveobj = np.zeros((camSelNum,), dtype=np.object)

  # select some cameras and triplets of points
  camSel = np.random.permutation(camNum)[:camSelNum]
  for cam, i in zip(camSel, range(camSelNum)):
    uIn = u[cam][np.matlib.repmat(inliers[cam].astype(bool), 2, 1)].reshape((2, -1))
    uIdIn = uid[cam][inliers[cam].astype(bool)]
    KCam = K[cam].astype('float64')
    CCam = C[cam][:, 0].astype('float64')

    saveobj[i] = {'camId': cam, 'a': np.zeros((tripletsSelNum), dtype=np.object), 'u': np.zeros((tripletsSelNum), dtype=np.object), 'x': np.zeros((tripletsSelNum), dtype=np.object)}

    for triplet in range(tripletsSelNum):
      ids = random.sample(uIdIn.tolist(), pointSelNum)
      x1 = X[:, np.where(Xid == ids[0])[1]]
      x2 = X[:, np.where(Xid == ids[1])[1]]
      x3 = X[:, np.where(Xid == ids[2])[1]]
      u1 = u[cam][:, np.where(uid[cam] == ids[0])[1]].astype('float64')
      u2 = u[cam][:, np.where(uid[cam] == ids[1])[1]].astype('float64')
      u3 = u[cam][:, np.where(uid[cam] == ids[2])[1]].astype('float64')
      a0, a1, a2, a3, a4 = P3PPol(KCam, x1, x2, x3, u1, u2, u3)

      # save the data
      saveobj[i]['a'][triplet] = [a0, a1, a2, a3, a4]
      saveobj[i]['u'][triplet] = np.hstack((u1, u2, u3))
      saveobj[i]['x'][triplet] = np.hstack((x1, x2, x3))

  scipy.io.savemat(fileCamsPath, {'cams': saveobj})


@cli.command()
def processData(case=['AG', 'Polyopt', 'Mosek', 'Gloptipoly']):
  """
  Processes solutions from the given toolbox and computes error to the ground truth.

  Args:
    case (list): list of names of the toolboxes

  Returns:
    None
  """

  cams = scipy.io.loadmat(fileCamsPath, struct_as_record=False, squeeze_me=True)['cams']
  data = scipy.io.loadmat(fileLadioPath, struct_as_record=False, squeeze_me=True)['data']

  sol = {}
  resErr = {}
  resCDist = {}
  resRAngle = {}
  resErrAll = {}
  for c in case:
    sol[c] = scipy.io.loadmat('data/app_P3P_sol' + c + '.mat', struct_as_record=False, squeeze_me=True)['sol']
    resErr[c] = []
    resCDist[c] = []
    resRAngle[c] = []
    resErrAll[c] = []
  errGT = []

  camNum = cams.shape[0]
  for cam, k in zip(cams, range(camNum)):
    camId = cam.camId
    print('camId:', camId)
    K = data.K[camId]
    Xid = data.Xid
    inliers = data.inliers[camId].astype(bool)
    uid = data.uid[camId]
    uIdIn = uid[inliers]
    Xidxs = [np.where(Xid == idx)[0][0] for idx in uIdIn]
    X = data.X[:, Xidxs]
    XP = np.vstack((X, np.ones((1, X.shape[1]))))
    uIn = data.u[camId][np.matlib.repmat(inliers, 2, 1)].reshape((2, -1))
    CGT = data.C[camId]
    RGT = data.R[camId]

    for c in case:
      n = sol[c].shape[1]
      err = []
      RAll = []
      CAll = []
      for i in range(n):
        x = cam.x[i]
        x1 = x[:, 0][:, np.newaxis]
        x2 = x[:, 1][:, np.newaxis]
        x3 = x[:, 2][:, np.newaxis]
        u = cam.u[i]
        u1 = u[:, 0][:, np.newaxis]
        u2 = u[:, 1][:, np.newaxis]
        u3 = u[:, 2][:, np.newaxis]
        if not np.isnan(sol[c][k, i]).any():
          if (type(sol[c][k, i]) == float) or (type(sol[c][k, i]) == int):
            sol[c][k, i] = [sol[c][k, i]]
          for s in sol[c][k, i]:
            RC = P3PRC(s, K, x1, x2, x3, u1, u2, u3)
            if RC is not None:
              R = RC[0]
              C = RC[1]
              P = np.hstack((K.dot(R), -K.dot(R).dot(C)[:, np.newaxis]))
              uProjP = P.dot(XP)
              uProj = np.vstack((uProjP[0, :]/uProjP[2, :], uProjP[1, :]/uProjP[2, :]))
              e = np.sqrt(np.sum((uProj - uIn)**2, 0))
              err.append(np.max(e))
              RAll.append(R)
              CAll.append(C)

      # pick the best cam
      if len(err) == 0:
        resErr[c].append(np.nan)
        resCDist[c].append(np.nan)
        resRAngle[c].append(np.nan)
      else:
        camMin = np.argmin(err)
        resErr[c].append(err[camMin])
        resCDist[c].append(np.linalg.norm(CAll[camMin] - CGT))
        resRAngle[c].append(np.arccos((np.trace(np.linalg.inv(RGT).dot(RAll[camMin]))-1)/2))
        print((np.trace(np.linalg.inv(RGT).dot(RAll[camMin]))-1)/2)
      resErrAll[c].append(err)

    # compute ground truth
    K = data.K[camId]
    R = data.R[camId]
    C = data.C[camId]
    P = np.hstack((K.dot(R), -K.dot(R).dot(C)[:, np.newaxis]))
    uProjP = P.dot(XP)
    uProj = np.vstack((uProjP[0, :]/uProjP[2, :], uProjP[1, :]/uProjP[2, :]))
    e = np.sqrt(np.sum((uProj - uIn)**2, 0))
    errGT.append(np.max(e))

  saveobj = {}
  for c in case:
    saveobj[c] = {'CDist': resCDist[c], 'RAngle': resRAngle[c], 'err': resErr[c], 'errAll': resErrAll[c]}
  saveobj['GT'] = {'err': errGT}
  scipy.io.savemat(fileResultsPath, saveobj)


@cli.command()
def solveAG():
  """
  Solves thr P3P polynomial using companion matrix and eigenvalues computation.


  Returns:
    None
  """

  cams = scipy.io.loadmat(fileCamsPath, struct_as_record=False, squeeze_me=True)['cams']
  n = cams[0].a.shape[0]
  saveobj = np.zeros((cams.shape[0], n), dtype=np.object)

  for cam, j in zip(cams, range(cams.shape[0])):
    for i in range(n):
      a = cam.a[i]
      comp = scipy.linalg.companion(a[::-1])
      eigs = np.linalg.eigvals(comp)
      sol = np.real(eigs[np.isreal(eigs)])
      saveobj[j, i] = sol
  scipy.io.savemat(fileSolAGPath, {'sol': saveobj})


@cli.command()
def solvePolyopt():
  """
  Solves the P3P polynommial with the Polyopt package.

  Returns:
    None
  """

  import sys
  sys.path.append('/media/SSD/Dokumenty/Skola/CMP/moment method for real roots finding')
  from solve import solve

  cams = scipy.io.loadmat(fileCamsPath, struct_as_record=False, squeeze_me=True)['cams']
  n = cams[0].a.shape[0]
  saveobj = np.zeros((cams.shape[0], n), dtype=np.object)

  for cam, j in zip(cams, range(cams.shape[0])):
    for i in range(n):
      a = cam.a[i]
      I = [{(0, ): a[0], (1, ): a[1], (2, ): a[2], (3, ): a[3], (4, ): a[4]}]
      sol = solve(I)
      print(sol)
      saveobj[j, i] = sol
  scipy.io.savemat(fileSolPolyoptPath, {'sol': saveobj})


def P3PPol(K, x1, x2, x3, u1, u2, u3):
  """
  Coefficients of polynomial for calibrated camera pose estimation.
  
  Args:
    K (array): calibration matrix
    x1, x2, x3 (matrix): 3D points
    u1, u2, u3 (matrix): 2D projections

  Returns:
    float, float, float, float, float: coefficients a0, a1, a2, a3, a4 of polynomial
  """
  
  # distances
  _, d12, d31, d23, c12, c31, c23 = P3PDist(K, x1, x2, x3, u1, u2, u3)

  # polynomial
  a4 = -4*d23**4*d12**2*d31**2*c23**2+d23**8-2*d23**6*d12**2-2*d23**6*d31**2+d23**4*d12**4+2*d23**4*d12**2*d31**2+d23**4*d31**4
  a3 = 8*d23**4*d12**2*d31**2*c12*c23**2+4*d23**6*d12**2*c31*c23-4*d23**4*d12**4*c31*c23+4*d23**4*d12**2*d31**2*c31*c23-4*d23**8*c12+4*d23**6*d12**2*c12+8*d23**6*d31**2*c12-4*d23**4*d12**2*d31**2*c12-4*d23**4*d31**4*c12
  a2 = -8*d23**6*d12**2*c31*c12*c23-8*d23**4*d12**2*d31**2*c31*c12*c23+4*d23**8*c12**2-4*d23**6*d12**2*c31**2-8*d23**6*d31**2*c12**2+4*d23**4*d12**4*c31**2+4*d23**4*d12**4*c23**2-4*d23**4*d12**2*d31**2*c23**2+4*d23**4*d31**4*c12**2+2*d23**8-4*d23**6*d31**2-2*d23**4*d12**4+2*d23**4*d31**4
  a1 = 8*d23**6*d12**2*c31**2*c12+4*d23**6*d12**2*c31*c23-4*d23**4*d12**4*c31*c23+4*d23**4*d12**2*d31**2*c31*c23-4*d23**8*c12-4*d23**6*d12**2*c12+8*d23**6*d31**2*c12+4*d23**4*d12**2*d31**2*c12-4*d23**4*d31**4*c12
  a0 = -4*d23**6*d12**2*c31**2+d23**8-2*d23**4*d12**2*d31**2+2*d23**6*d12**2+d23**4*d31**4+d23**4*d12**4-2*d23**6*d31**2

  return (a0, a1, a2, a3, a4)


def P3PRC(sol, K, x1, x2, x3, u1, u2, u3):
  """
  Recovers R and C from the solution to the P3P polynomial.

  Args:
    sol (float): solution to the P3P polynomial
    K (array): calibration matrix
    x1, x2, x3 (matrix): 3D points
    u1, u2, u3 (matrix): 2D projections

  Returns:
    array, array: rotational matrix, camera position
  """

  # distance threshold
  thr = 1e-9

  # distances
  Kinv, d12, d31, d23, c12, c31, c23 = P3PDist(K, x1, x2, x3, u1, u2, u3)

  # projective coordinates
  u1 = np.append(u1, 1)
  u2 = np.append(u2, 1)
  u3 = np.append(u3, 1)

  n12 = sol
  # recover n1, n2, n3
  m1 = d12**2
  p1 = -2*d12**2*n12*c23
  q1 = d23**2*(1 + n12**2 - 2*n12*c12) - d12**2*n12**2
  m2 = d31**2 - d23**2
  p2 = 2*d23**2*c31 - 2*d31**2*n12*c23
  q2 = d23**2 - d31**2*n12**2
  n13 = (m1*q2 - m2*q1)/(m1*p2 - m2*p1)
  n1 = d12/np.sqrt(1 + n12**2 - 2*n12*c12)
  n2 = n1*n12
  n3 = n1*n13
  N = [n1, n2, n3]

  # verify distances
  e = np.array([(np.sqrt(n1**2 + n2**2 - 2*n1*n2*c12) - d12)/d12, (np.sqrt(n1**2 + n3**2 - 2*n1*n3*c31) - d31)/d31, (np.sqrt(n2**2 + n3**2 - 2*n2*n3*c23) - d23)/d23])
  if (abs(e) > thr).all():
    return None


  # recover R, C
  xgamma = [Kinv.dot(u1), Kinv.dot(u2), Kinv.dot(u3)]

  yeps = np.zeros((3, 3))
  for i in range(3):
    yeps[:, i] = N[i]*xgamma[i]/np.linalg.norm(xgamma[i])

  zeps = np.zeros((3, 3))
  zeps[:, 1] = yeps[:, 1] - yeps[:, 0]
  zeps[:, 2] = yeps[:, 2] - yeps[:, 0]
  zeps[:, 0] = np.cross(zeps[:, 1], zeps[:, 2])

  zdelta = np.zeros((3, 3))
  zdelta[:, 1] = (x2 - x1)[:, 0]
  zdelta[:, 2] = (x3 - x1)[:, 0]
  zdelta[:, 0] = np.cross(zdelta[:, 1], zdelta[:, 2])

  R = zeps.dot(np.linalg.inv(zdelta))
  C = x1[:, 0] - R.T.dot(yeps[:, 0])
  return R, C


def P3PDist(K, x1, x2, x3, u1, u2, u3):
  """
  Computes the cosines and distances between three points and their projections.

  Args:
    K (array): calibration matrix
    x1, x2, x3 (matrix): 3D points
    u1, u2, u3 (matrix): 2D projections

  Returns:
    array, float, float, float, float, float, float: inversion of the calibration matrix, three distances between 3D points, three cosines of the angles of the projection rays
  """

  # projective coordinates
  u1 = np.append(u1, 1)
  u2 = np.append(u2, 1)
  u3 = np.append(u3, 1)

  Kinv = np.linalg.inv(K)

  # compute distances and cosines
  d12 = np.linalg.norm(x1 - x2)
  d31 = np.linalg.norm(x1 - x3)
  d23 = np.linalg.norm(x2 - x3)
  c12 = u1.T.dot(np.linalg.inv(K.T)).dot(Kinv).dot(u2)/(np.linalg.norm(Kinv.dot(u1))*np.linalg.norm(Kinv.dot(u2)))
  c31 = u1.T.dot(np.linalg.inv(K.T)).dot(Kinv).dot(u3)/(np.linalg.norm(Kinv.dot(u1))*np.linalg.norm(Kinv.dot(u3)))
  c23 = u2.T.dot(np.linalg.inv(K.T)).dot(Kinv).dot(u3)/(np.linalg.norm(Kinv.dot(u2))*np.linalg.norm(Kinv.dot(u3)))

  return Kinv, d12, d31, d23, c12, c31, c23


if __name__ == '__main__':
  #prepareData()
  #solveAG()
  #solvePolyopt()
  #processData(['AG', 'Polyopt', 'Mosek', 'Gloptipoly'])
  cli()
