set terminal epslatex size 6,4
set output "graphs/app_P35Pf_cdist.tex"

set grid
set key tmargin right
set title ""
set xlabel "Logarithm of the error in camera position"
set ylabel "Frequency"
set samples 100000

# histogram
Min = 0.2
Max = 1.2
n = 15.0
datafiles = 4.0
width = (Max-Min)/n
boxwidth = width*0.8/datafiles
bin(x) = width*(floor((x-Min)/width)+0.5) + Min
offset(x, y) = bin(x)+(y-datafiles/2.0-0.5)*boxwidth

set boxwidth boxwidth absolute

plot[Min:Max][0:] "data/app_P35Pf_cdist.dat" using (offset($1,1)):(1.0) title "Automatic generator \\cite{autogen}" smooth freq with boxes fill solid noborder lc 2,\
                  "data/app_P35Pf_cdist.dat" using (offset($2,2)):(1.0) title "Polyopt" smooth freq with boxes fill solid noborder lc 3,\
                  "data/app_P35Pf_cdist.dat" using (offset($3,3)):(1.0) title "MATLAB implementation with MOSEK \\cite{mosek}" smooth freq with boxes fill solid noborder lc 4,\
                  "data/app_P35Pf_cdist.dat" using (offset($4,4)):(1.0) title "Gloptipoly \\cite{gloptipoly}" smooth freq with boxes fill solid noborder lc 7
