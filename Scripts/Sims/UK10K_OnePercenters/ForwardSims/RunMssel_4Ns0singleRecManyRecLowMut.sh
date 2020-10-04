#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


TrajNum=$( wc -l ../../../../Results/UK10K/ForwardSims/4Ns_-50/Alleles{1..120}.txt | tail -n1 | awk '{print $1}' )
echo $TrajNum

## For Single Sequence
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="273"

## For Multi Sequence
# NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="500"
# NumberOfMarkers[3]="1000"

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

RecNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 1 + 1 ))
# Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 100 + 1 ))

for Repetition in {1..50}
do

ResampledTrajFile="../../../../Results/UK10K/ForwardSims/4Ns_0/ResampledTraj"${RecRate[$RecNumber]}"_"$Repetition".txt"
MsselOut="../../../../Results/UK10K/ForwardSims/4Ns_0/MsselOut"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengths="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLength"${RecRate[$RecNumber]}"_"$Repetition".txt"
MsselOutNoRec="../../../../Results/UK10K/ForwardSims/4Ns_0/MsselOutNoRecSingleRec"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsNoRec="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthNoRec"${RecRate[$RecNumber]}"_"$Repetition".txt"
MsselOutNoRecAnc="../../../../Results/UK10K/ForwardSims/4Ns_0/MsselOutNoRecAnc"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsNoRecAnc="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthNoRecAnc"${RecRate[$RecNumber]}"_"$Repetition".txt"

MsselOutMultiSeq="../../../../Results/UK10K/ForwardSims/4Ns_0/MsselOutMultiSeq"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsMultiSeq="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthMultiSeq"${RecRate[$RecNumber]}"_"$Repetition".txt"
T2File="../../../../Results/UK10K/ForwardSims/4Ns_0/T2Values"${RecRate[$RecNumber]}"_"$Repetition".txt"

# perl TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_-50/Traj_0.01_ 20000 ../../../../Results/UK10K/ForwardSims/4Ns_-50/TrajMsselLike.txt $TrajNum 0 1000
# cat ../../../../Results/UK10K/ForwardSims/4Ns_-50/TrajMsselLike.txt | ../stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_-50/ReducedTrajectories.txt

for i in {3..3}
do
HapLengths="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthN"${NumberOfMarkers[$i]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsNoRec="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthNoRecN"${NumberOfMarkers[$i]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsMultiSeq="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthMultiSeqN"${NumberOfMarkers[$i]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsNoRecAnc="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthNoRecAncN"${NumberOfMarkers[$i]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsRecAware="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthRecAwareN"${NumberOfMarkers[$i]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
DistancesFileOne="../../../../Results/UK10K/ForwardSims/4Ns_0/SimDistancesPartOneMsselSingleRec"${NumberOfMarkers[$i]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
DistancesFileTwo="../../../../Results/UK10K/ForwardSims/4Ns_0/SimDistancesPartTwoMsselSingleRec"${NumberOfMarkers[$i]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
DistancesFile="../../../../Results/UK10K/ForwardSims/4Ns_0/SimDistancesMsselSingleRecHighRecLowMut"${NumberOfMarkers[$i]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"

perl ../../ConstantPopSize/ForwardSims/SampleTrajectories.pl ../../../../Results/UK10K/ForwardSims/4Ns_0/ReducedTrajectories10000.txt 273 $ResampledTrajFile $Repetition

Rate=$( echo "scale = 5; ${RecRate[$RecNumber]} * 2" | bc )

echo $Rate

../../../../Programs/Mssel/mssel3 73 273 1 72 $ResampledTrajFile 250000 -r $Rate 499999 -t 16120.5 -eN 0.0 1.0 -eN 0.0001017 0.0066121 -eN 0.0006409 0.0051756 -eN 0.0014188 0.0402604 -eN 0.0041171 0.0203048 > $MsselOutNoRec

time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence_DeleteSingletonsBothSides.pl $MsselOutNoRec $DistancesFile 1 72 0 0 25 250000 


rm $ResampledTrajFile
rm $DistancesFileTwo
rm $DistancesFileOne
rm $MsselOutNoRec

done
done

