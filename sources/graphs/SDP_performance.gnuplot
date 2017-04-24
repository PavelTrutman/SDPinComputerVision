set terminal epslatex size 6,4
set output "graphs/SDP_performance.tex"

set grid
set key top left
set title ""
set xlabel "Dimension"
set ylabel "Execution time [s]"
set samples 100000

plot[0:][0:] "data/SDP_performance.dat" using 1:2 title "Polyopt" with linespoints linecolor 1 lw 5 pointsize 2.83,\
                "data/SDP_performance.dat" using 1:3 title "SeDuMi \\cite{sedumi}" with linespoints linecolor 3 lw 5 pointsize 2,\
                "data/SDP_performance.dat" using 1:4 title "MOSEK \\cite{mosek}" with linespoints linecolor 4 lw 5 pointsize 2
