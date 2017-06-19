set terminal epslatex size 6,5
set output "graphs/POP_Lasserre.tex"

set size ratio -1
set grid
set key tmargin right
set title ""
set xlabel "$x_1$"
set ylabel "$x_2$"
set samples 100000

Ei(x) = sqrt(-959*x*x -770*x +2305)
E1(x) = (Ei(x) +x -1)/24
E2(x) = (-Ei(x) +x -1)/24
Hi(x) = sqrt(3220*x*x +4900*x +1681)
H1(x) = (-Hi(x) +58*x +47)/6
H2(x) = (Hi(x) +58*x +47)/6

filter(x,min,max) = (x > min && x < max) ? x : 1/0

$opt << EOD
-0.5 2
1 1
EOD

$r1 << EOD
0.2 1.56
EOD

plot[-5:4][-3:3] E1(x) title "Ellipse \\refeqb{POP:mm:example1}" linecolor 1 lw 5,\
                 E2(x) title "" linecolor 1 lw 5,\
                 H1(x) title "Hypebola \\refeqb{POP:mm:example2}" linecolor 2 lw 5,\
                 H2(x) title "" linecolor 2 lw 5,\
                 '+' using 1:(E1(filter($1, -2, -0.5))) title "Feasible region" with filledcurves y1=0 linecolor 3 fillstyle pattern 5 transparent,\
                 '+' using 1:(H1(filter($1, -0.5, 1))) title "" with filledcurves y1=0 linecolor 3 fillstyle pattern 5 transparent,\
                 '+' using 1:(E1(filter($1, 1, 1.2))) title "" with filledcurves y1=0 linecolor 3 fillstyle pattern 5 transparent,\
                 '+' using 1:(H2(filter($1, -2, -1))) title "" with filledcurves y1=0 linecolor 3 fillstyle pattern 5 transparent,\
                 '+' using 1:(E2(filter($1, -1, 1.2))) title "" with filledcurves y1=0 linecolor 3 fillstyle pattern 5 transparent,\
                 "$opt" title "Global optima" pointtype 7 linecolor 4 pointsize 2,\
                 "$r1" title "Optimum of the first relaxation" pointtype 7 linecolor 7 pointsize 2
