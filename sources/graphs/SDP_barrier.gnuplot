set terminal epslatex size 6,4.5
set output "graphs/SDP_barrier.tex"

set size ratio -1
set grid
set key tmargin right
set title ""
set xlabel "$x$"
set ylabel "$-\\frac{1}{t}\\ln(x)$"
set samples 100000

$tinfty << EOD
5 0
0 0
0 5
EOD

plot[-1:3][-0.5:2] -log(x) title "$t = 1$" linecolor 1 lw 5,\
                 -log(x)/2 title "$t = 2$" linecolor 2 lw 5,\
                 -log(x)/5 title "$t = 5$" linecolor 3 lw 5,\
                 -log(x)/10 title "$t = 10$" linecolor 4 lw 5,\
                 "$tinfty" title "$t\\rightarrow +\\infty$" with lines linecolor 7 lw 5
