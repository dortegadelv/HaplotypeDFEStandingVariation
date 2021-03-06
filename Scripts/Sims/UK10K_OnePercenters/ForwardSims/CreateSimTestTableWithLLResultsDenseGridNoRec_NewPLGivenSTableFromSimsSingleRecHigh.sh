#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_-25"
FourNs[3]="4Ns_-50"
FourNs[4]="4Ns_25"
FourNs[5]="4Ns_50"

RepNumber=$(( ( ( $SGE_TASK_ID - 1 ) % 1000 ) + 1 ))
DirNumber=$(( ( ( $SGE_TASK_ID - 1 ) / 1000 ) + 1))

echo "RepNumber = $RepNumber DirNumber = $DirNumber"

FileToCheck="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/SimDistancesMsselSingleRecHighRec273_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/LLSimsSingleRecHighRecMssel273_"$RepNumber".txt"
echo "File = $FileToCheck"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsSingleRecHigh.pl $FileToCheck 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults 273 565630



