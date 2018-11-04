#!/bin/bash

#COPIA DADOS PARA ARQUIVO DE RELATORIO
paste INFO.txt log.txt >> RelatorioCalc.txt

#ZERA LOGS AUTOMÁTICOS
> log.txt ; > INFO.txt
