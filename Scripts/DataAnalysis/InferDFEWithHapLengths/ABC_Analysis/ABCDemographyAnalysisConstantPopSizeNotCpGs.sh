#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.%A_%a.out
#SBATCH --error=example_sbatch.%A_%a.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


Parameters="../../../../Results/ABCAnalysisConstantPopSizeNotCpG"$SLURM_ARRAY_TASK_ID".txt"
CurrentNumber=1

ExitWindowDistanceFile="../../../../Results/ABCAnalysisConstantPopSize/Output/WindowDistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
rm $ExitWindowDistanceFile

ExitWindowLowRecDistanceFile="../../../../Results/ABCAnalysisConstantPopSize/Output/WindowDistanceLowRecOut"$SLURM_ARRAY_TASK_ID".txt"
rm $ExitWindowLowRecDistanceFile

LeftParametersFile="../../../../Results/ABCAnalysisConstantPopSize/LeftParameters"$SLURM_ARRAY_TASK_ID".txt"
rm $LeftParametersFile

for i in {1..10}
do

FullAlleles="../../../../Results/ABCAnalysisConstantPopSize/Output/TrajOutputAllAlleles_"$SLURM_ARRAY_TASK_ID".txt"
AlleleList="../../../../Results/ABCAnalysisConstantPopSize/Output/PReFerSimOutputAllAlleles_"$SLURM_ARRAY_TASK_ID".txt"
rm $FullAlleles
rm $AlleleList

touch $FullAlleles
touch $AlleleList
AlleleNumber=0
# 541

RandomNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

python RandomNumbersABCConstantPopSizeNotCpG.py $SLURM_ARRAY_TASK_ID $RandomNumber 1.0

LeftParametersFile="../../../../Results/ABCAnalysisConstantPopSize/LeftParameters"$SLURM_ARRAY_TASK_ID".txt"
RightParametersFile="../../../../Results/ABCAnalysisConstantPopSize/RightParameters"$SLURM_ARRAY_TASK_ID".txt"

RepNumber=0
TrajRepNumber=1
TimesGoneThroughLoop=0
while [ $AlleleNumber -lt 150 ]
do
CurTrajFile="../../../../Results/ABCAnalysisConstantPopSize/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"
PassTrajFile="../../../../Results/ABCAnalysisConstantPopSize/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID"_"$TrajRepNumber".txt"
RandomNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

ParameterFile="../../../../Results/ABCAnalysisConstantPopSize/PReFerSimParameters"$SLURM_ARRAY_TASK_ID".txt"
ParameterFileB="../../../../Results/ABCAnalysisConstantPopSize/PReFerSimParameters"$SLURM_ARRAY_TASK_ID"_B.txt"
RandomNumberFile="../../../../Results/ABCAnalysisConstantPopSize/LeftRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RightRandomNumberFile="../../../../Results/ABCAnalysisConstantPopSize/RightRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RandomNumberFileLowRec="../../../../Results/ABCAnalysisConstantPopSize/LeftLowRecRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RightRandomNumberFileLowRec="../../../../Results/ABCAnalysisConstantPopSize/RightLowRecRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFile $SLURM_ARRAY_TASK_ID

time perl ../../../../Scripts/Sims/ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 ../../../../Results/ABCAnalysisConstantPopSize/Output/PReFerSimOutput$SLURM_ARRAY_TASK_ID.txt.$SLURM_ARRAY_TASK_ID.full_out.txt ../../../../Results/ABCAnalysisConstantPopSize/Output/PReFerSimOutputAlleles_$SLURM_ARRAY_TASK_ID.txt 0 160000

File="../../../../Results/ABCAnalysisConstantPopSize/Output/PReFerSimOutput"$SLURM_ARRAY_TASK_ID".txt."$SLURM_ARRAY_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFileB $SLURM_ARRAY_TASK_ID

TrajOutputAlleles="../../../../Results/ABCAnalysisConstantPopSize/Output/PReFerSimOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"
AlleleNumberFile="../../../../Results/ABCAnalysisConstantPopSize/Output/PReFerSimOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"

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

MsselFile="../../../../Results/ABCAnalysisConstantPopSize/Output/TrajMsselLike"$SLURM_ARRAY_TASK_ID".txt"
ReducedTrajectories="../../../../Results/ABCAnalysisConstantPopSize/Output/ReducedTrajectories"$SLURM_ARRAY_TASK_ID".txt"
DemHistFile="../../../../Results/ABCAnalysisConstantPopSize/Output/ConstantSizeDemHist"$SLURM_ARRAY_TASK_ID".txt"
TwoN=$( tail -n1 $DemHistFile | awk '{print $1}' )
AlleleCount=$( wc -l $AlleleList | tail -n1 | awk '{print $1}' )
echo $AlleleCount
ThisTrajFile="../../../../Results/ABCAnalysisConstantPopSize/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID"_"
Reps=$( ls $ThisTrajFile* | wc -l )
perl ../../../Sims/ConstantPopSize/ForwardSims/TrajToMsselFormat.pl $ThisTrajFile $TwoN $MsselFile $AlleleCount 0 $Reps
cat $MsselFile | ../../../../Programs/Mssel/stepftn > $ReducedTrajectories

for (( j = 1; j <= $TimesGoneThroughLoop; j++ ))
do
TrajFileToErase="../../../../Results/ABCAnalysisConstantPopSize/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID"_"$j".txt"
rm $TrajFileToErase
done
## Hap length calculations

MsselOut="../../../../Results/ABCAnalysisConstantPopSize/Output/MsselOut"$SLURM_ARRAY_TASK_ID".txt"
LeftDistanceOut="../../../../Results/ABCAnalysisConstantPopSize/Output/TempLeftDistanceOut"$SLURM_ARRAY_TASK_ID".txt"
RightDistanceOut="../../../../Results/ABCAnalysisConstantPopSize/Output/TempRightDistanceOut"$SLURM_ARRAY_TASK_ID".txt"
DistanceOut="../../../../Results/ABCAnalysisConstantPopSize/Output/DistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
ExitWindowDistanceFile="../../../../Results/ABCAnalysisConstantPopSize/Output/WindowDistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
ExitWindowLowRecDistanceFile="../../../../Results/ABCAnalysisConstantPopSize/Output/WindowDistanceLowRecOut"$SLURM_ARRAY_TASK_ID".txt"


# ../../../../Programs/Mssel/mssel3 73 224 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFileLowRec > $MsselOut
# perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $LeftDistanceOut 1 72 0 0 0

# ../../../../Programs/Mssel/mssel3 73 224 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RightRandomNumberFileLowRec > $MsselOut
# perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOut 1 72 0 0 0

# cat $LeftDistanceOut $RightDistanceOut > $DistanceOut

# perl CalculateFrequencyByWindows.pl TestT2Bounds.txt $DistanceOut $ExitWindowLowRecDistanceFile

../../../../Programs/Mssel/mssel3 41 150 1 40 $ReducedTrajectories 250000 -t tbs -r tbs 499999 -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFile > $MsselOut
perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence_NoSingletonsBothSides.pl $MsselOut $LeftDistanceOut 1 40

# ../../../../Programs/Mssel/mssel3 73 152 1 72 $ReducedTrajectories 1 -t tbs -r tbs 500000 -seeds $RandomNumber $RandomNumber $RandomNumber < $RightRandomNumberFile > $MsselOut
# perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOut 1 72 0 0 1 1

# cat $LeftDistanceOut $RightDistanceOut > $DistanceOut

perl CalculateFrequencyByWindows.pl TestT2Bounds.txt $LeftDistanceOut $ExitWindowDistanceFile


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


