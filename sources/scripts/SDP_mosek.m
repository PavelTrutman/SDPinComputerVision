% Pavel Trutman
% pavel.trutman@fel.cvut.cz

clear all;

load('data/SDP_matrices.mat');

addpath('../yalmip');
addpath('../yalmip/extras');
addpath('../yalmip/solvers');
addpath('../mosek/8/toolbox/r2014a');

timesAll = cell(1, size(dims, 2));
resultsAll = cell(1, size(dims, 2));

for dimIdx = 1:size(dims, 2)
  dim = dims(dimIdx);
  fprintf([num2str(dim), ': ']);
  times = zeros(unique, repeat, 2);
  results = cell(unique, repeat);
  for j = 1:unique
    for i = 1:repeat
      timeStart = tic;
      yalmipY = sdpvar(double(dim), 1);
      M = double(matrices{dimIdx}{1, j});
      for k = 1:dim
        M = M + double(matrices{dimIdx}{k + 1, j})*yalmipY(k);
      end
      B = [[double(bound)^2, transpose(yalmipY)]; [yalmipY, eye(double(dim))]];
      o = optimize([M >= 0, B >= 0], sum(yalmipY), sdpsettings('verbose', 0, 'solver', 'mosek'));
      times(j, i, 1) = toc(timeStart) - o.solvertime;
      times(j, i, 2) = o.solvertime;
      results{j, i} = value(yalmipY);
    end
    fprintf('.');
  end
  fprintf('\n');
  timesAll{dimIdx} = times;
  resultsAll{dimIdx} = results;

end

times = timesAll;
results = resultsAll;
save('data/SDP_timesMosek.mat', 'times', 'results');
