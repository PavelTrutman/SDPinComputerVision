% Pavel Trutman
% pavel.trutman@fel.cvut.cz

clear all;

load('data/app_P3P_cams.mat');

addpath('../yalmip');
addpath('../yalmip/extras');
addpath('../yalmip/solvers');
addpath('../mosek/8/toolbox/r2014a');
addpath('../moment method for real roots finding');

n = size(cams{1}.a, 2);
camNum = size(cams, 2);
sol = cell(camNum, n);
times = zeros(camNum, n, 2);
relaxOrders = zeros(camNum, n);

monomials = [0 1 2 3 4];

for j = 1:camNum
  fprintf([num2str(j), ': ']);
  cam = cams{j};
  for i = 1:n
    a = cam.a{i};
    I = [a(1) a(2) a(3) a(4) a(5)];
    [s, relaxOrder, res] = solve(I, monomials);
    sol{j, i} = s;
    relaxOrders(j, i) = relaxOrder;
    times(j, i, 1) = res.timeOffline;
    times(j, i, 2) = res.timeOnline;
    fprintf('.');
  end
  fprintf('\n');
end

save('data/app_P3P_solMosek.mat', 'sol', 'times', 'relaxOrders');