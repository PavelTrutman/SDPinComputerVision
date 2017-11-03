set terminal epslatex size 6,4
set output "graphs/SDP_prec_eps_times.tex"

set grid
set key tmargin right
set title ""
set xlabel "Logarithm of the execution time [s]"
set ylabel "Frequency"
set samples 100000

# histogram
Min = -1.4
Max = -0.2
n = 15.0
datafiles = 4.0
width = (Max-Min)/n
boxwidth = width*0.8/datafiles
bin(x) = width*(floor((x-Min)/width)+0.5) + Min
offset(x, y) = bin(x)+(y-datafiles/2.0-0.5)*boxwidth

set boxwidth boxwidth absolute

plot[Min:Max][0:] "data/SDP_prec_eps_times.dat" using (offset($1,1)):(1.0) title "$\\varepsilon = \\importSDPPrecEpsPrecI$" smooth freq with boxes fill solid noborder lc 1,\
                  "data/SDP_prec_eps_times.dat" using (offset($2,2)):(1.0) title "$\\varepsilon = \\importSDPPrecEpsPrecII$" smooth freq with boxes fill solid noborder lc 2,\
                  "data/SDP_prec_eps_times.dat" using (offset($3,3)):(1.0) title "$\\varepsilon = \\importSDPPrecEpsPrecIII$" smooth freq with boxes fill solid noborder lc 3,\
                  "data/SDP_prec_eps_times.dat" using (offset($4,4)):(1.0) title "$\\varepsilon = \\importSDPPrecEpsPrecIIII$" smooth freq with boxes fill solid noborder lc 4
#                  "data/SDP_prec_eps_times.dat" using (offset($4,4)):(1.0) title "$\\varepsilon = \\importSDPPrecEpsPrecIIIII$" smooth freq with boxes fill solid noborder lc 7
