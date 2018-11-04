#!/bin/bash
#############################################
#  shell que gera dados para o Exercício 02
#
#  Por..: Euclides Peres Farias Junior
#  Data..: 31/10/2018
#  Script .: gerar_exercB.sh
#  Script responsável pela geração de dados para coleta e tratamento
#  das informações geradas pelas simulações.
#############################################

#for i in $(seq 0.25 0.25 1.5);
#do
#	ALFA=`cat controller.cc |grep "double alfa =" | awk '{ print $4 }' | sed s/\;//`
	#adiciona o novo valor para o ALFA
	#sed -i '11s/.$//' controller.cc
#	sed -i "s/$ALFA/$i/" controller.cc
	#cat controller.cc |grep "double alfa =" | awk '{ print $4 }' | sed -i 's/$//' controller.cc
               
	#Laço FOR para gerar as rodadas de Simulação
for j in $(seq 1 5);
do
	sed -i "s/$BETA/0.25/" controller.cc
	CONTR=0
	while [  $CONTR -le 10 ]; do
		#laço para atualizar o Beta
		for y in $(seq 0.25 0.15 1.75);
		do
			BETA=`cat controller.cc |grep "double beta =" | awk '{ print $4 }' | sed s/\;//`
			ALFA=`cat controller.cc |grep "double alfa =" | awk '{ print $4 }' | sed s/\;//`
			TEMPO=`cat controller.cc |grep timeout | grep return | awk '{ print $2 }' | sed s/\;//`
			#y=1
			JANELA=`cat controller.cc |grep the_window_size |head -1 | awk '{ print $4 }' |  sed s/\;//` 
			#Troca o valor de BETA de 0,15
			#sed -i '12s/.$//' controller.cc
			sed -i "s/$BETA/$y/" controller.cc
			#cat controller.cc |grep "double beta =" | awk '{ print $4 }' | sed -i 's/$//' controller.cc
			#Executa script "executa.sh" para as simulações
			./executa.sh >> coletadados.csv
			#Ao término, coleta os dados dos script
			echo "Simulação com Alfa = $ALFA e Beta = $BETA "
			echo "$JANELA	$ALFA	$BETA	$TEMPO" >> /home/ubuntu/TP-02/sourdough/datagrump/coleta/exercicio02/Valores.dat
			cp coleta/log.txt coleta/exercicio02
			cd coleta/exercicio02
			paste Valores.dat log.txt >> Relatorio_Ex02.txt
			cd ../..
			CONTR=`expr $CONTR + 1`
                        echo " Estamo na simulação número ..: [ $CONTR ] " >> coleta/simulacao.txt
		done
	done
done
#done
