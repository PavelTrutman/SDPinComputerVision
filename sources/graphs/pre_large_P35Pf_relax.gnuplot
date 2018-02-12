set terminal epslatex size 6.7,4.5 font ",15"
set output "graphs/pre_large_P35Pf_relax.tex"

set grid
set key tmargin right
set title ""
set xlabel "Maximalní stupeň relaxovaných monomů"
set ylabel "Frekvence"
set samples 100000

# histogram
Min = 2.0
Max = 13.0
n = Max - Min
datafiles = 3.0
width = (Max-Min)/n
boxwidth = width*0.9/datafiles
bin(x) = x
offset(x, y) = bin(x)+(y-datafiles/2.0-0.5)*boxwidth

set boxwidth boxwidth absolute

plot[Min:Max][0:] "data/app_P35Pf_relax.dat" using (offset($1,1)):(1.0) title "Polyopt" smooth freq with boxes fill solid noborder lc rgb "#018816",\
                  "data/app_P35Pf_relax.dat" using (offset($2,2)):(1.0) title "Implementace v MATLABu s nástrojem MOSEK \\cite{mosek}" smooth freq with boxes fill solid noborder lc rgb "#da002b",\
                  "data/app_P35Pf_relax.dat" using (offset($3,3)):(1.0) title "Gloptipoly \\cite{gloptipoly}" smooth freq with boxes fill solid noborder lc rgb "#0071b6"
