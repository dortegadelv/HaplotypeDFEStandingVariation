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

cat ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/Exit__0.01_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt

time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/SumDistancesFile10000.txt ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/NewMiniExp10000.txt ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/NewMiniSD10000.txt

awk '{print $1}' ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/NewMiniExp10000.txt > ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/FirstColumn.txt

paste -d "\t" ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/FirstColumn.txt ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/NewMiniExp10000.txt > ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/TableToTest.txt
# paste -d "\t" ListOfAges.txt NewMiniExp10000.txt > TableToTest10000.txt


