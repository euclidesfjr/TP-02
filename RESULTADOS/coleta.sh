#!/bin/bash
#declaração de variáveis
JANELA=`cat controller.cc |grep the_window_size |head -1 | awk '{ print $5 }'|sed s/\;//`
THR=`cat coleta.out |grep throughput| awk '{ print $3 }'`
DELAY=`cat coleta.out |grep "signal delay" | awk '{ print $5 }'`
FILA=`cat coleta.out |grep delay | head -1 | awk '{ print $6 }'`
TD=`echo "scale=5 ; (( $THR / $DELAY )) * 1000" | bc`
UTIL=`cat coleta.out |grep utilization | awk '{ print $5 }' | sed s/\(//`

echo "====== RELATORIO DE GERAÇÃO PARA COMPARAÇÃO THROUGHPUT versus DELAY ======" >> RelatorioCalc.txt
echo " "
echo "Utilização ...: $UTIL " >> RelatorioCalc.txt
echo "Janela .......: $JANELA " >> RelatorioCalc.txt
echo "Throughput ...: $THR " >> RelatorioCalc.txt
echo "Delay ........: $DELAY " >> RelatorioCalc.txt
echo "T / D ........: $TD " >> RelatorioCalc.txt
echo " " >> RelatorioCalc.txt
