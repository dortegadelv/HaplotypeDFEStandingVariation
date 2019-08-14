#!/bin/bash
# Use current working directory
#$ -cwd
#
# Join stdout and stderr
#$ -j y
#
# Run job through bash shell 
#$ -S /bin/bash
#
#You can edit the scriptsince this line
#
# Your job name
#$ -N Diego_job
#
# Send an email after the job has finished
#$ -m e
#$ -M dortega@liigh.unam.mx
#
# If modules are needed, source modules environment (Do not delete the next line):
. /etc/profile.d/modules.sh
#
# Add any modules you might require:
#


NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_-25"
FourNs[3]="4Ns_-50"
FourNs[4]="4Ns_25"
FourNs[5]="4Ns_50"
FourNs[6]="4Ns_1"

RepNumber=$(( ( ( $SGE_TASK_ID - 1 ) % 100 ) + 1 ))
DirNumber=$(( ( ( $SGE_TASK_ID - 1 ) / 100 ) + 1))

echo "RepNumber = $RepNumber DirNumber = $DirNumber"

FileToCheck="../../../../Results/UK10K/ForwardSims/DFETestHighPop/SimDistancesMssel273_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/DFETestHighPop/AnotherLLSimsMssel273_"$RepNumber".txt"
echo "File = $FileToCheck"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsAnotherDFENew.pl $FileToCheck 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults ../../../../Data/RightBpRecRatePerVariantNoCpG.txt ../../../../Data/LeftBpRecRatePerVariantNoCpG.txt 273 ../../UK10K_PointTwoPercenters/ForwardSims/MissenseOnePercentNoCpG.txt 565630



