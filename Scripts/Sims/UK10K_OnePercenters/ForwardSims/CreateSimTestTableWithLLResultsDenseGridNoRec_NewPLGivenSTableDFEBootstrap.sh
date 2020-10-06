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
FourNs[2]="4Ns_-50"
FourNs[3]="4Ns_-100"
FourNs[4]="4Ns_50"
FourNs[5]="4Ns_100"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFE.txt"
PrefixTwoFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFEAnother.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLengthOnlyCpG"
BootstrapExitFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFEBootstrap"$SLURM_ARRAY_TASK_ID".txt"


perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileBootstrapCloseQuantileDFENew.pl $HapFilePrefix 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile ../../../../Data/LeftBpRecRatePerVariantNoCpG.txt ../../../../Data/RightBpRecRatePerVariantNoCpG.txt 273 ../../../../Data/Plink/CpGMisOnePercentNumberPositionsVar.txt ../../UK10K_PointTwoPercenters/ForwardSims/MissenseOnePercentNoCpG.txt 565630 $BootstrapExitFile $PrefixTwoFile



