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

FourNs[1]="Zero"
FourNs[2]="Fifty"
FourNs[3]="Hundred"
FourNs[4]="Boyko"

ResultsFile[1]="PopExpansionChangedRecRate"
ResultsFile[2]="PopExpansionChangedRecRate4Ns50"
ResultsFile[3]="PopExpansionChangedRecRate4Ns100"
ResultsFile[4]="PopExpansionChangedRecRateBoykoDFE"


FileNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 100 + 1 ))
Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 100 + 1 ))

for i in {3..3}
do
Directory="../../../../Results/PopExpansion/ForwardSims/"${FourNs[$i]}"/"
for k in {3..3}
do
ResultsFile="../../../../Results/"${ResultsFile[$i]}"/ForwardSims/HapLengths/ExitFileNoRecLessN"$Repetition".txt"
rm $ResultsFile
HapFile="../../SLiM/PopExpansion/"${ResultsFile[$i]}"/BootstrapNS"$Repetition".txt"
Table="../../../../Results/PopExpansion"${FourNs[$i]}"/ImportanceSamplingSims/TableToTest.txt"
perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 $Table ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile

done
done

