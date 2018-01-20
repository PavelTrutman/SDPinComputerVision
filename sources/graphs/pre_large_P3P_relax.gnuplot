set terminal epslatex size 6.7,4.5 font ",15"
set output "graphs/pre_large_P3P_relax.tex"

set grid
set key tmargin right
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
boxwidth = width*0.5/datafiles
bin(x) = x
offset(x, y) = bin(x)+(y-datafiles/2.0-0.5)*boxwidth

set boxwidth boxwidth absolute

plot[Min:Max][0:] "data/app_P3P_relax.dat" using (offset($1,1)):(1.0) title "Polyopt" smooth freq with boxes fill solid noborder lc 3,\
                  "data/app_P3P_relax.dat" using (offset($2,2)):(1.0) title "Implementace v MATLABu s nástrojem MOSEK \\cite{mosek}" smooth freq with boxes fill solid noborder lc 4,\
                  "data/app_P3P_relax.dat" using (offset($3,3)):(1.0) title "Gloptipoly \\cite{gloptipoly}" smooth freq with boxes fill solid noborder lc 7
