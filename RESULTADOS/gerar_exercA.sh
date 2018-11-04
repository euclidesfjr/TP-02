#!/bin/bash
##########################################
# Shell Script gerar_exercA.sh
# Autor: Euclides Peres Farias Junior
# Data: 20/10/2018
# Script que prepara os dados para as simulações que o Exercício A
# demanda, bem como coleta os dados para geração dos gráficos
##########################################

ANT=`cat controller.cc |grep the_window_size |head -1|awk '{ print $5 }' |sed 's/;//'`
NOVO=$(($ANT + 10))
cat controller.cc |grep the_window_size |head -1|sed -i "s/$ANT/$NOVO/" controller.cc; 
paste INFO.txt log.txt >> /home/ubuntu/TP02/sourdough/datagrump/coleta/RelatorioCalc.txt

i=0
#laço para geração de JANELAS
for i in {1..20};
do
                echo "estamos .... $i" >> /home/ubuntu/TP02/sourdough/datagrump/coleta/i.tt
	        #executa a compilação do programa controller.cc
		#cd /home/ubuntu/TP02/sourdough/datagrump/
    		./executa.sh 
                
		#Prepara os arquivos de Logs.
		#cd /home/ubuntu/TP02/sourdough/datagrump/coleta
      		echo "------------------------------------------------------" >> /home/ubuntu/TP02/sourdough/datagrump/coleta/RelatorioCalc.txt
       		echo "JANELA = $NOVO --- SIMULAÇÃO = $i" >> /home/ubuntu/TP02/sourdough/datagrump/coleta/INFO.txt 
     # done
done

