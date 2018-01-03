set terminal epslatex size 6,4
set output "graphs/SDP_performance.tex"

set grid
set key tmargin right
set title ""
set xlabel "Problem size"
set ylabel "Execution time [s]"
set samples 100000
setupCoef = 0.75

plot[0:][0:] "data/SDP_performance.dat" using 1:3 title "Polyopt --- solving time" with linespoints linecolor 1 lw 5 dashtype 1 pointsize 2.83,\
             "data/SDP_performance.dat" using 1:2 title "Polyopt --- setup time" with linespoints linecolor 1 lw 5*setupCoef dashtype 2 pointtype 1 pointsize 2.83*setupCoef,\
             "data/SDP_performance.dat" using 1:5 title "SeDuMi \\cite{sedumi} --- solving time" with linespoints linecolor 2 lw 5 dashtype 1 pointtype 2 pointsize 2,\
             "data/SDP_performance.dat" using 1:4 title "SeDuMi \\cite{sedumi} --- setup time" with linespoints linecolor 2 lw 5*setupCoef dashtype 2 pointtype 2 pointsize 2*setupCoef,\
             "data/SDP_performance.dat" using 1:7 title "MOSEK \\cite{mosek} --- solving time" with linespoints linecolor 3 lw 5 dashtype 1 pointtype 3 pointsize 2,\
             "data/SDP_performance.dat" using 1:6 title "MOSEK \\cite{mosek} --- setup time" with linespoints linecolor 3 lw 5*setupCoef dashtype 2 pointtype 3 pointsize 2*setupCoef
