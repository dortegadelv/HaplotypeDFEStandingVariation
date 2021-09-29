#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=36:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

Parameters="../../../../Results/ABCAnalysisNotCpG"$SLURM_ARRAY_TASK_ID".txt"
CurrentNumber=1

ExitWindowDistanceFile="../../../../Results/ABCAnalysis/Output/WindowDistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
rm $ExitWindowDistanceFile

ExitWindowLowRecDistanceFile="../../../../Results/ABCAnalysis/Output/WindowDistanceLowRecOut"$SLURM_ARRAY_TASK_ID".txt"
rm $ExitWindowLowRecDistanceFile

LeftParametersFile="../../../../Results/ABCAnalysis/LeftParameters"$SLURM_ARRAY_TASK_ID".txt"
rm $LeftParametersFile

SampleNumber[1]=0
SampleNumber[2]=0
SampleNumber[3]=0
SampleNumber[4]=0
SampleNumber[5]=0
SampleNumber[6]=0
SampleNumber[7]=0
SampleNumber[8]=0

FrequencyDown[1]=0.0095
FrequencyDown[2]=0.0096
FrequencyDown[3]=0.0097
FrequencyDown[4]=0.0099
FrequencyDown[5]=0.01
FrequencyDown[6]=0.0101
FrequencyDown[7]=0.0103
FrequencyDown[8]=0.0104

FrequencyUp[1]=0.0096
FrequencyUp[2]=0.0097
FrequencyUp[3]=0.0099
FrequencyUp[4]=0.01
FrequencyUp[5]=0.0101
FrequencyUp[6]=0.0103
FrequencyUp[7]=0.0104
FrequencyUp[8]=0.0105

SamplesToTake[1]=17
SamplesToTake[2]=25
SamplesToTake[3]=13
SamplesToTake[4]=21
SamplesToTake[5]=20
SamplesToTake[6]=23
SamplesToTake[7]=12
SamplesToTake[8]=12


for i in {1..100}
do

for j in {1..8}
do

Number=$(( $j + 68 ))

FullAlleles[$j]="../../../../Results/ABCAnalysis/Output/TrajOutputAllAlleles"$Number"_"$SLURM_ARRAY_TASK_ID".txt"
AlleleList[$j]="../../../../Results/ABCAnalysis/Output/PReFerSimOutputAllAlleles"$Number"_"$SLURM_ARRAY_TASK_ID".txt"

rm ${FullAlleles[$j]}
rm ${AlleleList[$j]}

touch ${FullAlleles[$j]}
touch ${AlleleList[$j]}
SampleNumber[$j]=0
AlleleNumber[$j]=0
done
# 541

RandomNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 100000 + $CurrentNumber ))

python RandomNumbersABCNotCpG.py $SLURM_ARRAY_TASK_ID $RandomNumber 0.2

LeftParametersFile="../../../../Results/ABCAnalysis/LeftParameters"$SLURM_ARRAY_TASK_ID".txt"
RightParametersFile="../../../../Results/ABCAnalysis/RightParameters"$SLURM_ARRAY_TASK_ID".txt"

RepNumber=0
TrajRepNumber=1
TimesGoneThroughLoop=0
while [ "${SampleNumber[1]}" -lt 17 ] || [ "${SampleNumber[2]}" -lt 25 ] || [ "${SampleNumber[3]}" -lt 13 ] || [ "${SampleNumber[4]}" -lt 21 ] || [ "${SampleNumber[5]}" -lt 20 ] || [ "${SampleNumber[6]}" -lt 23 ] || [ "${SampleNumber[7]}" -lt 12 ] || [ "${SampleNumber[8]}" -lt 12 ]
do
CurTrajFile="../../../../Results/ABCAnalysis/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"

for j in {1..8}
do

Number=$(( $j + 68 ))

PassTrajFile[$j]="../../../../Results/ABCAnalysis/Output/TrajOutputAlleles"$Number"_"$SLURM_ARRAY_TASK_ID"_"$TrajRepNumber".txt"

done

RandomNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 10000 + $CurrentNumber ))

ParameterFile="../../../../Results/ABCAnalysis/PReFerSimParameters"$SLURM_ARRAY_TASK_ID".txt"
ParameterFileB="../../../../Results/ABCAnalysis/PReFerSimParameters"$SLURM_ARRAY_TASK_ID"_B.txt"
RandomNumberFile="../../../../Results/ABCAnalysis/LeftRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RightRandomNumberFile="../../../../Results/ABCAnalysis/RightRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RandomNumberFileLowRec="../../../../Results/ABCAnalysis/LeftLowRecRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"
RightRandomNumberFileLowRec="../../../../Results/ABCAnalysis/RightLowRecRandomNumbers"$SLURM_ARRAY_TASK_ID".txt"

echo "Random Number file prev = $RandomNumberFile"
echo "Random Number file right prev = $RightRandomNumberFile"



time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFile $SLURM_ARRAY_TASK_ID

time perl ../../../../Scripts/Sims/ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.0095 0.0105 ../../../../Results/ABCAnalysis/Output/PReFerSimOutput$SLURM_ARRAY_TASK_ID.txt.$SLURM_ARRAY_TASK_ID.full_out.txt ../../../../Results/ABCAnalysis/Output/PReFerSimOutputAlleles_$SLURM_ARRAY_TASK_ID.txt 0 160000

File="../../../../Results/ABCAnalysis/Output/PReFerSimOutput"$SLURM_ARRAY_TASK_ID".txt."$SLURM_ARRAY_TASK_ID".full_out.txt"

time GSL_RNG_SEED=$RandomNumber GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFileB $SLURM_ARRAY_TASK_ID

TrajOutputAlleles="../../../../Results/ABCAnalysis/Output/PReFerSimOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"
AlleleNumberFile="../../../../Results/ABCAnalysis/Output/PReFerSimOutputAlleles_"$SLURM_ARRAY_TASK_ID".txt"

for j in {1..8}
do

time perl ../../../../Scripts/Sims/ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl ${FrequencyDown[$j]} ${FrequencyUp[$j]} ../../../../Results/ABCAnalysis/Output/PReFerSimOutput$SLURM_ARRAY_TASK_ID.txt.$SLURM_ARRAY_TASK_ID.full_out.txt ${AlleleList[$j]} 0 160000

# cat $AlleleNumberFile >> ${AlleleList[$j]}

AlleleNumberTemp=$( wc -l ${AlleleList[$j]} | awk '{print $1}' )
SampleNumber[$j]=$(( ${SampleNumber[$j]} + $AlleleNumberTemp ))

echo "Current allele number = $j ${SampleNumber[$j]}"

perl PrintTrajFileFreq.pl ${AlleleList[$j]} $CurTrajFile ${PassTrajFile[$j]}

# rm $CurTrajFile

done

rm $CurTrajFile
rm $File
echo "Line number = "$AlleleNumber" "$i
CurrentNumber=$(( $CurrentNumber + 1 ))
RepNumber=$(( $RepNumber + 1 ))
TrajRepNumber=$(( $TrajRepNumber + 1 ))
TimesGoneThroughLoop=$(( $TimesGoneThroughLoop + 1 ))
done

DistanceOut="../../../../Results/ABCAnalysis/Output/DistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
rm $DistanceOut

for j in {1..8}
do

Number=$(( $j + 68 ))
MsselFile="../../../../Results/ABCAnalysis/Output/TrajMsselLike"$SLURM_ARRAY_TASK_ID".txt"
ReducedTrajectories[$j]="../../../../Results/ABCAnalysis/Output/ReducedTrajectories"$Number"_"$SLURM_ARRAY_TASK_ID".txt"
DemHistFile="../../../../Results/ABCAnalysis/Output/ConstantSizeDemHist"$SLURM_ARRAY_TASK_ID".txt"
TwoN=$( tail -n1 $DemHistFile | awk '{print $1}' )
AlleleCount=${SampleNumber[$j]}
echo $AlleleCount
ThisTrajFile="../../../../Results/ABCAnalysis/Output/TrajOutputAlleles"$Number"_"$SLURM_ARRAY_TASK_ID"_"
Reps=$( ls $ThisTrajFile* | wc -l )
perl ../../../Sims/ConstantPopSize/ForwardSims/TrajToMsselFormat.pl $ThisTrajFile $TwoN $MsselFile $AlleleCount 0 $Reps
cat $MsselFile | ../../../../Programs/Mssel/stepftn > ${ReducedTrajectories[$j]}

for (( k = 1; k <= $Reps; k++ ))
do
CurAlleleTrajFile=$ThisTrajFile""$k".txt"
rm $CurAlleleTrajFile
done
OtherFile="../../../../Results/ABCAnalysis/Output/TrajOutputAllAlleles9_1.txt"
rm ${AlleleList[$j]}
rm ${FullAlleles[$j]}
done

for (( j = 1; j <= $TimesGoneThroughLoop; j++ ))
do
TrajFileToErase="../../../../Results/ABCAnalysis/Output/TrajOutputAlleles_"$SLURM_ARRAY_TASK_ID"_"$j".txt"
rm $TrajFileToErase
done
## Hap length calculations

perl SeparateRandomNumberFile.pl $RandomNumberFile $RightRandomNumberFile

for j in {1..8}
do

Number=$(( $j + 68 ))
NumberPlus=$(( $j + 68 + 1 ))

MsselOut="../../../../Results/ABCAnalysis/Output/MsselOut"$SLURM_ARRAY_TASK_ID".txt"
LeftDistanceOut="../../../../Results/ABCAnalysis/Output/TempLeftDistanceOut"$SLURM_ARRAY_TASK_ID".txt"
RightDistanceOut="../../../../Results/ABCAnalysis/Output/TempRightDistanceOut"$SLURM_ARRAY_TASK_ID".txt"
DistanceOut="../../../../Results/ABCAnalysis/Output/DistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
ExitWindowDistanceFile="../../../../Results/ABCAnalysis/Output/WindowDistanceOutNotCpG"$SLURM_ARRAY_TASK_ID".txt"
ExitWindowLowRecDistanceFile="../../../../Results/ABCAnalysis/Output/WindowDistanceLowRecOut"$SLURM_ARRAY_TASK_ID".txt"

CurLeftRandomNumber=$RandomNumberFile""$Number
CurRightRandomNumber=$RightRandomNumberFile""$Number

# ../../../../Programs/Mssel/mssel3 73 224 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFileLowRec > $MsselOut
# perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $LeftDistanceOut 1 72 0 0 0

# ../../../../Programs/Mssel/mssel3 73 224 1 72 $ReducedTrajectories 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RightRandomNumberFileLowRec > $MsselOut
# perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOut 1 72 0 0 0

# cat $LeftDistanceOut $RightDistanceOut > $DistanceOut

# perl CalculateFrequencyByWindows.pl TestT2Bounds.txt $DistanceOut $ExitWindowLowRecDistanceFile

echo "Random Number file = $RandomNumberFile"
echo "Random Number file right= $RightRandomNumberFile"

echo "Line = ../../../../Programs/Mssel/mssel3 $NumberPlus ${SamplesToTake[$j]} 1 $Number ${ReducedTrajectories[$j]} 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $RandomNumberFile > $MsselOut"

../../../../Programs/Mssel/mssel3 $NumberPlus ${SamplesToTake[$j]} 1 $Number ${ReducedTrajectories[$j]} 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $CurLeftRandomNumber > $MsselOut
perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $LeftDistanceOut 1 $Number 0 0 1 1

../../../../Programs/Mssel/mssel3 $NumberPlus ${SamplesToTake[$j]} 1 $Number ${ReducedTrajectories[$j]} 1 -t tbs -r tbs 250000 -eN tbs tbs -eN tbs tbs -eN tbs tbs -eN tbs tbs -seeds $RandomNumber $RandomNumber $RandomNumber < $CurRightRandomNumber > $MsselOut
perl ../../../Sims/ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOut $RightDistanceOut 1 $Number 0 0 1 1

cat $LeftDistanceOut $RightDistanceOut >> $DistanceOut

rm ${ReducedTrajectories[$j]}
rm $CurLeftRandomNumber
rm $CurRightRandomNumber

done

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


