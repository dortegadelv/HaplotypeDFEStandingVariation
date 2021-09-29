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
RecRate[2]="191.352"
RecRate[3]="495.326"
RecRate[4]="783.562"
RecRate[5]="1079.2"
RecRate[6]="1370.047"
RecRate[7]="1888.974"
RecRate[8]="2244.487"
RecRate[9]="2512.65"
RecRate[10]="2881.44"
RecRate[11]="3391.733"
RecRate[12]="3977.678"
RecRate[13]="4614.348"
RecRate[14]="5215.098"
RecRate[15]="5869.541"
RecRate[16]="6966.051"
RecRate[17]="7767.025"
RecRate[18]="8498.236"
RecRate[19]="10215.751"
RecRate[20]="12984.294"
RecRate[21]="23003.3"


RecNumber=$(( ( ( $SLURM_ARRAY_TASK_ID - 1 ) / 5 ) + 1 ))
DirNumber=$(( ( ( $SLURM_ARRAY_TASK_ID - 1 ) % 5 ) + 1 ))

for RepNumber in {1..100}
do

echo "RepNumber = $RepNumber FourNsNumber = $DirNumber ${FourNs[$DirNumber]} RecNumber = $RecNumber ${RecRate[$RecNumber]}"

CurRecNumber=$(( $RecNumber ))

FileToCheck="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/SimDistancesMsselSingleRecHighRec273_"${RecRate[$CurRecNumber]}"_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/LLSimsSingleRecHighRecMssel273_"${RecRate[$RecNumber]}"_"$CurRecNumber"_"$RepNumber".txt"
echo "File = $FileToCheck"
CountDistancesFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/CountDistancesMsselSingleRecHighRec273_"${RecRate[$CurRecNumber]}"_"$RepNumber".txt"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

time perl CountDistances.pl $FileToCheck $CountDistancesFile

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsCountsSingleRecMany.pl $CountDistancesFile 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults 275 411155 $CurRecNumber

# perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsSingleRecMany.pl $FileToCheck 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults 275 411155 $RecNumber

###### Minus one


echo "RepNumber = $RepNumber FourNsNumber = $DirNumber ${FourNs[$DirNumber]} RecNumber = $RecNumber ${RecRate[$RecNumber]}"

CurRecNumber=$(( $RecNumber - 1 ))

FileToCheck="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/SimDistancesMsselSingleRecHighRec273_"${RecRate[$CurRecNumber]}"_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/LLSimsSingleRecHighRecMssel273_"${RecRate[$RecNumber]}"_"$CurRecNumber"_"$RepNumber".txt"
echo "File = $FileToCheck"
CountDistancesFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/CountDistancesMsselSingleRecHighRec273_"${RecRate[$CurRecNumber]}"_"$RepNumber".txt"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

time perl CountDistances.pl $FileToCheck $CountDistancesFile

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsCountsSingleRecMany.pl $CountDistancesFile 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults 275 411155 $RecNumber

###### Minus Two 

echo "RepNumber = $RepNumber FourNsNumber = $DirNumber ${FourNs[$DirNumber]} RecNumber = $RecNumber ${RecRate[$RecNumber]}"

CurRecNumber=$(( $RecNumber - 2 ))

FileToCheck="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/SimDistancesMsselSingleRecHighRec273_"${RecRate[$CurRecNumber]}"_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/LLSimsSingleRecHighRecMssel273_"${RecRate[$RecNumber]}"_"$CurRecNumber"_"$RepNumber".txt"
echo "File = $FileToCheck"
CountDistancesFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/CountDistancesMsselSingleRecHighRec273_"${RecRate[$CurRecNumber]}"_"$RepNumber".txt"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

time perl CountDistances.pl $FileToCheck $CountDistancesFile

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsCountsSingleRecMany.pl $CountDistancesFile 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults 275 411155 $RecNumber

###### Plus One

echo "RepNumber = $RepNumber FourNsNumber = $DirNumber ${FourNs[$DirNumber]} RecNumber = $RecNumber ${RecRate[$RecNumber]}"

CurRecNumber=$(( $RecNumber + 1 ))

FileToCheck="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/SimDistancesMsselSingleRecHighRec273_"${RecRate[$CurRecNumber]}"_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/LLSimsSingleRecHighRecMssel273_"${RecRate[$RecNumber]}"_"$CurRecNumber"_"$RepNumber".txt"
echo "File = $FileToCheck"
CountDistancesFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/CountDistancesMsselSingleRecHighRec273_"${RecRate[$CurRecNumber]}"_"$RepNumber".txt"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

time perl CountDistances.pl $FileToCheck $CountDistancesFile

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsCountsSingleRecMany.pl $CountDistancesFile 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults 275 411155 $RecNumber

###### Plus Two

echo "RepNumber = $RepNumber FourNsNumber = $DirNumber ${FourNs[$DirNumber]} RecNumber = $RecNumber ${RecRate[$RecNumber]}"

CurRecNumber=$(( $RecNumber + 2 ))

FileToCheck="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/SimDistancesMsselSingleRecHighRec273_"${RecRate[$CurRecNumber]}"_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/LLSimsSingleRecHighRecMssel273_"${RecRate[$RecNumber]}"_"$CurRecNumber"_"$RepNumber".txt"
echo "File = $FileToCheck"
CountDistancesFile="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/CountDistancesMsselSingleRecHighRec273_"${RecRate[$CurRecNumber]}"_"$RepNumber".txt"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

time perl CountDistances.pl $FileToCheck $CountDistancesFile

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsCountsSingleRecMany.pl $CountDistancesFile 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults 275 411155 $RecNumber



done


