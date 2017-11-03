set terminal epslatex size 6,4.5
set output "graphs/SDP_prec_perc_iters.tex"

set grid
set key tmargin right
set title ""
set xlabel "Number of iterations [\\%]"
set ylabel "Frequency"
set samples 100000

# histogram
Min = 0
Max = 100
n = 15.0
datafiles = 6.0
width = (Max-Min)/n
boxwidth = width*0.8/datafiles
bin(x) = width*(floor((x-Min)/width)+0.5) + Min
offset(x, y) = bin(x)+(y-datafiles/2.0-0.5)*boxwidth

set boxwidth boxwidth absolute

plot[Min:Max][0:] "data/SDP_prec_perc_iters.dat" using (offset($1,1)):(1.0) title "$\\importSDPPrecPercPercI{}$ \\%" smooth freq with boxes fill solid noborder lc 1,\
                  "data/SDP_prec_perc_iters.dat" using (offset($2,2)):(1.0) title "$\\importSDPPrecPercPercII{}$ \\%" smooth freq with boxes fill solid noborder lc 2,\
                  "data/SDP_prec_perc_iters.dat" using (offset($3,3)):(1.0) title "$\\importSDPPrecPercPercIII{}$ \\%" smooth freq with boxes fill solid noborder lc 3,\
                  "data/SDP_prec_perc_iters.dat" using (offset($4,4)):(1.0) title "$\\importSDPPrecPercPercIIII{}$ \\%" smooth freq with boxes fill solid noborder lc 4,\
                  "data/SDP_prec_perc_iters.dat" using (offset($5,5)):(1.0) title "$\\importSDPPrecPercPercIIIII{}$ \\%" smooth freq with boxes fill solid noborder lc 7,\
                  "data/SDP_prec_perc_iters.dat" using (offset($6,6)):(1.0) title "$\\importSDPPrecPercPercIIIIII{}$ \\%" smooth freq with boxes fill solid noborder lc 6
