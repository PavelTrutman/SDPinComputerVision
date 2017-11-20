% Pavel Trutman
% pavel.trutman@fel.cvut.cz

clear all;

load('data/SDP_matrices.mat');

addpath('../yalmip');
addpath('../yalmip/extras');
addpath('../yalmip/solvers');
addpath('../sedumi');

timesAll = cell(1, size(dims, 2));
resultsAll = cell(1, size(dims, 2));

for dimIdx = 1:size(dims, 2)
  dim = dims(dimIdx);
  fprintf([num2str(dim), ': ']);
  times = zeros(unique, repeat);
  results = cell(unique, repeat);
  for j = 1:unique
    for i = 1:repeat
      yalmipY = sdpvar(double(dim), 1);
      M = double(matrices{dimIdx}{1, j});
      for k = 1:dim
        M = M + double(matrices{dimIdx}{k + 1, j})*yalmipY(k);
      end
      B = [[double(bound)^2, transpose(yalmipY)]; [yalmipY, eye(double(dim))]];
      o = optimize([M >= 0, B >= 0], sum(yalmipY), sdpsettings('verbose', 0, 'solver', 'sedumi'));
      times(j, i) = o.solvertime;
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
save('data/SDP_timesSedumi.mat', 'times', 'results');
