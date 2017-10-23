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

### Do this first
# cat ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.002_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.002_0.txtWeightYears.txt

time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.002_0.txtWeightYears.txt ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/SumDistancesFile10000.txt ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/NewMiniExp10000.txt ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/NewMiniSD10000.txt

awk '{print $1}' ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/NewMiniExp10000.txt > ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/FirstColumn.txt

paste -d "\t" ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/FirstColumn.txt ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/NewMiniExp10000.txt > ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/TableToTest.txt
# paste -d "\t" ListOfAges.txt NewMiniExp10000.txt > TableToTest10000.txt


