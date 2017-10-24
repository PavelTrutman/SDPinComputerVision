% Pavel Trutman
% pavel.trutman@cvut.cz

clear all

output = 'polyopt';
output = 'mosek';
output = 'gloptipoly';

syms a b c d real;
syms p1_1 p2_1 p3_1 p4_1 p5_1 p6_1 p7_1 p8_1 p9_1 p10_1 p11_1 p12_1 real;
syms p1_2 p2_2 p3_2 p4_2 p5_2 p6_2 p7_2 p8_2 p9_2 p10_2 p11_2 p12_2 real;
syms p1_3 p2_3 p3_3 p4_3 p5_3 p6_3 p7_3 p8_3 p9_3 p10_3 p11_3 p12_3 real;
syms p1_4 p2_4 p3_4 p4_4 p5_4 p6_4 p7_4 p8_4 p9_4 p10_4 p11_4 p12_4 real;
syms p1_5 p2_5 p3_5 p4_5 p5_5 p6_5 p7_5 p8_5 p9_5 p10_5 p11_5 p12_5 real;

P1 = [p1_1; p2_1; p3_1; p4_1; p5_1; p6_1; p7_1; p8_1; p9_1; p10_1; p11_1; p12_1];
P2 = [p1_2; p2_2; p3_2; p4_2; p5_2; p6_2; p7_2; p8_2; p9_2; p10_2; p11_2; p12_2];
P3 = [p1_3; p2_3; p3_3; p4_3; p5_3; p6_3; p7_3; p8_3; p9_3; p10_3; p11_3; p12_3];
P4 = [p1_4; p2_4; p3_4; p4_4; p5_4; p6_4; p7_4; p8_4; p9_4; p10_4; p11_4; p12_4];
P5 = [p1_5; p2_5; p3_5; p4_5; p5_5; p6_5; p7_5; p8_5; p9_5; p10_5; p11_5; p12_5];

P = a*P1 + b*P2 + c*P3 + d*P4 + P5;

x11 = P(1);
x12 = P(2);
x13 = P(3);
x21 = P(5);
x22 = P(6);
x23 = P(7);
x31 = P(9);
x32 = P(10);
x33 = P(11);

eq(1) = x21*x31+x22*x32+x23*x33;
eq(2) = x11*x31+x12*x32+x13*x33;
eq(3) = x11*x21+x12*x22+x13*x23;
eq(4) = x11^2+x12^2+x13^2-x21^2-x22^2-x23^2;
eq(5) = x13^2*x32-x21^2*x32-x22^2*x32-x12*x13*x33-x22*x23*x33;
eq(6) = x12*x13*x32+x22*x23*x32-x12^2*x33+x21^2*x33+x23^2*x33; 
eq(7) = x11*x13*x32+x21*x23*x32-x11*x12*x33-x21*x22*x33;
eq(8) = x13^2*x31-x22^2*x31+x21*x22*x32-x11*x13*x33;
eq(9) = x12*x13*x31+x22*x23*x31-x11*x12*x33-x21*x22*x33;

coefs = cell(size(eq));
monoms = cell(size(eq));
monsAll = [];
for i = 1:size(eq, 2)
  [coefs{i}, monoms{i}] = coeffs(eq(i), [a b c d]);
  monsAll = union(monsAll, monoms{i});
end

I = sym(zeros(size(eq, 2), nchoosek(4 + 3, 4)));
monsAll = generateMonomialsUpDegree(3, 4);
for i = 1:size(monsAll, 2)
  mon = monsAll(:, i);
  monSym = prod(power([a b c d], mon'));
  for j = 1:size(eq, 2)
    idx = find(monoms{j} == monSym);
    if size(idx, 2) > 0
      I(j, i) = coefs{j}(idx);
    end
  end
end
I = expand(I);

file = fopen('/tmp/I.m', 'w');

if strcmp(output, 'mosek')
  fprintf(file, ['I = zeros(', num2str(size(I, 1)), ', ', num2str(size(I, 2)), ');\n']);
  for i = 1:size(I, 1)
    for j = 1:size(I, 2)
      if I(i, j) == 0
        continue
      end
      fprintf(file, regexprep(['I(', num2str(i), ', ', num2str(j), ') = ', char(I(i, j)), ';\n'], 'p(\d+)_(\d)', 'P($1, $2)'));
    end
  end

  fprintf(file, '\n');

  fprintf(file, 'monomials = [');
  for i = 1:size(monsAll, 1)
    for j = 1:size(monsAll, 2)
      fprintf(file, [num2str(monsAll(i, j)), ', ']);
    end
    fprintf(file, '; ');
  end
  fprintf(file, '];');

elseif strcmp(output, 'polyopt')
  fprintf(file, 'I = []\n');
  for i = 1:size(I, 1)
    fprintf(file, 'p = {}\n');
    for j = 1:size(I, 2)
      if I(i, j) == 0
        continue
      end
      fprintf(file, 'p[(');
      for k = 1:size(monsAll, 1)
        fprintf(file, [num2str(monsAll(k, j)), ', ']);
      end
      fprintf(file, [')] = ', regexprep(strrep(char(I(i, j)), '^', '**'), 'p(\d+)_(\d)', 'P[$1 - 1, $2 - 1]'), '\n']);
    end
    fprintf(file, 'I.append(p)\n');
  end

elseif strcmp(output, 'gloptipoly')
  fprintf(file, 'mpol(''a'', 1);\n');
  fprintf(file, 'mpol(''b'', 1);\n');
  fprintf(file, 'mpol(''c'', 1);\n');
  fprintf(file, 'mpol(''d'', 1);\n');
  fprintf(file, ['mpol(''I'', ', num2str(size(eq, 2)), ');\n']);
  for i = 1:size(eq, 2)
    fprintf(file, ['I(', num2str(i), ') = ', regexprep(char(eq(i)), 'p(\d+)_(\d)', 'P($1, $2)'), ';\n']);
  end
end
fclose(file);