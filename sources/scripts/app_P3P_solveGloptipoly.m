% Pavel Trutman
% pavel.trutman@fel.cvut.cz

clear all;

load('data/app_P3P_cams.mat');

addpath('/media/SSD/Dokumenty/Skola/CMP/gloptipoly3');
addpath('/media/SSD/Dokumenty/Skola/CMP/yalmip');
addpath('/media/SSD/Dokumenty/Skola/CMP/yalmip/extras');
addpath('/media/SSD/Dokumenty/Skola/CMP/yalmip/solvers');
addpath('/media/SSD/Dokumenty/Skola/CMP/mosek/8/toolbox/r2014a');

n = size(cams{1}.a, 2);
camNum = size(cams, 2);
sol = cell(camNum, n);
times = zeros(camNum, n);

mset('yalmip', true);
mset(sdpsettings('verbose', 0, 'solver', 'mosek'));
mset('verbose', false);

relaxOrder = 4;

for j = 1:camNum
  cam = cams{j};
  for i = 1:n
    a = cam.a{i};
    
    mpol('x', 1);
    I = [a(1) + a(2)*x + a(3)*x^2 + a(4)*x^3 + a(5)*x^4];
    timeStart = tic;
    P = msdp(min(mpol(0)), I == 0, relaxOrder);
    [status, ~] = msol(P);
    times(j, i) = toc(timeStart);
    
    if status == 1
      sol{j, i} = double(x);
    else
      sol{j, i} = [];
    end
  end
end

save('data/app_P3P_solGloptipoly.mat', 'sol', 'times');