#!/bin/bash
cat RelatorioCalc.txt |grep Jane >> a 
cat RelatorioCalc.txt |grep Th >> b
cat RelatorioCalc.txt |grep De >> c
cat RelatorioCalc.txt |grep "T / D" >> d
paste a b c d > mostra.txt
cat mostra.txt

