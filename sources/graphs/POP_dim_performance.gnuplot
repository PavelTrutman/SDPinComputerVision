set terminal epslatex size 6,4
set output "graphs/POP_dim_performance.tex"

set grid
set key top left
set title ""
set xlabel "Problem size"
set ylabel "Execution time [s]"
set samples 100000

plot[0:][0:] "data/POP_dim_performance.dat" using 1:2 title "Polyopt" with linespoints linecolor 1 lw 5 pointsize 2.83,\
                "data/POP_dim_performance.dat" using 1:3 title "Gloptipoly \\cite{gloptipoly}" with linespoints linecolor 2 lw 5 pointsize 2
