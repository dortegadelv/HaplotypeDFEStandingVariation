#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=02:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

# cat ConstantSizeDenserGrid/DistancesFile_{1..100}.txt > ConstantSizeDenserGrid/DistancesFile.txt

# perl EstimateHapLengthWeight.pl ConstantSizeDenserGrid/Exit_0.01_0.txtWeightYears.txt ConstantSizeDenserGrid/DistancesFile.txt NewMiniExp.txt NewMiniSD.txt

# awk '{print $1}' MiniExpDense.txt > ListOfAges.txt

# paste -d "\t" ListOfAges.txt NewMiniExp.txt > TableToTest.txt

### 10X more sims for each row of the distances file

# perl SumDistances10000.pl

cat ../../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0_{1001..1001}.txtWeightYears.txt > ../../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt

time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt ../../../../Results/ConstantPopSize/ImportanceSamplingSims/SumDistancesFile100.txt ../../../../Results/ConstantPopSize/ImportanceSamplingSims/NewMiniExp100.txt ../../../../Results/ConstantPopSize/ImportanceSamplingSims/NewMiniSD100.txt

awk '{print $1}' ../../../../Results/ConstantPopSize/ImportanceSamplingSims/NewMiniExp100.txt > ../../../../Results/ConstantPopSize/ImportanceSamplingSims/FirstColumn.txt

paste -d "\t" ../../../../Results/ConstantPopSize/ImportanceSamplingSims/FirstColumn.txt ../../../../Results/ConstantPopSize/ImportanceSamplingSims/NewMiniExp100.txt > ../../../../Results/ConstantPopSize/ImportanceSamplingSims/TableToTest.txt

# paste -d "\t" ListOfAges.txt NewMiniExp10000.txt > TableToTest10000.txt


