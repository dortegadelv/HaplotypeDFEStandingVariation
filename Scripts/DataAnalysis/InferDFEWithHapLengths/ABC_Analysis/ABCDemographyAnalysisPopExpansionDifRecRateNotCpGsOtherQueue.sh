#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.%A_%a.out
#SBATCH --error=example_sbatch.%A_%a.err
#SBATCH --time=12:00:00
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


Parameters="../../../../Results/ABCAnalysisPopExpansionDifRateNotCpG"$SLURM_ARRAY_TASK_ID".txt"
CurrentNumber=1

ExitWindowDistanceFile="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/WindowDistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
rm $ExitWindowDistanceFile

ExitWindowLowRecDistanceFile="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/WindowDistanceLowRecOut"$SLURM_ARRAY_TASK_ID".txt"
rm $ExitWindowLowRecDistanceFile

LeftParametersFile="../../../../Results/ABCAnalysisPopExpansionDifRate/LeftParameters"$SLURM_ARRAY_TASK_ID".txt"
rm $LeftParametersFile

for i in {1..10}
do

FullAlleles="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/TrajOutputAllAlleles_"$SLURM_ARRAY_TASK_ID".txt"
AlleleList="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/PReFerSimOutputAllAlleles_"$SLURM_ARRAY_TASK_ID".txt"
rm $FullAlleles
rm $AlleleList

touch $FullAlleles
touch $AlleleList
AlleleNumber=0
# 541

RandomNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

python RandomNumbersABCPopExpansionNotCpGDifRate.py $SLURM_ARRAY_TASK_ID $RandomNumber 1.0

LeftParametersFile="../../../../Results/ABCAnalysisPopExpansionDifRate/LeftParameters"$SLURM_ARRAY_TASK_ID".txt"
RightParametersFile="../../../../Results/ABCAnalysisPopExpansionDifRate/RightParameters"$SLURM_ARRAY_TASK_ID".txt"

RepNumber=0
TrajRepNumber=1
TimesGoneThroughLoop=0
while [ $AlleleNumber -lt 150 ]
do
CurTrajFile="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"
PassTrajFile="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID"_"$TrajRepNumber".txt"
RandomNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

ParameterFile="../../../../Results/ABCAnalysisPopExpansionDifRate/PReFerSimParameters"$SLURM_ARRAY_TASK_ID".txt"
ParameterFileB="../../../../Results/ABCAnalysisPopExpansionDifRate/PReFerSimParameters"$SLURM_ARRAY_TASK_ID"_B.txt"
RandomNumberFile="../../../../Results/ABCAnalysisPopExpansionDifRate/LeftRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RightRandomNumberFile="../../../../Results/ABCAnalysisPopExpansionDifRate/RightRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RandomNumberFileLowRec="../../../../Results/ABCAnalysisPopExpansionDifRate/LeftLowRecRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RightRandomNumberFileLowRec="../../../../Results/ABCAnalysisPopExpansionDifRate/RightLowRecRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFile $SLURM_ARRAY_TASK_ID

time perl ../../../../Scripts/Sims/ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 ../../../../Results/ABCAnalysisPopExpansionDifRate/Output/PReFerSimOutput$SLURM_ARRAY_TASK_ID.txt.$SLURM_ARRAY_TASK_ID.full_out.txt ../../../../Results/ABCAnalysisPopExpansionDifRate/Output/PReFerSimOutputAlleles_$SLURM_ARRAY_TASK_ID.txt 0 160000

File="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/PReFerSimOutput"$SLURM_ARRAY_TASK_ID".txt."$SLURM_ARRAY_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFileB $SLURM_ARRAY_TASK_ID

TrajOutputAlleles="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/PReFerSimOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"
AlleleNumberFile="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/PReFerSimOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"

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

MsselFile="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/TrajMsselLike"$SLURM_ARRAY_TASK_ID".txt"
ReducedTrajectories="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/ReducedTrajectories"$SLURM_ARRAY_TASK_ID".txt"
DemHistFile="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/ConstantSizeDemHist"$SLURM_ARRAY_TASK_ID".txt"
TwoN=$( tail -n1 $DemHistFile | awk '{print $1}' )
AlleleCount=$( wc -l $AlleleList | tail -n1 | awk '{print $1}' )
echo $AlleleCount
ThisTrajFile="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID"_"
Reps=$( ls $ThisTrajFile* | wc -l )
perl ../../../Sims/ConstantPopSize/ForwardSims/TrajToMsselFormat.pl $ThisTrajFile $TwoN $MsselFile $AlleleCount 0 $Reps
cat $MsselFile | ../../../../Programs/Mssel/stepftn > $ReducedTrajectories

for (( j = 1; j <= $TimesGoneThroughLoop; j++ ))
do
TrajFileToErase="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID"_"$j".txt"
rm $TrajFileToErase
done
## Hap length calculations

MsselOut="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/MsselOut"$SLURM_ARRAY_TASK_ID".txt"
LeftDistanceOut="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/TempLeftDistanceOut"$SLURM_ARRAY_TASK_ID".txt"
RightDistanceOut="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/TempRightDistanceOut"$SLURM_ARRAY_TASK_ID".txt"
DistanceOut="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/DistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
ExitWindowDistanceFile="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/WindowDistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
ExitWindowLowRecDistanceFile="../../../../Results/ABCAnalysisPopExpansionDifRate/Output/WindowDistanceLowRecOut"$SLURM_ARRAY_TASK_ID".txt"


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


