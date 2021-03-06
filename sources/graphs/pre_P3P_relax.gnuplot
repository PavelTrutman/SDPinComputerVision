set terminal epslatex size 6,3.6 font ",15"
set output "graphs/pre_P3P_relax.tex"

set grid
set nokey
set title ""
set xlabel "Maximalní stupeň relaxovaných monomů"
set format y "%.0f"
set ylabel "Frekvence"
set samples 100000

# histogram
Min = 2.0
Max = 11.0
n = Max - Min
datafiles = 3.0
width = (Max-Min)/n
boxwidth = width*0.9/datafiles
bin(x) = x
offset(x, y) = bin(x)+(y-datafiles/2.0-0.5)*boxwidth

set boxwidth boxwidth absolute

plot[Min:Max][0:] "data/app_P3P_relax.dat" using (offset($1,1)):(1.0) title "Polyopt" smooth freq with boxes fill solid noborder lc rgb "#018816",\
                  "data/app_P3P_relax.dat" using (offset($2,2)):(1.0) title "MATLAB implementation with MOSEK \\cite{mosek}" smooth freq with boxes fill solid noborder lc rgb "#da002b",\
                  "data/app_P3P_relax.dat" using (offset($3,3)):(1.0) title "Gloptipoly \\cite{gloptipoly}" smooth freq with boxes fill solid noborder lc rgb "#0071b6"
