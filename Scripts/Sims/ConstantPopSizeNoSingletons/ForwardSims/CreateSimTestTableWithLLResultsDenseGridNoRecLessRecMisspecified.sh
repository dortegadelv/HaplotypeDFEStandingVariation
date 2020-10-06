#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=06:00:00
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
FourNs[6]="4Ns_-25"
FourNs[7]="4Ns_25"

FileNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 100 + 1 ))
Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 100 + 1 ))

for i in {1..5}
do
Directory="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$i]}"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$i]}"/HapLengths/ExitFileNoRecLessSmallRecN"${NumberOfMarkers[$k]}"_"$Repetition".txt"
rm $ResultsFile
HapFile="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$i]}"/HapLengths/HapLengthsLessSmallRec"$Repetition".txt"
perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 ../../../../Results/ConstantPopSize/ImportanceSamplingSims/TableToTest.txt ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile

ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$i]}"/HapLengths/ExitFileNoRecLessBigRecN"${NumberOfMarkers[$k]}"_"$Repetition".txt"
rm $ResultsFile
HapFile="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$i]}"/HapLengths/HapLengthsLessBigRec"$Repetition".txt"
perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 ../../../../Results/ConstantPopSize/ImportanceSamplingSims/TableToTest.txt ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile

ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$i]}"/HapLengths/ExitFileNoRecLessNotSoSmallRecN"${NumberOfMarkers[$k]}"_"$Repetition".txt"
rm $ResultsFile
HapFile="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$i]}"/HapLengths/HapLengthsLessNotSoSmallRec"$Repetition".txt"
perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 ../../../../Results/ConstantPopSize/ImportanceSamplingSims/TableToTest.txt ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile

ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$i]}"/HapLengths/ExitFileNoRecLessNotSoBigRecN"${NumberOfMarkers[$k]}"_"$Repetition".txt"
rm $ResultsFile
HapFile="../../../../Results/ConstantPopSize/ForwardSims/"${FourNs[$i]}"/HapLengths/HapLengthsLessNotSoBigRec"$Repetition".txt"
perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 ../../../../Results/ConstantPopSize/ImportanceSamplingSims/TableToTest.txt ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile


done
done

