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

# cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt

# time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt ../../../../Results/UK10K_OnePercentersNoSingleton/ImportanceSamplingSims/SumDistancesFile10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/NewMiniExp10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/NewMiniSD10000.txt

# awk '{print $1}' ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/NewMiniExp10000.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/FirstColumn.txt

# paste -d "\t" ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/FirstColumn.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/NewMiniExp10000.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/TableToTest.txt
# paste -d "\t" ListOfAges.txt NewMiniExp10000.txt > TableToTest10000.txt

### Do this first
# cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0.txtWeightYears.txt

time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0.txtWeightYears.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/SumDistancesFile10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/NewMiniExp10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/NewMiniSD10000.txt

awk '{print $1}' ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/NewMiniExp10000.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/FirstColumn.txt

paste -d "\t" ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/FirstColumn.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/NewMiniExp10000.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$SGE_TASK_ID"/TableToTest.txt
# paste -d "\t" ListOfAges.txt NewMiniExp10000.txt > TableToTest10000.txt

#### Check alternative weights and ESS

# cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0.txtWeightYearsTest2.txt

# cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_100_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_100.txtWeightYears.txt

# cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_-100_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_-100.txtWeightYears.txt

# cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_0.txtWeightYears.txt

# cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_100_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_100.txtWeightYears.txt

# cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_-100_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_-100.txtWeightYears.txt

# cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_200_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_200.txtWeightYears.txt

###### HighPop Test

# time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_100.txtWeightYears.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/SumDistancesFile10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniSDHighPop10000.txt

# awk '{print $1}' ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop10000.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/FirstColumnHighPop.txt

# paste -d "\t" ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/FirstColumnHighPop.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/TableToTestHighPop.txt

## Test 2
# time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_100.txtWeightYears.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/SumDistancesFile10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop_100_10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniSDHighPop_100_10000.txt

# awk '{print $1}' ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop_100_10000.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/FirstColumnHighPop.txt

# paste -d "\t" ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/FirstColumnHighPop.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop_100_10000.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/TableToTestHighPop.txt


