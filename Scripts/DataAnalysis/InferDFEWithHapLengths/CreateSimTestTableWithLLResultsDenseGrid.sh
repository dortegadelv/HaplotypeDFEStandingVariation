#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -e ../../../Results/Trash/
#$ -o ../../../Results/Trash/

MutRate[1]="0.000000012"
MutRate[2]="0.000000015"
MutRate[3]="0.00000002"

RecRate[1]="0.0000000025"
RecRate[2]="0.0000000075"
RecRate[3]="0.0000000125"
RecRate[4]="0.0000000234"

ErrorRate[1]="0.000005"
ErrorRate[2]="0.0000075"
ErrorRate[3]="0.00001"
ErrorRate[4]="0.0"

ErrorRateValue=$(( ( ( $SGE_TASK_ID - 1 ) ) % 4 + 1 ))
MutRateValue=$(( ( ( $SGE_TASK_ID - 1 ) ) / 4 + 1 ))
RecRateValue="1"

echo "$ErrorRateValue $MutRateValue $RecRateValue"

Directory="ImportanceSamplingSimsErrorRate"${ErrorRate[$ErrorRateValue]}"MutRate"${MutRate[$MutRateValue]}"RecRate"${RecRate[$RecRateValue]}

echo $Directory

echo ../../../Results/UK10K/$Directory/TableToTest.txt

TableFile="../../../Results/UK10K/"$Directory"/TableToTest.txt"
HapFile="../../../Data/BetterFormatLengthsGroupsPerRecRate0.txt";
ResultsFile="../../../Results/UK10K/"$Directory"/ExitFileGroup0.txt"
echo $TableFile

perl ../../Sims/ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 $TableFile ../../Sims/ConstantPopSize/ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile

####
RecRateValue="2"

Directory="ImportanceSamplingSimsErrorRate"${ErrorRate[$ErrorRateValue]}"MutRate"${MutRate[$MutRateValue]}"RecRate"${RecRate[$RecRateValue]}

echo $Directory

echo ../../../Results/UK10K/$Directory/TableToTest.txt

TableFile="../../../Results/UK10K/"$Directory"/TableToTest.txt"
HapFile="../../../Data/BetterFormatLengthsGroupsPerRecRate1.txt";
ResultsFile="../../../Results/UK10K/"$Directory"/ExitFileGroup1.txt"
echo $TableFile

perl ../../Sims/ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 $TableFile ../../Sims/ConstantPopSize/ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile


###

RecRateValue="3"

Directory="ImportanceSamplingSimsErrorRate"${ErrorRate[$ErrorRateValue]}"MutRate"${MutRate[$MutRateValue]}"RecRate"${RecRate[$RecRateValue]}

echo $Directory

echo ../../../Results/UK10K/$Directory/TableToTest.txt

TableFile="../../../Results/UK10K/"$Directory"/TableToTest.txt"
HapFile="../../../Data/BetterFormatLengthsGroupsPerRecRate2.txt";
ResultsFile="../../../Results/UK10K/"$Directory"/ExitFileGroup2.txt"
echo $TableFile

perl ../../Sims/ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 $TableFile ../../Sims/ConstantPopSize/ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile

###

RecRateValue="4"

Directory="ImportanceSamplingSimsErrorRate"${ErrorRate[$ErrorRateValue]}"MutRate"${MutRate[$MutRateValue]}"RecRate"${RecRate[$RecRateValue]}

echo $Directory

echo ../../../Results/UK10K/$Directory/TableToTest.txt

TableFile="../../../Results/UK10K/"$Directory"/TableToTest.txt"
HapFile="../../../Data/BetterFormatLengthsGroupsPerRecRate3.txt";
ResultsFile="../../../Results/UK10K/"$Directory"/ExitFileGroup3.txt"
echo $TableFile

perl ../../Sims/ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 $TableFile ../../Sims/ConstantPopSize/ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile



