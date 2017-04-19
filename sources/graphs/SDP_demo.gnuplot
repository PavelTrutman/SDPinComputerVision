set terminal epslatex size 6,4
set output "graphs/SDP_demo.tex"

set size ratio -1
set grid
set key top right
set title ""
set xlabel "$y\\ind1$"
set ylabel "$y\\ind2$"
set samples 1000000

f(x) = ((x-1)*sqrt(x+1))/(sqrt(2))

plot[-1.5:1.5][-1:1]  f(x) title "Boundary of the set $\\Dom F$" linewidth 5 linecolor 1,\
                     -f(x) title "" linewidth 5 linecolor 1,\
                     "sources/graphs/SDP_demo-ac.dat" title "Steps of \\refalg{SDP:scb:ac}" pointsize 2 pointtype 2 linecolor 3 linewidth 5,\
                     "sources/graphs/SDP_demo-pf.dat" title "Steps of \\refalg{SDP:scb:pf}" pointsize 2.83 pointtype 1 linecolor 4 linewidth 5
