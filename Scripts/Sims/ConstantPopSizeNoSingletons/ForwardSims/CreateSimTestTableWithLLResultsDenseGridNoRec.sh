#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
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

Directory="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/HapLengths/ExitFileNoRecN"${NumberOfMarkers[$k]}".txt"
rm $ResultsFile
for j in {1..100}
do
HapFile="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/HapLengths/HapLengths"$j".txt"
perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 ../../../../Results/ConstantPopSize/ImportanceSamplingSims/TableToTest.txt ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile
done
done


