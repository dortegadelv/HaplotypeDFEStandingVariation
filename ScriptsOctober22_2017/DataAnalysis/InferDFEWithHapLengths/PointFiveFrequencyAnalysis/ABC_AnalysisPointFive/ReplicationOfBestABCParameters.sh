#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../Trash
#$ -e ../Trash

CurrentNumber=1

ExitWindowDistanceFile="../../../../../Results/ABCReplicationPointFive/Output/WindowDistanceOut"$SGE_TASK_ID".txt"
rm $ExitWindowDistanceFile

ExitWindowLowRecDistanceFile="../../../../../Results/ABCReplicationPointFive/Output/WindowDistanceLowRecOut"$SGE_TASK_ID".txt"
rm $ExitWindowLowRecDistanceFile

LeftParametersFile="../../../../../Results/ABCReplicationPointFive/LeftParameters"$SGE_TASK_ID".txt"
rm $LeftParametersFile

FullAlleles="../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAllAlleles_"$SGE_TASK_ID".txt"
AlleleList="../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputAllAlleles_"$SGE_TASK_ID".txt"
rm $FullAlleles
rm $AlleleList

touch $FullAlleles
touch $AlleleList
AlleleNumber=0
# 541

RandomNumber=$(( ( $SGE_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

python RandomNumbersReplicationABC.py $SGE_TASK_ID $RandomNumber 0.2

LeftParametersFile="../../../../../Results/ABCReplicationPointFive/LeftParameters"$SGE_TASK_ID".txt"
RightParametersFile="../../../../../Results/ABCReplicationPointFive/RightParameters"$SGE_TASK_ID".txt"

RepNumber=0
TrajRepNumber=1
TimesGoneThroughLoop=0
while [ $AlleleNumber -lt 3058 ]
do
CurTrajFile="../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAlleles_"$SGE_TASK_ID".txt"
PassTrajFile="../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAlleles_"$SGE_TASK_ID"_"$TrajRepNumber".txt"
RandomNumber=$(( ( $SGE_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

ParameterFile="../../../../../Results/ABCReplicationPointFive/PReFerSimParameters"$SGE_TASK_ID".txt"
ParameterFileB="../../../../../Results/ABCReplicationPointFive/PReFerSimParameters"$SGE_TASK_ID"_B.txt"
RandomNumberFile="../../../../../Results/ABCReplicationPointFive/LeftRandomNumbers"$SGE_TASK_ID".txt"
RightRandomNumberFile="../../../../../Results/ABCReplicationPointFive/RightRandomNumbers"$SGE_TASK_ID".txt"
RandomNumberMissenseFile="../../../../../Results/ABCReplicationPointFive/LeftRandomNumbersMissense"$SGE_TASK_ID".txt"
RightRandomNumberMissenseFile="../../../../../Results/ABCReplicationPointFive/RightRandomNumbersMissense"$SGE_TASK_ID".txt"
RandomNumberFileLowRec="../../../../../Results/ABCReplicationPointFive/LeftLowRecRandomNumbers"$SGE_TASK_ID".txt"
RightRandomNumberFileLowRec="../../../../../Results/ABCReplicationPointFive/RightLowRecRandomNumbers"$SGE_TASK_ID".txt"

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFile $SGE_TASK_ID

time perl /mnt/gluster/home/diegoortega/PurifyingSelectionProject/HaplotypeSelectionProject/Scripts/Sims/ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.0015 0.0025 ../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutput$SGE_TASK_ID.txt.$SGE_TASK_ID.full_out.txt ../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputAlleles_$SGE_TASK_ID.txt 0 160000

File="../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutput"$SGE_TASK_ID".txt."$SGE_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFileB $SGE_TASK_ID

TrajOutputAlleles="../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputAlleles_"$SGE_TASK_ID".txt"
AlleleNumberFile="../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputAlleles_"$SGE_TASK_ID".txt"

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

MsselFile="../../../../../Results/ABCReplicationPointFive/Output/TrajMsselLike"$SGE_TASK_ID".txt"
ReducedTrajectories="../../../../../Results/ABCReplicationPointFive/Output/ReducedTrajectories"$SGE_TASK_ID".txt"
DemHistFile="../../../../../Results/ABCReplicationPointFive/Output/ConstantSizeDemHist"$SGE_TASK_ID".txt"
TwoN=$( tail -n1 $DemHistFile | awk '{print $1}' )
AlleleCount=$( wc -l $AlleleList | tail -n1 | awk '{print $1}' )
echo $AlleleCount
ThisTrajFile="../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAlleles_"$SGE_TASK_ID"_"
Reps=$( ls $ThisTrajFile* | wc -l )
perl ../../../../Sims/ConstantPopSize/ForwardSims/TrajToMsselFormat.pl $ThisTrajFile $TwoN $MsselFile $AlleleCount 0 $Reps
cat $MsselFile | ../../../../../Programs/Mssel/stepftn > $ReducedTrajectories

for (( j = 1; j <= $TimesGoneThroughLoop; j++ ))
do
TrajFileToErase="../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAlleles_"$SGE_TASK_ID"_"$j".txt"
rm $TrajFileToErase
done
## Hap length calculations

MsselOut="../../../../../Results/ABCReplicationPointFive/Output/MsselOut"$SGE_TASK_ID".txt"
LeftDistanceOut="../../../../../Results/ABCReplicationPointFive/Output/TempLeftDistanceOut"$SGE_TASK_ID".txt"
RightDistanceOut="../../../../../Results/ABCReplicationPointFive/Output/TempRightDistanceOut"$SGE_TASK_ID".txt"
LeftDistanceOutMissense="../../../../../Results/ABCReplicationPointFive/Output/TempLeftDistanceOutMissense"$SGE_TASK_ID".txt"
RightDistanceOutMissense="../../../../../Results/ABCReplicationPointFive/Output/TempRightDistanceOutMissense"$SGE_TASK_ID".txt"
DistanceOut="../../../../../Results/ABCReplicationPointFive/Output/DistanceOut"$SGE_TASK_ID".txt"
ExitWindowDistanceFile="../../../../../Results/ABCReplicationPointFive/Output/WindowDistanceOut"$SGE_TASK_ID".txt"
ExitWindowLowRecDistanceFile="../../../../../Results/ABCReplicationPointFive/Output/WindowDistanceLowRecOut"$SGE_TASK_ID".txt"
ExitWindowDistanceFileMissense="../../../../../Results/ABCReplicationPointFive/Output/WindowDistanceOutMissense"$SGE_TASK_ID".txt"
DistanceOutMissense="../../../../../Results/ABCReplicationPointFive/Output/DistanceOutMissense"$SGE_TASK_ID".txt"

../../../../../Programs/Mssel/mssel3 16 3058 1 15 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFile > $MsselOut
perl ../../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $LeftDistanceOutMissense 1 15

../../../../../Programs/Mssel/mssel3 16 3058 1 15 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RightRandomNumberFile > $MsselOut
perl ../../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOutMissense 1 15

cat $LeftDistanceOutMissense $RightDistanceOutMissense > $DistanceOut

perl CalculateFrequencyByWindows.pl TestT2Bounds.txt $DistanceOut $ExitWindowDistanceFileMissense

rm $AlleleList
AlleleNumber=0
############################ Selection ###########################

LeftParametersFile="../../../../../Results/ABCReplicationPointFive/LeftParameters"$SGE_TASK_ID".txt"
RightParametersFile="../../../../../Results/ABCReplicationPointFive/RightParameters"$SGE_TASK_ID".txt"

RepNumber=0
TrajRepNumber=1
TimesGoneThroughLoop=0
while [ $AlleleNumber -lt 3058 ]
do
CurTrajFile="../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAllelesSel_"$SGE_TASK_ID".txt"
PassTrajFile="../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAllelesSel_"$SGE_TASK_ID"_"$TrajRepNumber".txt"
RandomNumber=$(( ( $SGE_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

ParameterFile="../../../../../Results/ABCReplicationPointFive/PReFerSimParameters"$SGE_TASK_ID"_C.txt"
ParameterFileB="../../../../../Results/ABCReplicationPointFive/PReFerSimParameters"$SGE_TASK_ID"_D.txt"
RandomNumberFile="../../../../../Results/ABCReplicationPointFive/LeftRandomNumbers"$SGE_TASK_ID".txt"
RightRandomNumberFile="../../../../../Results/ABCReplicationPointFive/RightRandomNumbers"$SGE_TASK_ID".txt"
RandomNumberMissenseFile="../../../../../Results/ABCReplicationPointFive/LeftRandomNumbersMissense"$SGE_TASK_ID".txt"
RightRandomNumberMissenseFile="../../../../../Results/ABCReplicationPointFive/RightRandomNumbersMissense"$SGE_TASK_ID".txt"
RandomNumberFileLowRec="../../../../../Results/ABCReplicationPointFive/LeftLowRecRandomNumbers"$SGE_TASK_ID".txt"
RightRandomNumberFileLowRec="../../../../../Results/ABCReplicationPointFive/RightLowRecRandomNumbers"$SGE_TASK_ID".txt"

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFile $SGE_TASK_ID

time perl /mnt/gluster/home/diegoortega/PurifyingSelectionProject/HaplotypeSelectionProject/Scripts/Sims/ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.0015 0.0025 ../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputSel$SGE_TASK_ID.txt.$SGE_TASK_ID.full_out.txt ../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputAllelesSel_$SGE_TASK_ID.txt 0 160000

File="../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputSel"$SGE_TASK_ID".txt."$SGE_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFileB $SGE_TASK_ID

TrajOutputAlleles="../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputAllelesSel_"$SGE_TASK_ID".txt"
AlleleNumberFile="../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputAllelesSel_"$SGE_TASK_ID".txt"

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


MsselFile="../../../../../Results/ABCReplicationPointFive/Output/TrajMsselLike"$SGE_TASK_ID".txt"
ReducedTrajectories="../../../../../Results/ABCReplicationPointFive/Output/ReducedTrajectories"$SGE_TASK_ID".txt"
DemHistFile="../../../../../Results/ABCReplicationPointFive/Output/ConstantSizeDemHist"$SGE_TASK_ID".txt"
TwoN=$( tail -n1 $DemHistFile | awk '{print $1}' )
AlleleCount=$( wc -l $AlleleList | tail -n1 | awk '{print $1}' )
echo $AlleleCount
ThisTrajFile="../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAllelesSel_"$SGE_TASK_ID"_"
Reps=$( ls $ThisTrajFile* | wc -l )
perl ../../../../Sims/ConstantPopSize/ForwardSims/TrajToMsselFormat.pl $ThisTrajFile $TwoN $MsselFile $AlleleCount 0 $Reps
cat $MsselFile | ../../../../../Programs/Mssel/stepftn > $ReducedTrajectories

for (( j = 1; j <= $TimesGoneThroughLoop; j++ ))
do
TrajFileToErase="../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAllelesSel_"$SGE_TASK_ID"_"$j".txt"
rm $TrajFileToErase
done
## Hap length calculations

MsselOut="../../../../../Results/ABCReplicationPointFive/Output/MsselOut"$SGE_TASK_ID".txt"
LeftDistanceOut="../../../../../Results/ABCReplicationPointFive/Output/TempLeftDistanceOut"$SGE_TASK_ID".txt"
RightDistanceOut="../../../../../Results/ABCReplicationPointFive/Output/TempRightDistanceOut"$SGE_TASK_ID".txt"
LeftDistanceOutMissense="../../../../../Results/ABCReplicationPointFive/Output/TempLeftDistanceOutMissense"$SGE_TASK_ID".txt"
RightDistanceOutMissense="../../../../../Results/ABCReplicationPointFive/Output/TempRightDistanceOutMissense"$SGE_TASK_ID".txt"
DistanceOut="../../../../../Results/ABCReplicationPointFive/Output/DistanceOut"$SGE_TASK_ID".txt"
ExitWindowDistanceFile="../../../../../Results/ABCReplicationPointFive/Output/WindowDistanceOutSel"$SGE_TASK_ID".txt"
ExitWindowLowRecDistanceFile="../../../../../Results/ABCReplicationPointFive/Output/WindowDistanceLowRecOut"$SGE_TASK_ID".txt"
ExitWindowDistanceFileMissense="../../../../../Results/ABCReplicationPointFive/Output/WindowDistanceOutMissenseSel"$SGE_TASK_ID".txt"
DistanceOutMissense="../../../../../Results/ABCReplicationPointFive/Output/DistanceOutMissense"$SGE_TASK_ID".txt"


../../../../../Programs/Mssel/mssel3 16 3058 1 15 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberMissenseFile > $MsselOut
perl ../../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $LeftDistanceOutMissense 1 15

../../../../../Programs/Mssel/mssel3 16 3058 1 15 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RightRandomNumberMissenseFile > $MsselOut
perl ../../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOutMissense 1 15

cat $LeftDistanceOutMissense $RightDistanceOutMissense > $DistanceOut

perl CalculateFrequencyByWindows.pl TestT2Bounds.txt $DistanceOut $ExitWindowDistanceFileMissense



##################################################################

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



