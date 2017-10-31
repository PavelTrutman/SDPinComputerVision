set terminal epslatex size 6,4
set output "graphs/app_P3P_relax.tex"

set grid
set key tmargin right
set title ""
set xlabel "Maximal degree of relaxed monomials"
set ylabel "Frequency"
set samples 100000

# histogram
Min = 2.0
Max = 11.0
n = Max - Min
datafiles = 3.0
width = (Max-Min)/n
boxwidth = width*0.5/datafiles
bin(x) = x
offset(x, y) = bin(x)+(y-datafiles/2.0-0.5)*boxwidth

set boxwidth boxwidth absolute

plot[Min:Max][0:] "data/app_P3P_relax.dat" using (offset($1,1)):(1.0) title "Polyopt" smooth freq with boxes fill solid noborder lc 3,\
                  "data/app_P3P_relax.dat" using (offset($2,2)):(1.0) title "MATLAB implementation with MOSEK \\cite{mosek}" smooth freq with boxes fill solid noborder lc 4,\
                  "data/app_P3P_relax.dat" using (offset($3,3)):(1.0) title "Gloptipoly \\cite{gloptipoly}" smooth freq with boxes fill solid noborder lc 7
