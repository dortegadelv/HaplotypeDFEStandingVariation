#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../Trash
#$ -e ../Trash

CurrentNumber=1

ExitWindowDistanceFile="../../../../Results/ABCReplication/Output/WindowDistanceOut"$SGE_TASK_ID".txt"
rm $ExitWindowDistanceFile

ExitWindowLowRecDistanceFile="../../../../Results/ABCReplication/Output/WindowDistanceLowRecOut"$SGE_TASK_ID".txt"
rm $ExitWindowLowRecDistanceFile

LeftParametersFile="../../../../Results/ABCReplication/LeftParameters"$SGE_TASK_ID".txt"
rm $LeftParametersFile

FullAlleles="../../../../Results/ABCReplication/Output/TrajOutputAllAlleles_"$SGE_TASK_ID".txt"
AlleleList="../../../../Results/ABCReplication/Output/PReFerSimOutputAllAlleles_"$SGE_TASK_ID".txt"
rm $FullAlleles
rm $AlleleList

touch $FullAlleles
touch $AlleleList
AlleleNumber=0
# 541

RandomNumber=$(( ( $SGE_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

python RandomNumbersReplicationABC.py $SGE_TASK_ID $RandomNumber 0.2

LeftParametersFile="../../../../Results/ABCReplication/LeftParameters"$SGE_TASK_ID".txt"
RightParametersFile="../../../../Results/ABCReplication/RightParameters"$SGE_TASK_ID".txt"

RepNumber=0
TrajRepNumber=1
TimesGoneThroughLoop=0
while [ $AlleleNumber -lt 431 ]
do
CurTrajFile="../../../../Results/ABCReplication/Output/TrajOutputAlleles_"$SGE_TASK_ID".txt"
PassTrajFile="../../../../Results/ABCReplication/Output/TrajOutputAlleles_"$SGE_TASK_ID"_"$TrajRepNumber".txt"
RandomNumber=$(( ( $SGE_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

ParameterFile="../../../../Results/ABCReplication/PReFerSimParameters"$SGE_TASK_ID".txt"
ParameterFileB="../../../../Results/ABCReplication/PReFerSimParameters"$SGE_TASK_ID"_B.txt"
RandomNumberFile="../../../../Results/ABCReplication/LeftRandomNumbers"$SGE_TASK_ID".txt"
RightRandomNumberFile="../../../../Results/ABCReplication/RightRandomNumbers"$SGE_TASK_ID".txt"
RandomNumberFileLowRec="../../../../Results/ABCReplication/LeftLowRecRandomNumbers"$SGE_TASK_ID".txt"
RightRandomNumberFileLowRec="../../../../Results/ABCReplication/RightLowRecRandomNumbers"$SGE_TASK_ID".txt"

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFile $SGE_TASK_ID

time perl /mnt/gluster/home/diegoortega/PurifyingSelectionProject/HaplotypeSelectionProject/Scripts/Sims/ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.0095 0.0105 ../../../../Results/ABCReplication/Output/PReFerSimOutput$SGE_TASK_ID.txt.$SGE_TASK_ID.full_out.txt ../../../../Results/ABCReplication/Output/PReFerSimOutputAlleles_$SGE_TASK_ID.txt 0 160000

File="../../../../Results/ABCReplication/Output/PReFerSimOutput"$SGE_TASK_ID".txt."$SGE_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFileB $SGE_TASK_ID

TrajOutputAlleles="../../../../Results/ABCReplication/Output/PReFerSimOutputAlleles_"$SGE_TASK_ID".txt"
AlleleNumberFile="../../../../Results/ABCReplication/Output/PReFerSimOutputAlleles_"$SGE_TASK_ID".txt"

cat $AlleleNumberFile >> $AlleleList

AlleleNumber=$( wc -l $AlleleList | awk '{print $1}' )

cp $CurTrajFile $PassTrajFile
rm $CurTrajFile
echo "Line number = "$AlleleNumber" "$i
CurrentNumber=$(( $CurrentNumber + 1 ))
RepNumber=$(( $RepNumber + 1 ))
TrajRepNumber=$(( $TrajRepNumber + 1 ))
TimesGoneThroughLoop=$(( $TimesGoneThroughLoop + 1 ))
done

MsselFile="../../../../Results/ABCReplication/Output/TrajMsselLike"$SGE_TASK_ID".txt"
ReducedTrajectories="../../../../Results/ABCReplication/Output/ReducedTrajectories"$SGE_TASK_ID".txt"
DemHistFile="../../../../Results/ABCReplication/Output/ConstantSizeDemHist"$SGE_TASK_ID".txt"
TwoN=$( tail -n1 $DemHistFile | awk '{print $1}' )
AlleleCount=$( wc -l $AlleleList | tail -n1 | awk '{print $1}' )
echo $AlleleCount
ThisTrajFile="../../../../Results/ABCReplication/Output/TrajOutputAlleles_"$SGE_TASK_ID"_"
Reps=$( ls $ThisTrajFile* | wc -l )
perl ../../../Sims/ConstantPopSize/ForwardSims/TrajToMsselFormat.pl $ThisTrajFile $TwoN $MsselFile $AlleleCount 0 $Reps
cat $MsselFile | ../../../../Programs/Mssel/stepftn > $ReducedTrajectories

for (( j = 1; j <= $TimesGoneThroughLoop; j++ ))
do
TrajFileToErase="../../../../Results/ABCReplication/Output/TrajOutputAlleles_"$SGE_TASK_ID"_"$j".txt"
rm $TrajFileToErase
done
## Hap length calculations

MsselOut="../../../../Results/ABCReplication/Output/MsselOut"$SGE_TASK_ID".txt"
LeftDistanceOut="../../../../Results/ABCReplication/Output/TempLeftDistanceOut"$SGE_TASK_ID".txt"
RightDistanceOut="../../../../Results/ABCReplication/Output/TempRightDistanceOut"$SGE_TASK_ID".txt"
DistanceOut="../../../../Results/ABCReplication/Output/DistanceOut"$SGE_TASK_ID".txt"
ExitWindowDistanceFile="../../../../Results/ABCReplication/Output/WindowDistanceOut"$SGE_TASK_ID".txt"
ExitWindowLowRecDistanceFile="../../../../Results/ABCReplication/Output/WindowDistanceLowRecOut"$SGE_TASK_ID".txt"


../../../../Programs/Mssel/mssel3 73 224 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFileLowRec > $MsselOut
perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $LeftDistanceOut 1 72 0 0 2 1

../../../../Programs/Mssel/mssel3 73 224 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RightRandomNumberFileLowRec > $MsselOut
perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOut 1 72 0 0 2 1

cat $LeftDistanceOut $RightDistanceOut > $DistanceOut

perl CalculateFrequencyByWindows.pl TestT2Bounds.txt $DistanceOut $ExitWindowLowRecDistanceFile

../../../../Programs/Mssel/mssel3 73 431 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFile > $MsselOut
perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $LeftDistanceOut 1 72 0 0 2 1

../../../../Programs/Mssel/mssel3 73 431 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RightRandomNumberFile > $MsselOut
perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOut 1 72 0 0 2 1

cat $LeftDistanceOut $RightDistanceOut > $DistanceOut

perl CalculateFrequencyByWindows.pl TestT2Bounds.txt $DistanceOut $ExitWindowDistanceFile


rm $MsselOut
rm $LeftDistanceOut
rm $RightDistanceOut
rm $DistanceOut
rm $MsselFile
rm $ReducedTrajectories
rm $DemHistFile
rm $AlleleNumberFile
rm $RandomNumberFile
rm $RightRandomNumberFile
rm $ParameterFileB
rm $ParameterFile
rm $FullAlleles
rm $AlleleList
rm $RightParametersFile
rm $RandomNumberFileLowRec
rm $RightRandomNumberFileLowRec



