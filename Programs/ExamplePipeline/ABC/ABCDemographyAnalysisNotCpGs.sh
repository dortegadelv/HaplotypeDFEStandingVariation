SGE_TASK_ID=$1

Parameters="../Results/ABCAnalysisNotCpG"$SGE_TASK_ID".txt"
CurrentNumber=1

ExitWindowDistanceFile="../Results/WindowDistanceOutNotCpG"$SGE_TASK_ID".txt"
rm $ExitWindowDistanceFile

ExitWindowLowRecDistanceFile="../Results/WindowDistanceLowRecOut"$SGE_TASK_ID".txt"
rm $ExitWindowLowRecDistanceFile

LeftParametersFile="../Results/LeftParameters"$SGE_TASK_ID".txt"
rm $LeftParametersFile

for i in {1..5}
do

FullAlleles="../Results/TrajOutputAllAlleles_"$SGE_TASK_ID".txt"
AlleleList="../Results/PReFerSimOutputAllAlleles_"$SGE_TASK_ID".txt"
rm $FullAlleles
rm $AlleleList

touch $FullAlleles
touch $AlleleList
AlleleNumber=0
# 541

RandomNumber=$(( ( $SGE_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

python RandomNumbersABCNotCpG.py $SGE_TASK_ID $RandomNumber 0.2

LeftParametersFile="../Results/LeftParameters"$SGE_TASK_ID".txt"
RightParametersFile="../Results/RightParameters"$SGE_TASK_ID".txt"

RepNumber=0
TrajRepNumber=1
TimesGoneThroughLoop=0
while [ $AlleleNumber -lt 152 ]
do
CurTrajFile="../Results/TrajOutputAlleles"$SGE_TASK_ID".txt"
PassTrajFile="../Results/TrajOutputAlleles"$SGE_TASK_ID"_"$TrajRepNumber".txt"
RandomNumber=$(( ( $SGE_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

ParameterFile="../Results/PReFerSimParameters"$SGE_TASK_ID".txt"
ParameterFileB="../Results/PReFerSimParameters"$SGE_TASK_ID"_B.txt"
RandomNumberFile="../Results/LeftRandomNumbers"$SGE_TASK_ID".txt"
RightRandomNumberFile="../Results/RightRandomNumbers"$SGE_TASK_ID".txt"
RandomNumberFileLowRec="../Results/LeftLowRecRandomNumbers"$SGE_TASK_ID".txt"
RightRandomNumberFileLowRec="../Results/RightLowRecRandomNumbers"$SGE_TASK_ID".txt"

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../PReFeRSim/PReFerSim $ParameterFile $SGE_TASK_ID

time perl GetListOfRunsWhereFrequencyMatches.pl 0.0095 0.0105 ../Results/PReFerSimOutput$SGE_TASK_ID.txt.$SGE_TASK_ID.full_out.txt ../Results/PReFerSimOutputAlleles_$SGE_TASK_ID.txt 0 160000

File="../Results/PReFerSimOutput"$SGE_TASK_ID".txt."$SGE_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../PReFeRSim/PReFerSim $ParameterFileB $SGE_TASK_ID

TrajOutputAlleles="../Results/PReFerSimOutputAlleles_"$SGE_TASK_ID".txt"
AlleleNumberFile="../Results/PReFerSimOutputAlleles_"$SGE_TASK_ID".txt"

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

MsselFile="../Results/TrajMsselLike"$SGE_TASK_ID".txt"
ReducedTrajectories="../Results/ReducedTrajectories"$SGE_TASK_ID".txt"
DemHistFile="../Results/ConstantSizeDemHist"$SGE_TASK_ID".txt"
TwoN=$( tail -n1 $DemHistFile | awk '{print $1}' )
AlleleCount=$( wc -l $AlleleList | tail -n1 | awk '{print $1}' )
echo $AlleleCount
ThisTrajFile="../Results/TrajOutputAlleles"$SGE_TASK_ID"_"
Reps=$( ls $ThisTrajFile* | wc -l )
perl TrajToMsselFormat.pl $ThisTrajFile $TwoN $MsselFile $AlleleCount 0 $Reps
cat $MsselFile | ../Mssel/stepftn > $ReducedTrajectories

for (( j = 1; j <= $TimesGoneThroughLoop; j++ ))
do
TrajFileToErase="../Results/TrajOutputAlleles"$SGE_TASK_ID"_"$j".txt"
rm $TrajFileToErase
done
## Hap length calculations

MsselOut="../Results/MsselOut"$SGE_TASK_ID".txt"
LeftDistanceOut="../Results/TempLeftDistanceOut"$SGE_TASK_ID".txt"
RightDistanceOut="../Results/TempRightDistanceOut"$SGE_TASK_ID".txt"
DistanceOut="../Results/DistanceOutNotCpG"$SGE_TASK_ID".txt"
ExitWindowDistanceFile="../Results/WindowDistanceOutNotCpG"$SGE_TASK_ID".txt"
ExitWindowLowRecDistanceFile="../Results/WindowDistanceLowRecOut"$SGE_TASK_ID".txt"


# ../../../../Programs/Mssel/mssel3 73 224 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFileLowRec > $MsselOut
# perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $LeftDistanceOut 1 72 0 0 0

# ../../../../Programs/Mssel/mssel3 73 224 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RightRandomNumberFileLowRec > $MsselOut
# perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOut 1 72 0 0 0

# cat $LeftDistanceOut $RightDistanceOut > $DistanceOut

# perl CalculateFrequencyByWindows.pl TestT2Bounds.txt $DistanceOut $ExitWindowLowRecDistanceFile

../Mssel/mssel3 73 152 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFile > $MsselOut
perl DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $LeftDistanceOut 1 72 0 0 1 1

../Mssel/mssel3 73 152 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RightRandomNumberFile > $MsselOut
perl DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOut 1 72 0 0 1 1

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

done


