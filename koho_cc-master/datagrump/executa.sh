#!/bin/bash
##############################################
#Shell executa.sh
# Autor: Euclides Peres Farias Junior
# Data: 20/10/2018
##############################################
#COMPILAR E RECOMPILAR
cd ..
./autogen.sh && ./configure && make
cd datagrump

#executa o IPv4 para encaminhamento
sudo sysctl -w net.ipv4.ip_forward=1
clear

echo "Executa o programama para o usuário O-Cride-Fala-Pra-Mãe"
#executa o programa que gera o gráfico
./run-contest Cride-Fala-pra-MAE
