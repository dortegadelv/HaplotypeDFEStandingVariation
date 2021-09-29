#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=01:00:00
#SBATCH --partition=broadwl
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
Directory="../../../../Results/PopExpansion/ForwardSims/"${FourNs[$i]}"/"
for k in {3..3}
do
ResultsFile="../../../../Results/PopExpansion/ForwardSims/"${FourNs[$i]}"/HapLengths/ExitFileNoRecLess_NoRecPart1N"${NumberOfMarkers[$k]}"_"$Repetition".txt"
rm $ResultsFile
HapFile="../../../../Results/PopExpansion/ForwardSims/"${FourNs[$i]}"/HapLengths/HapLengthsLess"$Repetition".txt"
HapFileLess="../../../../Results/PopExpansion/ForwardSims/"${FourNs[$i]}"/HapLengths/HapLengthsLess_150Markers"$Repetition".txt"

head -n234000 $HapFile > $HapFileLess

perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFileLess 250000 ../../../../Results/PopExpansion/ImportanceSamplingSims/TableToTest.txt ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile

ResultsFileTwo="../../../../Results/PopExpansion/ForwardSims/"${FourNs[$i]}"/HapLengths/ExitFileNoRecLess_NoRecPart2N"${NumberOfMarkers[$k]}"_"$Repetition".txt"
rm $ResultsFileTwo
HapFile="../../../../Results/PopExpansion/ForwardSims/"${FourNs[$i]}"/HapLengths/HapLengthsLessNoRec"$Repetition".txt"
HapFileLess="../../../../Results/PopExpansion/ForwardSims/"${FourNs[$i]}"/HapLengths/HapLengthsLess_NoRec_150Markers"$Repetition".txt"

tail -n234000 $HapFile > $HapFileLess

perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFileLess 250000 ../../../../Results/PopExpansion/ImportanceSamplingSims/TableToTest_NoRec.txt ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFileTwo

ResultsFileAll="../../../../Results/PopExpansion/ForwardSims/"${FourNs[$i]}"/HapLengths/ExitFileNoRecLess_NoRecAllPartsN"${NumberOfMarkers[$k]}"_"$Repetition".txt"
cat $ResultsFile $ResultsFileTwo > $ResultsFileAll

LLFile="../../../../Results/PopExpansion/ForwardSims/"${FourNs[$i]}"/HapLengths/ExitFileNoRecLess_NoRecAllPartsSumN"${NumberOfMarkers[$k]}"_"$Repetition".txt"

LLValue=""
ThisValue=$( cat $ResultsFileAll | cut -f1 | paste -sd+ | bc )
LLValue=$ThisValue

for j in {2..401}
do

ThisValue=$( cat $ResultsFileAll | cut -f$j | paste -sd+ | bc )
LLValue=$LLValue" "$ThisValue
done

echo $LLValue > $LLFile
done
done


