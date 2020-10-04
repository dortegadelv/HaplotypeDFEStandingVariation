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
FourNs[2]="4Ns_-25"
FourNs[3]="4Ns_-50"
FourNs[4]="4Ns_25"
FourNs[5]="4Ns_50"

RecRate[1]="0"
RecRate[2]="484.278"
RecRate[3]="855.292"
RecRate[4]="1251.886"
RecRate[5]="1624.489"
RecRate[6]="2164.258"
RecRate[7]="2699.187"
RecRate[8]="3120.820"
RecRate[9]="3509.574"
RecRate[10]="4083.76"
RecRate[11]="4496.201"
RecRate[12]="5625.89"
RecRate[13]="6448.182"
RecRate[14]="7504.213"
RecRate[15]="8522.912"
RecRate[16]="9955.981"
RecRate[17]="10977.747"
RecRate[18]="12265.958"
RecRate[19]="14138.413"
RecRate[20]="19608.766"
RecRate[21]="38656.841"


RecNumber=$(( ( ( $SLURM_ARRAY_TASK_ID - 1 ) / 5 ) + 1 ))
DirNumber=$(( ( ( $SLURM_ARRAY_TASK_ID - 1 ) % 5 ) + 1 ))

for RepNumber in {1..50}
do

###### Minus one

echo "RepNumber = $RepNumber FourNsNumber = $DirNumber ${FourNs[$DirNumber]} RecNumber = $RecNumber ${RecRate[$RecNumber]}"

CurRecNumber=$(( $RecNumber ))

FileToCheck="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/SimDistancesMsselSingleRecHighRecHighMut273_"${RecRate[$RecNumber]}"_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/LLSimsSingleRecHighRecHighMutMssel273_"${RecRate[$RecNumber]}"_"$CurRecNumber"_"$RepNumber".txt"
echo "File = $FileToCheck"
CountDistancesFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/CountDistancesMsselSingleRecHighRecHighMut273_"${RecRate[$RecNumber]}"_"$RepNumber".txt"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

time perl CountDistances.pl $FileToCheck $CountDistancesFile

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsCountsSingleRecMany.pl $CountDistancesFile 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults 273 565630 $CurRecNumber

###### Minus Two 

echo "RepNumber = $RepNumber FourNsNumber = $DirNumber ${FourNs[$DirNumber]} RecNumber = $RecNumber ${RecRate[$RecNumber]}"

CurRecNumber=$(( $RecNumber ))

FileToCheck="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/SimDistancesMsselSingleRecHighRecLowMut273_"${RecRate[$RecNumber]}"_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/LLSimsSingleRecHighRecLowMutMssel273_"${RecRate[$RecNumber]}"_"$CurRecNumber"_"$RepNumber".txt"
echo "File = $FileToCheck"
CountDistancesFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/CountDistancesMsselSingleRecHighRecLowMut273_"${RecRate[$RecNumber]}"_"$RepNumber".txt"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

time perl CountDistances.pl $FileToCheck $CountDistancesFile

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsCountsSingleRecMany.pl $CountDistancesFile 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults 273 565630 $CurRecNumber


done


