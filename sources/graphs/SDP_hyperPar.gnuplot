set terminal epslatex size 6,4
set output "graphs/SDP_hyperPar.tex"

set grid
set key tmargin right
set title ""
set xlabel "$y_1$"
set ylabel "$y_2$"
set zlabel "$z$"
set samples 10000
set view 45,30
set ticslevel 0
set isosamples 20
set xtics offset -1
set ytics offset 1

splot[-2:2][-2:2] y**2 - x**2 title "$z = y_2^2 - y_1^2$"
