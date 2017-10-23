#$ -l h_vmem=2g
#$ -cwd

#$ -N ForWF
#$ -e ../../../../Results/Trash/
#$ -o ../../../../Results/Trash/


# cat ConstantSizeDenserGrid/DistancesFile_{1..100}.txt > ConstantSizeDenserGrid/DistancesFile.txt

# perl EstimateHapLengthWeight.pl ConstantSizeDenserGrid/Exit_0.01_0.txtWeightYears.txt ConstantSizeDenserGrid/DistancesFile.txt NewMiniExp.txt NewMiniSD.txt

# awk '{print $1}' MiniExpDense.txt > ListOfAges.txt

# paste -d "\t" ListOfAges.txt NewMiniExp.txt > TableToTest.txt

### 10X more sims for each row of the distances file

# perl SumDistances10000.pl

cat ../../../../Results/UK10K/ImportanceSamplingSims/Exit__0.01_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt

time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/UK10K/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt ../../../../Results/UK10K/ImportanceSamplingSims/SumDistancesFile10000.txt ../../../../Results/UK10K/ImportanceSamplingSims/NewMiniExp10000.txt ../../../../Results/UK10K/ImportanceSamplingSims/NewMiniSD10000.txt

awk '{print $1}' ../../../../Results/UK10K/ImportanceSamplingSims/NewMiniExp10000.txt > ../../../../Results/UK10K/ImportanceSamplingSims/FirstColumn.txt

paste -d "\t" ../../../../Results/UK10K/ImportanceSamplingSims/FirstColumn.txt ../../../../Results/UK10K/ImportanceSamplingSims/NewMiniExp10000.txt > ../../../../Results/UK10K/ImportanceSamplingSims/TableToTest.txt
# paste -d "\t" ListOfAges.txt NewMiniExp10000.txt > TableToTest10000.txt

######## Concatenate Alternative weights

cat ../../../../Results/UK10K/ImportanceSamplingSims/Exit__0.01_-100_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K/ImportanceSamplingSims/Exit__0.01_-100.txtWeightYears.txt
cat ../../../../Results/UK10K/ImportanceSamplingSims/Exit__0.01_100_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K/ImportanceSamplingSims/Exit__0.01_100.txtWeightYears.txt

