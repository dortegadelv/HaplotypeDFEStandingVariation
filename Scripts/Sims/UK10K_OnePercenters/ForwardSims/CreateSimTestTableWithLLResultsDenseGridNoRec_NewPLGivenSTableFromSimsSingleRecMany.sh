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

RepNumber=$(( ( ( $SGE_TASK_ID - 1 ) % 100 ) + 1 ))
RecNumber=$(( ( ( $SGE_TASK_ID - 1 ) / 500 ) + 1 ))
DirNumber=$(( ( ( ( ( $SGE_TASK_ID - 1 ) - ( $RecNumber - 1 ) * 500 ) ) / 100 + 1 )))

echo "RepNumber = $RepNumber FourNsNumber = $DirNumber ${FourNs[$DirNumber]} RecNumber = $RecNumber ${RecRate[$RecNumber]}"

FileToCheck="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/SimDistancesMsselSingleRecHighRec273_"${RecRate[$RecNumber]}"_"$RepNumber".txt"
LLResults="../../../../Results/UK10K/ForwardSims/"${FourNs[$DirNumber]}"/LLSimsSingleRecHighRecMssel273_"${RecRate[$RecNumber]}"_"$RepNumber".txt"
echo "File = $FileToCheck"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileSimsSingleRecMany.pl $FileToCheck 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $LLResults 273 565630 $RecNumber


