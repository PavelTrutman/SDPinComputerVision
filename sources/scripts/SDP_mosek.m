% Pavel Trutman
% pavel.trutman@fel.cvut.cz

load('data/SDP_matrices.mat');

timesAll = cell(1, size(dims, 2));

for dimIdx = 1:size(dims, 2)
  dim = dims(dimIdx);
  fprintf([num2str(dim), ': ']);
  objective = ones(dim, 1);
  times = zeros(unique, repeat);
  for j = 1:unique
    for i = 1:repeat
      yalmipY = sdpvar(double(dim), 1);
      M = double(matrices{dimIdx}{1, j});
      for k = 1:dim
        M = M + double(matrices{dimIdx}{k + 1, j})*yalmipY(k);
      end
      B = [[double(bound)^2, transpose(yalmipY)]; [yalmipY, eye(double(dim))]];
      o = optimize([M >= 0, B >= 0], objective, sdpsettings('verbose', 0, 'solver', 'mosek'));
      times(j, i) = o.solvertime;
      fprintf('.');
    end
  end
  fprintf('\n');
  timesAll{dimIdx} = times;

end

times = timesAll;
save('data/SDP_timesMosek.mat', 'times');