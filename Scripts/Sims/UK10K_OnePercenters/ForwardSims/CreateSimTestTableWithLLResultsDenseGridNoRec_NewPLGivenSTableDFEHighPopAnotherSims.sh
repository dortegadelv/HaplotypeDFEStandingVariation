#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=10:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_-25"
FourNs[3]="4Ns_-50"
FourNs[4]="4Ns_25"
FourNs[5]="4Ns_50"
FourNs[6]="4Ns_1"

RepNumber=$(( ( ( $SLURM_ARRAY_TASK_ID - 1 ) % 100 ) + 1 ))
DirNumber=$(( ( ( $SLURM_ARRAY_TASK_ID - 1 ) / 100 ) + 1))

echo "RepNumber = $RepNumber DirNumber = $DirNumber"

FileToCheck="../../../../Results/UK10K/ForwardSims/DFETestHighPop/SimDistancesMssel273_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/DFETestHighPop/AnotherLLSimsMssel273_"$RepNumber".txt"
echo "File = $FileToCheck"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsDifQuantAnotherDFE.pl $FileToCheck 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults ../../../../Data/RightBpRecRatePerVariantNoCpG.txt ../../../../Data/LeftBpRecRatePerVariantNoCpG.txt 273 ../../UK10K_PointTwoPercenters/ForwardSims/MissenseOnePercentNoCpG.txt 565630



