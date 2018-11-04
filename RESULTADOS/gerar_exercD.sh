#!/bin/bash
#############################################
#  shell que gera dados para o Exercício 02
#
#  Por..: Euclides Peres Farias Junior
#  Data..: 31/10/2018
#  Script..: gerar_exercD.sh 
#  Script responsável pela coleta dos dados para análise e verificação na extração dos 
#  resultados que o exercício exige.
#############################################

for i in $(seq 1 30);
do
			TEMPO=`cat controller.cc |grep timeout | grep return | awk '{ print $2 }' | sed s/\;//`
			JANELA=`cat controller.cc |grep the_window_size |head -1 | awk '{ print $4 }' |  sed s/\;//`
			CONTR=$i
			#Executa script "executa.sh" para as simulações
			./executa.sh >> coletadados.csv

			#coletar dados
			echo " Janela ..: $JANELA	Timeout...: $TEMPO	Simulacao..: $CONTR" >> coleta/informacao.txt
			#Ao término, coleta os dados dos script
                        cd coleta
			paste informacao.txt log.txt >> Relatorio_Exerc_D.txt
			cp log.txt exercicio03/
			cp Relatorio_Exerc_D.txt exercicio03/
                        cd ..

                        echo " Estamo na simulação número ..: [ $CONTR ] " >> coleta/simulacao.txt
			
done
