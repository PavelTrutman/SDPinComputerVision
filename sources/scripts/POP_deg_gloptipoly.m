% Pavel Trutman
% pavel.trutman@fel.cvut.cz

load('data/POP_deg_coefs.mat');

timesAll = cell(1, size(degs, 2));
resultsAll = cell(1, size(degs, 2));
mset('verbose', false);

for degIdx = 1:size(degs, 2)
  deg = degs(degIdx);
  r = double(rs(degIdx));
  fprintf([num2str(deg), ': ']);
  times = zeros(unique, repeat);
  results = cell(unique, repeat);
  for j = 1:unique
    mpol('x', dim);
    mons = generateMonomialsUpDegree(2*r, dim);
    f = 0;
    for k = 1:size(mons, 2)
      f = f + coefs{degIdx}{k, j}*sum((x.^mons(:, k)));
    end
    g = 1;
    for k = 1:dim
      g = g - x(k)^2;
    end
    for i = 1:repeat
      
      timeStart = tic;
      P = msdp(min(f), g >= 0, r);
      [status, ~] = msol(P);
      times(j, i) = toc(timeStart);
      if status == 1
        results{j, i} = double(x);
      else
        results{j, i} = NaN;
      end
    end
    fprintf('.');
  end
  fprintf('\n');
  timesAll{degIdx} = times;
  resultsAll{degIdx} = results;

end

times = timesAll;
results = resultsAll;
save('data/POP_deg_timesGloptipoly.mat', 'times', 'results');

function monoms = generateMonomialsDegree(d, n)
  if d == 0
    monoms = zeros(n, 1);
  elseif d == 1
    monoms = flipud(eye(n));
  elseif n == 1
    monoms = d;
  else
    
    monoms = zeros(n, numMonomialsDegree(d, n));
    start = 1;
    for i = d:-1:0
      innerMonoms = generateMonomialsDegree(d - i, n - 1);
      monoms(:, start:(start + size(innerMonoms, 2) - 1)) = [innerMonoms; i*ones(1, size(innerMonoms, 2))];
      start = start + size(innerMonoms, 2);
    end
    
  end
end

function monoms = generateMonomialsUpDegree(d, n)
  monoms = zeros(n, numMonomialsUpDegree(d, n));
  
  start = 1;
  for i = 0:d
    innerMonoms = generateMonomialsDegree(i, n);
    monoms(:, start:(start + size(innerMonoms, 2) - 1)) = innerMonoms;
    start = start + size(innerMonoms, 2);
  end
end

function num = numMonomialsDegree(d, n)
  num = nchoosek(d + n - 1, n - 1);
end

function num = numMonomialsUpDegree(d, n)
  num = nchoosek(d + n, n);
end