set terminal epslatex size 6,5
set output "graphs/POP_multiplicationMatrices.tex"

set size ratio -1
set grid
set key tmargin right
set title ""
set xlabel "$x$"
set ylabel "$y$"
set samples 1000000

Ei(x) = sqrt(-959*x*x -770*x +2305)
E1(x) = (Ei(x) +x -1)/24
E2(x) = (-Ei(x) +x -1)/24
Hi(x) = sqrt(3220*x*x +4900*x +1681)
H1(x) = (-Hi(x) +58*x +47)/6
H2(x) = (Hi(x) +58*x +47)/6

$VAll << EOD
-2 -2
-2 0
-2 1
-2 2
-1 -2
-1 0
-1 1
-1 2
-0.5 -2
-0.5 0
-0.5 1
-0.5 2
1 -2
1 0
1 1
1 2
EOD


$V << EOD
1 1
-2 0
-0.5 2
-1 -2
EOD

plot[-5:4][-3:3] E1(x) title "Ellipse \\refeqb{POP:mm:example1}" linecolor 1 lw 5,\
                 E2(x) title "" linecolor 1 lw 5,\
                 H1(x) title "Hypebola \\refeqb{POP:mm:example2}" linecolor 2 lw 5,\
                 H2(x) title "" linecolor 2 lw 5,\
                 "$V" title "$V_\\C(I)$" pointtype 7 linecolor 4 pointsize 2,\
                 "$VAll" title "$\\tilde{V}_\\C(I)$" pointtype 7 linecolor 3 pointsize 2,\
                 "$V" title "" pointtype 7 linecolor 4 pointsize 2
