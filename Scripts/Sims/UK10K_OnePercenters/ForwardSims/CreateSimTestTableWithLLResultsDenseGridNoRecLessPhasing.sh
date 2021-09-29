#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=01:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_-50"
FourNs[3]="4Ns_-25"
FourNs[4]="4Ns_50"
FourNs[5]="4Ns_25"
FourNs[6]="4Ns_-25"
FourNs[7]="4Ns_25"

FileNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 100 + 1 ))
Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 100 + 1 ))

for i in {1..5}
do
Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$i]}"/"
for k in {3..3}
do
ResultsFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$i]}"/HapLengths/ExitFileNoRecLessPhasingN"${NumberOfMarkers[$k]}"_"$Repetition".txt"
rm $ResultsFile
HapFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$i]}"/HapLengths/HapLengthsLessUnphased"$Repetition".txt"
ParamsFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$i]}"/Params$Repetition.txt"
NumberToTake=$( head -n1 $ParamsFile | awk '{print $4}' )
NumberToTake=$(( $NumberToTake - 1 ))
perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsDifQuantSingleNumber.pl $HapFile 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile ../../../../Data/RightBpRecRatePerVariantNoCpG.txt ../../../../Data/LeftBpRecRatePerVariantNoCpG.txt 275 ../../UK10K_PointTwoPercenters/ForwardSims/MissenseOnePercentNoCpG.txt 565630 PLGivenSTableWithRecs.txt $NumberToTake
done
done

Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 100 + 1 ))

for i in {1..5}
do
Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$i]}"/"
for k in {3..3}
do
ResultsFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$i]}"/HapLengths/ExitFileNoRecLessStatPhasingN"${NumberOfMarkers[$k]}"_"$Repetition".txt"
rm $ResultsFile
HapFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$i]}"/HapLengths/HapLengthsLessStatPhase"$Repetition".txt"
ParamsFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$i]}"/Params$Repetition.txt"
NumberToTake=$( head -n1 $ParamsFile | awk '{print $4}' )
NumberToTake=$(( $NumberToTake - 1 ))
perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsDifQuantSingleNumber.pl $HapFile 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile ../../../../Data/RightBpRecRatePerVariantNoCpG.txt ../../../../Data/LeftBpRecRatePerVariantNoCpG.txt 275 ../../UK10K_PointTwoPercenters/ForwardSims/MissenseOnePercentNoCpG.txt 565630 PLGivenSTableWithRecs.txt $NumberToTake
done
done

