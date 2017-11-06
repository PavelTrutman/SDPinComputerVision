set terminal epslatex size 6,3.5
set output "graphs/SDP_prec_perc_demo.tex"

set size ratio -1
set grid
set key tmargin right
set title ""
set xlabel "$y\\ind1$"
set ylabel "$y\\ind2$"
#set samples 1000000
set samples 1000000

$B << EOD
5 -1
5 1
-5 1
-5 -1
5 -1
EOD

f1(x, p) = sqrt(26.0*(p**2) - (x + 5)**2) - 1
f2(x, p) = -sqrt(26.0*(p**2) - (x + 5)**2) - 1

set label at 0,0 "$y_F^*$" left front offset 0.5,0.5
set label at -5,-1 "$y^*$" left front offset 0.5,-0.5

plot[-7:5.5][-3:2] "$B" title "Boundary of the feasible set of the problem" with lines linewidth 5 linecolor 1,\
                   "sources/graphs/SDP_prec_perc_demo.dat" title "Steps of \\refalg{SDP:scb:pf}" pointsize 2.83 pointtype 1 linecolor 2 linewidth 5,\
                   f1(x, 0.5) title "50 \\% of $\\|y^* - y_F^*\\|$" linewidth 3 linecolor 3 dashtype 3,\
                   f2(x, 0.5) title "" linewidth 3 linecolor 3 dashtype 3,\
                   f1(x, 0.25) title "25 \\% of $\\|y^* - y_F^*\\|$" linewidth 3 linecolor 4 dashtype 3,\
                   f2(x, 0.25) title "" linewidth 3 linecolor 4 dashtype 3,\
                   f1(x, 0.1) title "10 \\% of $\\|y^* - y_F^*\\|$" linewidth 3 linecolor 7 dashtype 3,\
                   f2(x, 0.1) title "" linewidth 3 linecolor 7 dashtype 3
