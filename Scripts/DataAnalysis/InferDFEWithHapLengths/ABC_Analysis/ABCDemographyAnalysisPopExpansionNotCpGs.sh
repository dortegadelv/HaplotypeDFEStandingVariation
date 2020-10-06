#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.%A_%a.out
#SBATCH --error=example_sbatch.%A_%a.err
#SBATCH --time=12:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


Parameters="../../../../Results/ABCAnalysisPopExpansionNotCpG"$SLURM_ARRAY_TASK_ID".txt"
CurrentNumber=1

ExitWindowDistanceFile="../../../../Results/ABCAnalysisPopExpansion/Output/WindowDistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
rm $ExitWindowDistanceFile

ExitWindowLowRecDistanceFile="../../../../Results/ABCAnalysisPopExpansion/Output/WindowDistanceLowRecOut"$SLURM_ARRAY_TASK_ID".txt"
rm $ExitWindowLowRecDistanceFile

LeftParametersFile="../../../../Results/ABCAnalysisPopExpansion/LeftParameters"$SLURM_ARRAY_TASK_ID".txt"
rm $LeftParametersFile

for i in {1..10}
do

FullAlleles="../../../../Results/ABCAnalysisPopExpansion/Output/TrajOutputAllAlleles_"$SLURM_ARRAY_TASK_ID".txt"
AlleleList="../../../../Results/ABCAnalysisPopExpansion/Output/PReFerSimOutputAllAlleles_"$SLURM_ARRAY_TASK_ID".txt"
rm $FullAlleles
rm $AlleleList

touch $FullAlleles
touch $AlleleList
AlleleNumber=0
# 541

RandomNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

python RandomNumbersABCPopExpansionNotCpG.py $SLURM_ARRAY_TASK_ID $RandomNumber 1.0

LeftParametersFile="../../../../Results/ABCAnalysisPopExpansion/LeftParameters"$SLURM_ARRAY_TASK_ID".txt"
RightParametersFile="../../../../Results/ABCAnalysisPopExpansion/RightParameters"$SLURM_ARRAY_TASK_ID".txt"

RepNumber=0
TrajRepNumber=1
TimesGoneThroughLoop=0
while [ $AlleleNumber -lt 150 ]
do
CurTrajFile="../../../../Results/ABCAnalysisPopExpansion/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"
PassTrajFile="../../../../Results/ABCAnalysisPopExpansion/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID"_"$TrajRepNumber".txt"
RandomNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

ParameterFile="../../../../Results/ABCAnalysisPopExpansion/PReFerSimParameters"$SLURM_ARRAY_TASK_ID".txt"
ParameterFileB="../../../../Results/ABCAnalysisPopExpansion/PReFerSimParameters"$SLURM_ARRAY_TASK_ID"_B.txt"
RandomNumberFile="../../../../Results/ABCAnalysisPopExpansion/LeftRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RightRandomNumberFile="../../../../Results/ABCAnalysisPopExpansion/RightRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RandomNumberFileLowRec="../../../../Results/ABCAnalysisPopExpansion/LeftLowRecRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RightRandomNumberFileLowRec="../../../../Results/ABCAnalysisPopExpansion/RightLowRecRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFile $SLURM_ARRAY_TASK_ID

time perl ../../../../Scripts/Sims/ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 ../../../../Results/ABCAnalysisPopExpansion/Output/PReFerSimOutput$SLURM_ARRAY_TASK_ID.txt.$SLURM_ARRAY_TASK_ID.full_out.txt ../../../../Results/ABCAnalysisPopExpansion/Output/PReFerSimOutputAlleles_$SLURM_ARRAY_TASK_ID.txt 0 160000

File="../../../../Results/ABCAnalysisPopExpansion/Output/PReFerSimOutput"$SLURM_ARRAY_TASK_ID".txt."$SLURM_ARRAY_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFileB $SLURM_ARRAY_TASK_ID

TrajOutputAlleles="../../../../Results/ABCAnalysisPopExpansion/Output/PReFerSimOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"
AlleleNumberFile="../../../../Results/ABCAnalysisPopExpansion/Output/PReFerSimOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"

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

MsselFile="../../../../Results/ABCAnalysisPopExpansion/Output/TrajMsselLike"$SLURM_ARRAY_TASK_ID".txt"
ReducedTrajectories="../../../../Results/ABCAnalysisPopExpansion/Output/ReducedTrajectories"$SLURM_ARRAY_TASK_ID".txt"
DemHistFile="../../../../Results/ABCAnalysisPopExpansion/Output/ConstantSizeDemHist"$SLURM_ARRAY_TASK_ID".txt"
TwoN=$( tail -n1 $DemHistFile | awk '{print $1}' )
AlleleCount=$( wc -l $AlleleList | tail -n1 | awk '{print $1}' )
echo $AlleleCount
ThisTrajFile="../../../../Results/ABCAnalysisPopExpansion/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID"_"
Reps=$( ls $ThisTrajFile* | wc -l )
perl ../../../Sims/ConstantPopSize/ForwardSims/TrajToMsselFormat.pl $ThisTrajFile $TwoN $MsselFile $AlleleCount 0 $Reps
cat $MsselFile | ../../../../Programs/Mssel/stepftn > $ReducedTrajectories

for (( j = 1; j <= $TimesGoneThroughLoop; j++ ))
do
TrajFileToErase="../../../../Results/ABCAnalysisPopExpansion/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID"_"$j".txt"
rm $TrajFileToErase
done
## Hap length calculations

MsselOut="../../../../Results/ABCAnalysisPopExpansion/Output/MsselOut"$SLURM_ARRAY_TASK_ID".txt"
LeftDistanceOut="../../../../Results/ABCAnalysisPopExpansion/Output/TempLeftDistanceOut"$SLURM_ARRAY_TASK_ID".txt"
RightDistanceOut="../../../../Results/ABCAnalysisPopExpansion/Output/TempRightDistanceOut"$SLURM_ARRAY_TASK_ID".txt"
DistanceOut="../../../../Results/ABCAnalysisPopExpansion/Output/DistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
ExitWindowDistanceFile="../../../../Results/ABCAnalysisPopExpansion/Output/WindowDistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
ExitWindowLowRecDistanceFile="../../../../Results/ABCAnalysisPopExpansion/Output/WindowDistanceLowRecOut"$SLURM_ARRAY_TASK_ID".txt"


# ../../../../Programs/Mssel/mssel3 73 224 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFileLowRec > $MsselOut
# perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $LeftDistanceOut 1 72 0 0 0

# ../../../../Programs/Mssel/mssel3 73 224 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RightRandomNumberFileLowRec > $MsselOut
# perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOut 1 72 0 0 0

# cat $LeftDistanceOut $RightDistanceOut > $DistanceOut

# perl CalculateFrequencyByWindows.pl TestT2Bounds.txt $DistanceOut $ExitWindowLowRecDistanceFile

../../../../Programs/Mssel/mssel3 41 150 1 40 $ReducedTrajectories 250000 -t tbs -r tbs 499999 -eN 0.0 1.0 -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFile > $MsselOut
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


