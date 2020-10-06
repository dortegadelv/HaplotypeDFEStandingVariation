PositionList=( $( awk '{print $2}' Salele1.vcf.frq | grep -v "POS" ) )
NumberOfAlleles=$( awk '{print $2}' Salele1.vcf.frq | grep -v "POS" | wc -l | awk '{print $1}' )

echo $PositionList
echo $NumberOfAlleles

AllelesInsideExons=0

while IFS="" read -r p || [ -n "$p" ]
do
  ExonStart=`echo $p | awk '{print $2}'`
  ExonEnd=`echo $p | awk '{print $3}'`
  echo "Exon boundaries = $ExonStart $ExonEnd"
  for ((j = 1 ; j <= NumberOfAlleles ; j++ ))
     do
  if [ ${PositionList[j-1]} -ge $ExonStart ] && [ ${PositionList[j-1]} -le $ExonEnd ]
  then
     AllelesInsideExons=$(( $AllelesInsideExons + 1 ))
  fi
done   
done < sim_seq_info_exon_1.txt

echo "Number of alleles inside exons = "$AllelesInsideExons
