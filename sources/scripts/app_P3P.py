#!/usr/bin/python3

"""
Load and prepare data for the P3P problem.

by Pavel Trutman, pavel.trutman@fel.cvut.cz
"""

import click
import random
import timeit
import scipy.io
import itertools
import numpy as np
import numpy.matlib
import scipy.linalg

# size of the generated data
camSelNum = 67
tripletsSelNum = 1000
pointSelNum = 3

# file paths
fileMacrosPath = 'macros/app_P3P.tex'
fileLadioPath = 'data/app_LADIO.mat'
fileCamsPath = 'data/app_P3P_cams.mat'
fileSolAGPath = 'data/app_P3P_solAG.mat'
fileSolPolyoptPath = 'data/app_P3P_solPolyopt.mat'
fileResultsPath = 'data/app_P3P_results.mat'
fileGnuplotErrPath = 'data/app_P3P_err.dat'
fileGnuplotCDistPath = 'data/app_P3P_cdist.dat'
fileGnuplotRAnglePath = 'data/app_P3P_rangle.dat'
fileGnuplotTimesPath = 'data/app_P3P_times.dat'
fileGnuplotRelaxPath = 'data/app_P3P_relax.dat'

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
  with open(fileMacrosPath, 'wt') as f:
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
    print(str(i) + ' of ' + str(camSelNum))
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
  times = {}
  relax = {}
  resErr = {}
  resCDist = {}
  resRAngle = {}
  resErrAll = {}
  resTimes = {}
  resRelax = {}
  for c in case:
    d = scipy.io.loadmat('data/app_P3P_sol' + c + '.mat', struct_as_record=False, squeeze_me=True)
    sol[c] = d['sol']
    times[c] = d['times']
    if c not in ['AG']:
      relax[c] = d['relaxOrders']
    resErr[c] = []
    resCDist[c] = []
    resRAngle[c] = []
    resErrAll[c] = []
    if c in ['Mosek', 'Polyopt']:
      resTimes[c] = np.zeros((2, 0))
    else:
      resTimes[c] = np.zeros((1, 0))
    resRelax[c] = []
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
        camMin = np.nanargmin(err)
        resErr[c].append(err[camMin])
        resCDist[c].append(np.linalg.norm(CAll[camMin] - CGT))
        acos = (np.trace(np.linalg.solve(RGT, RAll[camMin]))-1)/2
        resRAngle[c].append(np.arccos(1 - np.linalg.norm(acos - 1)))
      resErrAll[c].append(err)
      if c in ['Mosek', 'Polyopt']:
        resTimes[c] = np.hstack((resTimes[c], times[c][k, :].T))
      else:
        resTimes[c] = np.hstack((resTimes[c], times[c][k, np.newaxis]))
      #resTimes[c].extend(times[c][k, :].tolist())
      if c not in ['AG']:
        resRelax[c].extend(relax[c][k, :].tolist())

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
    saveobj[c] = {'CDist': resCDist[c], 'RAngle': resRAngle[c], 'err': resErr[c], 'errAll': resErrAll[c], 'times': resTimes[c], 'relaxOrders': resRelax[c]}
  saveobj['GT'] = {'err': errGT}
  scipy.io.savemat(fileResultsPath, saveobj)


@cli.command()
def generateGnuplot(case=['GT', 'AG', 'Polyopt', 'Mosek', 'Gloptipoly']):
  """
  Generates data for gnuplot graphs.

  Args:
    case (list): list of names of the toolboxes

  Reurns:
    None
  """

  results = scipy.io.loadmat(fileResultsPath, struct_as_record=False, squeeze_me=True)

  with open(fileGnuplotErrPath, 'wt') as fErr, open(fileGnuplotCDistPath, 'wt') as fCDist, open(fileGnuplotRAnglePath, 'wt') as fRAngle:
    for cam in range(camSelNum):
      for c in case:
        fErr.write('{} '.format(np.log10(results[c].err[cam])))
        if c is not 'GT':
          fCDist.write('{} '.format(np.log10(results[c].CDist[cam])))
          if np.isnan(results[c].RAngle[cam]):
            fRAngle.write('0 ')
          else:
            fRAngle.write('{} '.format(np.log10(results[c].RAngle[cam])))
      fErr.write('\n')
      fCDist.write('\n')
      fRAngle.write('\n')
  with open(fileGnuplotTimesPath, 'wt') as fTimes:
    print(results['AG'].times.shape)
    for i in range(results['AG'].times.shape[0]):
      fTimes.write('{} '.format(np.log10(results['AG'].times[i])))
      fTimes.write('{} '.format(np.log10(results['Polyopt'].times[0, i])))
      fTimes.write('{} '.format(np.log10(results['Polyopt'].times[1, i])))
      fTimes.write('{} '.format(np.log10(results['Mosek'].times[0, i])))
      fTimes.write('{} '.format(np.log10(results['Mosek'].times[1, i])))
      fTimes.write('{} '.format(np.log10(results['Gloptipoly'].times[i])))
      fTimes.write('\n')
  with open(fileGnuplotRelaxPath, 'wt') as fRelax:
    for i in range(results['Polyopt'].relaxOrders.shape[0]):
      for c in [d for d in case if d not in ['GT', 'AG']]:
        fRelax.write('{} '.format(results[c].relaxOrders[i]))
      fRelax.write('\n')



@cli.command()
def generateTable(case=['AG', 'Polyopt', 'Mosek', 'Gloptipoly']):
  """
  Exports table of numbers of real solution into LaTeX.

  Args:
    case (list): list of names of the toolboxes

  Returns:
    None
  """

  results = scipy.io.loadmat(fileResultsPath, struct_as_record=False, squeeze_me=True)
  cams = scipy.io.loadmat(fileCamsPath, struct_as_record=False, squeeze_me=True)['cams']

  solCNum = cams.shape[0]*cams[0].a.shape[0]*4

  solNums = {}
  for c in case:
    solNums[c] = sum(np.vectorize(lambda x: x.shape[0])(results[c].errAll))

  # export to LaTeX
  with open('tables/app_P3P_numberSolutions.tex', 'wt') as fTable:
    fTable.write('\\begin{tabular}{|c||r|r|}\n')
    fTable.write('  \\hline\n')
    fTable.write('  \\textbf{Polynomial} & \\multicolumn{1}{c|}{\\textbf{Number of found}} & \\multicolumn{1}{c|}{\\textbf{Percent of found}}\\\\\n')
    fTable.write('  \\textbf{solver} & \\multicolumn{1}{c|}{\\textbf{real solutions}} & \\multicolumn{1}{c|}{\\textbf{real solutions}}\\\\\n')
    fTable.write('  \\hline\\hline\n')
    fTable.write('  Automatic generator \\cite{{autogen}} & \\num{{{}}} & \\num{{{}}} \%\\\\\n'.format(solNums['AG'], solNums['AG']/solNums['AG']*100))
    fTable.write('  Polyopt & \\num{{{}}} & \\num{{{:#.1f}}} \%\\\\\n'.format(solNums['Polyopt'], solNums['Polyopt']/solNums['AG']*100))
    fTable.write('  MATLAB implementation & \\multirow{{2}}{{*}}{{\\num{{{}}}}} & \\multirow{{2}}{{*}}{{\\num{{{:#.1f}}} \%}}\\\\\n'.format(solNums['Mosek'], solNums['Mosek']/solNums['AG']*100))
    fTable.write('  with MOSEK \\cite{{mosek}} & & \\\\\n')
    fTable.write('  Gloptipoly \\cite{{gloptipoly}} & \\num{{{}}} & \\num{{{:#.1f}}} \%\\\\\n'.format(solNums['Gloptipoly'], solNums['Gloptipoly']/solNums['AG']*100))
    fTable.write('  \\hline\n')
    fTable.write('\\end{tabular}\\\\[1em]\n')

    fTable.write('Number of all complex solutions is \\num{{{}}}.\\\\\n'.format(solCNum))
    fTable.write('Number of all real solutions is \\num{{{}}}, which is \\num{{{:#.1f}}} \% of all complex solutions.\n'.format(solNums['AG'], solNums['AG']/solCNum*100))

  with open('tables/pre_P3P_numberSolutions.tex', 'wt') as fTable:
    fTable.write('\\begin{tabular}{|c||r|r|}\n')
    fTable.write('  \\hline\n')
    fTable.write('  \\multirow{2}{*}{\\textbf{Implementace}} & \\multicolumn{1}{c|}{\\textbf{Počet nalezených}} & \\multicolumn{1}{c|}{\\textbf{Procento nalezených}}\\\\\n')
    fTable.write('   & \\multicolumn{1}{c|}{\\textbf{reálných řešení}} & \\multicolumn{1}{c|}{\\textbf{reálných řešení}}\\\\\n')
    fTable.write('  \\hline\\hline\n')
    fTable.write('  Automatický generátor \\cite{{AutoGen}} & {} & {} \%\\\\\n'.format(solNums['AG'], solNums['AG']/solNums['AG']*100))
    fTable.write('  Polyopt & {} & {:#.1f} \%\\\\\n'.format(solNums['Polyopt'], solNums['Polyopt']/solNums['AG']*100))
    fTable.write('  Implementace v MATLABu & \\multirow{{2}}{{*}}{{{}}} & \\multirow{{2}}{{*}}{{{:#.1f} \%}}\\\\\n'.format(solNums['Mosek'], solNums['Mosek']/solNums['AG']*100))
    fTable.write('  s nástrojem MOSEK \\cite{{mosek}} & & \\\\\n')
    fTable.write('  Gloptipoly \\cite{{gloptipoly}} & {} & {:#.1f} \%\\\\\n'.format(solNums['Gloptipoly'], solNums['Gloptipoly']/solNums['AG']*100))
    fTable.write('  \\hline\n')
    fTable.write('\\end{tabular}\n')


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
  times = np.zeros((cams.shape[0], n))

  for cam, j in zip(cams, range(cams.shape[0])):
    for i in range(n):
      a = cam.a[i]
      timeStart = timeit.default_timer()
      comp = scipy.linalg.companion(a[::-1])
      eigs = np.linalg.eigvals(comp)
      sol = np.real(eigs[np.isreal(eigs)])
      times[j, i] = timeit.default_timer() - timeStart
      saveobj[j, i] = sol
  scipy.io.savemat(fileSolAGPath, {'sol': saveobj, 'times': times})


@cli.command()
def solvePolyopt():
  """
  Solves the P3P polynommial with the Polyopt package.

  Returns:
    None
  """

  import polyopt

  cams = scipy.io.loadmat(fileCamsPath, struct_as_record=False, squeeze_me=True)['cams']
  n = cams[0].a.shape[0]
  saveobj = np.zeros((cams.shape[0], n), dtype=np.object)
  times = np.zeros((cams.shape[0], n, 2))
  relaxOrders = np.zeros((cams.shape[0], n))

  for cam, j in zip(cams, range(cams.shape[0])):
    print(str(j) + ': ', end='', flush=True)
    for i in range(n):
      a = cam.a[i]
      I = [{(0, ): a[0], (1, ): a[1], (2, ): a[2], (3, ): a[3], (4, ): a[4]}]
      problem = polyopt.PSSolver(I)
      problem.setLoggingLevel(40)
      sol = problem.solve()
      times[j, i, 0] = problem.timeOffline
      times[j, i, 1] = problem.timeOnline
      saveobj[j, i] = sol
      relaxOrders[j, i] = problem.getRelaxOrder()
      print('.', end='', flush=True)
    print('\n', end='', flush=True)
  scipy.io.savemat(fileSolPolyoptPath, {'sol': saveobj, 'times': times, 'relaxOrders': relaxOrders})


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
