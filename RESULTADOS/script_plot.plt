#Script para plot do arquivo final-sara.txt
reset
set encoding utf8
#set key box lt 1 lc 6 lw 1
set key top right box 2
set key width 4
set key font ", 10"
set title "Taxa de Transferência versus Um Atraso no Sinal\n \
Percentil 95%"
set xlabel "Janela (Datagramas)"
set ylabel "Throughput/Delay (Bits/s^2)" 
set yrange [0.0:15.0] noreverse nowriteback
set autoscale
#set nokey

#set xtics (\
#"  0"     0,\
#"  15"   80,\
#"  30"  160,\
#"  60"  240,\
#"  120" 320,\
#"  240" 400,\
#"  480" 480)

#sum(x)=(b=b+80,b)
#reset(t)= (b=-80)

set grid
set mxtics 2
set mytics 2

#set term postscript enhanced color font "Times-Roman,20"
#set terminal png transparent nocrop enhanced font "arial,12"
set terminal png nocrop enhanced ##font "Times-Roman,16"
set out 'Throup_Delay_Plot.png'
set key right top 
plot 'dados.dat' u ($1):($4) t "(timeout = 1000)" w lp pt 6 ps 1,\
'dados1.dat' u ($1):($4) t "(timeout = 100)" w lp pt 5 ps 1,\


#Fim
