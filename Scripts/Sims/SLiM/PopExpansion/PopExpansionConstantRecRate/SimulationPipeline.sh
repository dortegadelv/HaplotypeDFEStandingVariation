#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_%A_%a.out
#SBATCH --error=example_%A_%a.err
#SBATCH --time=04:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=2000

module load bcftools
module load vcftools
module load python/3.7.0
### rm SingletonCount.txt
### touch SingletonCount.txt
### rm DoubletonCount.txt
### touch DoubletonCount.txt
TotalNumberOfAlleles=0
TotalNumberOfSNPs=0
# rm WattersonThetaFile.txt
# touch WattersonThetaFile.txt

SequenceSum=0
for i in {1..4000}
do
TempSum=$( echo "scale=8; $SequenceSum + ( 1 / $i ) " | bc )
SequenceSum=$TempSum
done

ValueOne=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 3 + 1 ))
ValueTwo=$(( ( $SLURM_ARRAY_TASK_ID ) * 3 ))

for ((i = ValueOne ; i <= ValueTwo ; i++ ))
do
echo $i
time ../../SLiM/SLiM_build/slim -d simnum=$i sim_test.slim
time python tree_2_vcf_noploidyConstantPopSize.py -n$i

NSFile="test_"$i"_ns.vcf"
CombinedFile="test_"$i"_combined.vcf"
FrqFile="Salele"$i".vcf.frq"
FrqFileWholeSequence="SaleleWholeSequence"$i".vcf.frq"
LogFile="Salele"$i".vcf.log"
AlNumberFile="test_"$i"_allelenumber.txt"
NonCodingFile="test_"$i"_noncoding.vcf"
SynFile="test_"$i"_syn.vcf "
UnsortedFile="test_"$i"_unsorted.vcf"

if [ ! -f $CombinedFile ]
then
echo "NO!"
TreeFile="trees_test_"$i".trees"
rm $TreeFile
rm $NSFile
rm $FrqFile
rm $LogFile
rm $AlNumberFile
rm $NonCodingFile
rm $SynFile
rm $UnsortedFile
continue
fi

NSFile="test_"$i"_ns.vcf"
SynFile="test_"$i"_syn.vcf"
NoncodingFile="test_"$i"_noncoding.vcf"
UnsortedFile="test_"$i"_unsorted.vcf"
CombinedFile="test_"$i"_combined.vcf"
TemporalFreqFile=$NSFile."temp"
FrqFile="Salele"$i".vcf.frq"
FrqFileWholeSequence="SaleleWholeSequence"$i".vcf.frq"
LogFile="Salele"$i".vcf.log"
TreeFile="trees_test_"$i".trees"
FileToErase="test_"$i"_ns.vcf.temp"
FrqFileToEraseOne="SaleleWholeSequence"$i".vcf.frq"
FrqFileToEraseTwo="SaleleWholeSequence"$i".vcf.log"
perl -pe "s/\.\t\.\t\d+\t/\.\t0\t1\t/g" $NSFile > $TemporalFreqFile
cp $TemporalFreqFile $NSFile
vcftools --vcf $NSFile --freq --out Salele$i.vcf
NumberOfAlleles=$( awk '{print $6}' Salele$i.vcf.frq | cut -d ':' -f 2 | grep -w "0.01" | wc -l )
vcftools --vcf $SynFile --freq --out SaleleSyn$i.vcf
NumberOfAllelesSyn=$( awk '{print $6}' SaleleSyn$i.vcf.frq | cut -d ':' -f 2 | grep -w "0.01" | wc -l )
RunAlleleNumber=$(( $NumberOfAllelesSyn + $NumberOfAlleles ))

TotalNumberOfAlleles=$(( $TotalNumberOfAlleles + $NumberOfAlleles ))
File="test_"$i"_combined.vcf"
ExitFile="test_"$i"_combinedMSFormat.txt"

vcftools --vcf $CombinedFile --freq --out SaleleWholeSequence$i.vcf
NumberOfPositionsWholeSequence=$( wc -l SaleleWholeSequence$i.vcf.frq | awk '{print $1}' )
MinusThis=$( awk '{print $5}' SaleleWholeSequence$i.vcf.frq | grep '0:1' | wc -l )
MinusThat=$( awk '{print $6}' SaleleWholeSequence$i.vcf.frq | grep '1:1' | wc -l )
SegSitesNumber=$(( $NumberOfPositionsWholeSequence - $MinusThis - $MinusThat - 1 ))
WattersonTheta=$( echo "scale=8; $SegSitesNumber / $SequenceSum " | bc  )

echo "$i $NumberOfAlleles $WattersonTheta" >> WattersonThetaFile.txt

if [ $RunAlleleNumber -gt 0 ]
then
### perl vcf2MS.pl $CombinedFile $ExitFile 1000
PositionList=( $( grep -P "0:0.99\t1:0.01" Salele$i.vcf.frq | awk '{print $2}' ) )

for ((j = 1 ; j <= NumberOfAlleles ; j++ ))
do
echo "Check this "$j" "${PositionList[j-1]}

if [ ${PositionList[j-1]} -gt 250000 ] && [ ${PositionList[j-1]} -lt 19750000  ]
then

StartPosition=$(( ${PositionList[j-1]} - 250000 ))
EndPosition=$(( ${PositionList[j-1]} + 250000 ))
MiniVCF="MiniVCF"$i".vcf"
ExitMiniVCF="MiniVCF"$i".vcf.recode.vcf"

vcftools --vcf $CombinedFile --chr 1 --from-bp $StartPosition --to-bp $EndPosition --recode --out $MiniVCF
perl vcf2MS.pl $ExitMiniVCF $ExitFile 2000


echo "Position in place ${PositionList[j-1]}"
OtherExitFile=$ExitFile."Mini.txt"
perl CreateSingleMsFileForLCount.pl $ExitFile $OtherExitFile ${PositionList[j-1]}
TotalNumberOfSNPs=$(( $TotalNumberOfSNPs + 1 ))
HapLengthFile="HapLengthsExit"$i"_"$j".txt"
perl DistanceToFirstSegregatingSiteMultiSequence_NoSingletonsBothSides.pl $OtherExitFile $HapLengthFile 1 40
rm $ExitMiniVCF
rm $OtherExitFile
fi
done

PositionList=( $( grep -P "0:0.99\t1:0.01" SaleleSyn$i.vcf.frq | awk '{print $2}' ) )

for ((j = 1 ; j <= NumberOfAllelesSyn ; j++ ))
do
echo "Check this "$j" "${PositionList[j-1]}

if [ ${PositionList[j-1]} -gt 250000 ] && [ ${PositionList[j-1]} -lt 19750000  ]
then

StartPosition=$(( ${PositionList[j-1]} - 250000 ))
EndPosition=$(( ${PositionList[j-1]} + 250000 ))
MiniVCF="MiniVCF"$i".vcf"
ExitMiniVCF="MiniVCF"$i".vcf.recode.vcf"

vcftools --vcf $CombinedFile --chr 1 --from-bp $StartPosition --to-bp $EndPosition --recode --out $MiniVCF
perl vcf2MS.pl $ExitMiniVCF $ExitFile 2000

echo "Position in place ${PositionList[j-1]}"
OtherExitFile=$ExitFile."Mini.txt"
perl CreateSingleMsFileForLCount.pl $ExitFile $OtherExitFile ${PositionList[j-1]}
TotalNumberOfSNPs=$(( $TotalNumberOfSNPs + 1 ))
HapLengthFile="HapLengthsSynExit"$i"_"$j".txt"
perl DistanceToFirstSegregatingSiteMultiSequence_NoSingletonsBothSides.pl $OtherExitFile $HapLengthFile 1 40
rm $ExitMiniVCF
rm $OtherExitFile
fi
done

fi


### perl vcf2MS.pl $File $ExitFile 1000
### awk '{print $6}' Salele2.vcf.frq | awk -F ":" '{print $2}' | sort -g | uniq -c | head -n2 | tail -n1 >> SingletonCount.txt
### awk '{print $6}' Salele2.vcf.frq | awk -F ":" '{print $2}' | sort -g | uniq -c | head -n3 | tail -n1 >> DoubletonCount.txt
rm $ExitFile
rm $NSFile
rm $SynFile
rm $NoncodingFile
rm $UnsortedFile
rm $CombinedFile
rm $FrqFile
rm $LogFile
rm $TreeFile
rm $FileToErase
rm $FrqFileToEraseOne
rm $FrqFileToEraseTwo
rm $AlNumberFile

done

echo "TotalNumberOfAlleles is "$TotalNumberOfAlleles


