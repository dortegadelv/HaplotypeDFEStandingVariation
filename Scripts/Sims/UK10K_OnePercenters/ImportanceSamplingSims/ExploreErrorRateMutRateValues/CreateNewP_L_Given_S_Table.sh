#$ -l h_vmem=2g
#$ -cwd

#$ -N ForWF
#$ -e ../../../../../Results/Trash/
#$ -o ../../../../../Results/Trash/

MutRate[1]="0.000000012"
MutRate[2]="0.000000015"
MutRate[3]="0.00000002"

RecRate[1]="0.0000000025"
RecRate[2]="0.0000000075"
RecRate[3]="0.0000000125"
RecRate[4]="0.0000000234"

ErrorRate[1]="0.000005"
ErrorRate[2]="0.0000075"
ErrorRate[3]="0.00001"
ErrorRate[4]="0.0"


ErrorRateValue=$(( ( ( $SGE_TASK_ID - 1 ) ) % 4 + 1 ))
MutRateValue=$(( ( ( $SGE_TASK_ID - 1 ) ) / 16 + 1 ))
RecRateValue=$((( ( ( $SGE_TASK_ID - 1 ) ) / 4 + 1 ) % 4 + 1 ))

echo "$ErrorRateValue $MutRateValue $RecRateValue"

Directory="ImportanceSamplingSimsErrorRate"${ErrorRate[$ErrorRateValue]}"MutRate"${MutRate[$MutRateValue]}"RecRate"${RecRate[$RecRateValue]}

echo $Directory
# cat ConstantSizeDenserGrid/DistancesFile_{1..100}.txt > ConstantSizeDenserGrid/DistancesFile.txt

# perl EstimateHapLengthWeight.pl ConstantSizeDenserGrid/Exit_0.01_0.txtWeightYears.txt ConstantSizeDenserGrid/DistancesFile.txt NewMiniExp.txt NewMiniSD.txt

# awk '{print $1}' MiniExpDense.txt > ListOfAges.txt

# paste -d "\t" ListOfAges.txt NewMiniExp.txt > TableToTest.txt

### 10X more sims for each row of the distances file

# perl SumDistances10000.pl

# cat ../../../../Results/UK10K/ImportanceSamplingSims/Exit__0.01_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt

time perl ../../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../../Results/UK10K/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt ../../../../../Results/UK10K/$Directory/SumDistancesFile10000.txt ../../../../../Results/UK10K/$Directory/NewMiniExp10000.txt ../../../../../Results/UK10K/$Directory/NewMiniSD10000.txt

awk '{print $1}' ../../../../../Results/UK10K/$Directory/NewMiniExp10000.txt > ../../../../../Results/UK10K/$Directory/FirstColumn.txt

paste -d "\t" ../../../../../Results/UK10K/$Directory/FirstColumn.txt ../../../../../Results/UK10K/$Directory/NewMiniExp10000.txt > ../../../../../Results/UK10K/$Directory/TableToTest.txt
# paste -d "\t" ListOfAges.txt NewMiniExp10000.txt > TableToTest10000.txt


