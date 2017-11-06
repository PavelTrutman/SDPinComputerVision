set terminal epslatex size 6,4
set output "graphs/SDP_prec_perc_iters.tex"

set grid
set key tmargin right
set title ""
set xlabel "$\\lambda$"
set ylabel "Number of iterations"
set samples 100000

logbase = 10
set logscale x logbase
set format x sprintf("$%d^{%%L}$", logbase)

plot[1e-9:1e0][0:] "data/SDP_prec_perc_iters.dat" using 1:2 title "$k = \\importSDPPrecPercDimI$" with linespoints linecolor 1 lw 5 pointsize 2.83,\
                   "data/SDP_prec_perc_iters.dat" using 1:3 title "$k = \\importSDPPrecPercDimII$" with linespoints linecolor 2 lw 5 pointsize 2,\
                   "data/SDP_prec_perc_iters.dat" using 1:4 title "$k = \\importSDPPrecPercDimIII$" with linespoints linecolor 3 lw 5 pointsize 2,\
                   "data/SDP_prec_perc_iters.dat" using 1:5 title "$k = \\importSDPPrecPercDimIIII$" with linespoints linecolor 4 lw 5 pointsize 2
