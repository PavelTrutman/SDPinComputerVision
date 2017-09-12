% Pavel Trutman
% pavel.trutman@fel.cvut.cz

clear all;

load('data/app_P3P_cams.mat');

addpath('/media/SSD/Dokumenty/Skola/CMP/yalmip');
addpath('/media/SSD/Dokumenty/Skola/CMP/yalmip/extras');
addpath('/media/SSD/Dokumenty/Skola/CMP/yalmip/solvers');
addpath('/media/SSD/Dokumenty/Skola/CMP/mosek/8/toolbox/r2014a');
addpath('/media/SSD/Dokumenty/Skola/CMP/moment method for real roots finding');

n = size(cams{1}.a, 2);
camNum = size(cams, 2);
sol = cell(camNum, n);

monomials = [0 1 2 3 4];

for j = 1:camNum
  cam = cams{j};
  for i = 1:n
    a = cam.a{i};
    I = [a(1) a(2) a(3) a(4) a(5)];
    s = solve(I, monomials);
    sol{j, i} = s;
  end
end

save('data/app_P3P_solMosek.mat', 'sol');