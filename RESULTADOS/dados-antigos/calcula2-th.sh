#/bin/bash
INT=`cat dados.dat | wc -l`

for x in $(seq 1 $INT);
do
	for i in $(cat dados.dat |awk '{ print $2}')
	do 
    		THP=$i
    		echo "$THP "
		#    THP=`awk '{ print $1 }'`
		#    DLY=`awk '{ print $2 }'`
		#    RESULTADO=`echo "scale=2; ($THP / $DLY)" | bc -l`

		#    echo "A divisao do TH / DLY é ..: $RESULTADO" 
     
		#Script que recebe os valores extraídos da execução para cálculo das médias.
		#MED_AUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
		#MED_SMPTCP=`echo "scale=2; ($MED_SMPTCP + $MED_AUX)" | bc -l`

#	done

		for j in $(cat dados.dat |awk '{ print $3}')
		do
		    DLY=$j
		    echo "$DLY "
		#    THP=`awk '{ print $1 }'`
		#    DLY=`awk '{ print $2 }'`
		#    RESULTADO=`echo "scale=2; ($THP / $DLY)" | bc -l`

		#    echo "A divisao do TH / DLY é ..: $RESULTADO" 


		#Script que recebe os valores extraídos da execução para cálculo das médias.
		#MED_AUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
		#MED_SMPTCP=`echo "scale=2; ($MED_SMPTCP + $MED_AUX)" | bc -l`

		echo "Os dados são $THP e $DLY"
		done
	done
done

