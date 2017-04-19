set terminal epslatex size 6,4
set output "graphs/SDP_hyperParSlice.tex"

set size ratio -1
set grid
set key tmargin right
set title ""
set xlabel "$y_1$"
set ylabel "$y_2$"
set samples 10000

$above << EOD
-2 2
0 0
2 2
EOD
$below << EOD
-2 -2
0 0
2 -2
EOD

plot[-2:2][-2:2] "$above" using 1:2 title "$\\Dom F(y)$" with filledcurves below y lc 3 fillstyle pattern 4 transparent ,\
                 "$below" using 1:2 title "" with filledcurves below y lc 3 fillstyle pattern 4 transparent,\
                 "$above" using 1:2 title "$\\big\\{y\\ |\\ X(y) \\succeq 0\\big\\}$" with filledcurves below y lc 4 fillstyle pattern 5 transparent ,\
                  x title "$\\det\\big(X(y)\\big) = 0$" linecolor 1 lw 5 ,\
                 -x title "" linecolor 1 lw 5
