#/bin/bash
INT=`cat dados.dat |wc -l`

cat dados.dat | awk '
    BEGIIN { HT=$2;
             DL=$3;
    }
{

   for x in $(seq 1 $INT);
   do 
      CALCULO=`echo "scale=2; ($HT / $DL)" | bc -l`
#      echo $CALCULO > teste.txt
   done
  
  END {
    print "o valor e "CALCULO";
  }
'

