#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.%A_%a.out
#SBATCH --error=example_sbatch.%A_%a.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

TotalNumberOfAlleles=0

for i in {1..10}
do
echo $i
time slim -d simnum=$i sim_test.slim
python tree_2_vcf_noploidyConstantPopSize.py -n$i
NSFile="test_"$i"_ns.vcf"
TemporalFreqFile=$NSFile."temp"
# perl -pe "s/\.\t\.\t\d+\t/\.\t0\t1\t/g" $NSFile > $TemporalFreqFile
# cp $TemporalFreqFile $NSFile
# vcftools --vcf $NSFile --freq --out Salele$i.vcf
NumberOfAlleles=$( awk '{print $6}' Salele$i.vcf.frq | cut -d ':' -f 2 | grep -w "0.01" | wc -l )
TotalNumberOfAlleles=$(( $TotalNumberOfAlleles + $NumberOfAlleles ))
File="test_"$i"_combined.vcf"
ExitFile="test_"$i"_combinedMSFormat.txt"
if [ $NumberOfAlleles -gt 0 ]
then
# perl vcf2MS.pl $File $ExitFile 1000
PositionList=( $( grep "0:0.99\t1:0.01" Salele$i.vcf.frq | awk '{print $2}' ) )
NumberOfPositions=$( grep "0:0.99\t1:0.01" Salele$i.vcf.frq | awk '{print $2}' | wc -l )
for ((j = 1 ; j <= NumberOfPositions ; j++ ))
do
echo $j" "${PositionList[j-1]}

if [ ${PositionList[j-1]} -gt 250000 ] && [ ${PositionList[j-1]} -lt 2850000  ]
then
echo "Position in place ${PositionList[j-1]}"
fi
done
fi

done

echo "TotalNumberOfAlleles is "$TotalNumberOfAlleles
