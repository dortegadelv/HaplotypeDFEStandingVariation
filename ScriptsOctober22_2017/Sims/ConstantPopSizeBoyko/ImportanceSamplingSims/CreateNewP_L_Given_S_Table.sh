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

cat ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/Exit_0.01_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/Exit_0.01_0.txtWeightYears.txt

time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/Exit_0.01_0.txtWeightYears.txt ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/SumDistancesFile10000.txt ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/NewMiniExp10000.txt ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/NewMiniSD10000.txt

awk '{print $1}' ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/NewMiniExp10000.txt > ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/FirstColumn.txt

paste -d "\t" ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/FirstColumn.txt ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/NewMiniExp10000.txt > ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/TableToTest.txt

# paste -d "\t" ListOfAges.txt NewMiniExp10000.txt > TableToTest10000.txt


