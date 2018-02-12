set terminal epslatex size 6,3.6 font ",15"
set output "graphs/pre_P35Pf_times.tex"

set grid
set nokey
set title ""
set xlabel "Logaritmus výpočetního času [s]"
set ylabel "Frekvence"
set samples 100000

# histogram
Min = -3
Max = 2
n = 11.0
datafiles = 4.0
width = (Max-Min)/n
boxwidth = width*0.9/datafiles
bin(x) = width*(floor((x-Min)/width)+0.5) + Min
offset(x, y) = bin(x)+(y-datafiles/2.0-0.5)*boxwidth

set boxwidth boxwidth absolute

plot[Min:Max][0:] "data/app_P35Pf_times.dat" using (offset($1,1)):(1.0) title "Automatic generator \\cite{AutoGen}" smooth freq with boxes fill solid noborder lc rgb "#ffa822",\
                  "data/app_P35Pf_times.dat" using (offset(log10(10**($2)+10**($3)),2)):(1.0) title "Polyopt --- offline phase" smooth freq with boxes fill solid noborder lc rgb "#018816",\
                  "data/app_P35Pf_times.dat" using (offset(log10(10**($4)+10**($5)),3)):(1.0) title "MATLAB with MOSEK \\cite{mosek} --- offline phase" smooth freq with boxes fill solid noborder lc rgb "#da002b",\
                  "data/app_P35Pf_times.dat" using (offset($6,4)):(1.0) title "Gloptipoly \\cite{gloptipoly}" smooth freq with boxes fill solid noborder lc rgb "#0071b6"
