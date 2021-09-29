#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=03:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

module load python

# TrajNum=$( wc -l ../../../../Results/UK10K/ForwardSims/4Ns_-25/Alleles{1..1000}.txt | tail -n1 | awk '{print $1}' )
# echo $TrajNum

## For Single Sequence
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="273"

## For Multi Sequence
# NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="500"
# NumberOfMarkers[3]="1000"


ResampledTrajFile="../../../../Results/UK10K/ForwardSims/4Ns_-25/ResampledTraj"$SLURM_ARRAY_TASK_ID".txt"
MsselOut="../../../../Results/UK10K/ForwardSims/4Ns_-25/MsselOut"$SLURM_ARRAY_TASK_ID".txt"
HapLengths="../../../../Results/UK10K/ForwardSims/4Ns_-25/HapLength"$SLURM_ARRAY_TASK_ID".txt"
MsselOutNoRec="../../../../Results/UK10K/ForwardSims/4Ns_-25/MsselOutNoRec"$SLURM_ARRAY_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/UK10K/ForwardSims/4Ns_-25/HapLengthNoRec"$SLURM_ARRAY_TASK_ID".txt"
MsselOutNoRecAnc="../../../../Results/UK10KForwardSims/4Ns_-25/MsselOutNoRecAnc"$SLURM_ARRAY_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/UK10K/ForwardSims/4Ns_-25/HapLengthNoRecAnc"$SLURM_ARRAY_TASK_ID".txt"

MsselOutMultiSeq="../../../../Results/UK10K/ForwardSims/4Ns_-25/MsselOutMultiSeq"$SLURM_ARRAY_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/UK10K/ForwardSims/4Ns_-25/HapLengthMultiSeq"$SLURM_ARRAY_TASK_ID".txt"
T2File="../../../../Results/UK10K/ForwardSims/4Ns_-25/T2Values"$SLURM_ARRAY_TASK_ID".txt"

# perl TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_-25/Traj_0.01_ 20000 ../../../../Results/UK10K/ForwardSims/4Ns_-25/TrajMsselLike.txt $TrajNum 0 1000
# cat ../../../../Results/UK10K/ForwardSims/4Ns_-25/TrajMsselLike.txt | ../stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_-25/ReducedTrajectories10000.txt

Start=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 3 + 1 ))
End=$(( ( $SLURM_ARRAY_TASK_ID ) * 3 ))
RandomSeed=$(( $SLURM_ARRAY_TASK_ID * 10000 ))

for i in {3..3}
do
for (( Reps = $Start ; Reps <= $End ; Reps++ ))
do

HapLengths="../../../../Results/UK10K/ForwardSims/4Ns_-25/HapLengthN"${NumberOfMarkers[$i]}"_"$Reps".txt"
HapLengthsNoRec="../../../../Results/UK10K/ForwardSims/4Ns_-25/HapLengthNoRecN"${NumberOfMarkers[$i]}"_"$Reps".txt"
HapLengthsMultiSeq="../../../../Results/UK10K/ForwardSims/4Ns_-25/HapLengthMultiSeqN"${NumberOfMarkers[$i]}"_"$Reps".txt"
HapLengthsNoRecAnc="../../../../Results/UK10K/ForwardSims/4Ns_-25/HapLengthNoRecAncN"${NumberOfMarkers[$i]}"_"$Reps".txt"
HapLengthsRecAware="../../../../Results/UK10K/ForwardSims/4Ns_-25/HapLengthRecAwareN"${NumberOfMarkers[$i]}"_"$Reps".txt"
DistancesFileOne="../../../../Results/UK10K/ForwardSims/4Ns_-25/SimDistancesPartOneMssel"${NumberOfMarkers[$i]}"_"$Reps".txt"
DistancesFileTwo="../../../../Results/UK10K/ForwardSims/4Ns_-25/SimDistancesPartTwoMssel"${NumberOfMarkers[$i]}"_"$Reps".txt"
DistancesFile="../../../../Results/UK10K/ForwardSims/4Ns_-25/SimDistancesMssel"${NumberOfMarkers[$i]}"_"$Reps".txt"
SamplesFile="../../../../Results/UK10K/ForwardSims/4Ns_-25/SamplesToCheckMssel"${NumberOfMarkers[$i]}"_"$Reps".txt"

rm $DistancesFile
touch $DistancesFile

for ChrNum in {69..76}
do
Value[$ChrNum]=$( grep 'age' ../../../../Results/UK10K/ForwardSims/4Ns_-25/ReducedTrajectories_$ChrNum.txt | wc -l )
done


Test=`python MultinomialDistSamples.py ${Value[69]} ${Value[70]} ${Value[71]} ${Value[72]} ${Value[73]} ${Value[74]} ${Value[75]} ${Value[76]} $SamplesFile`
Samples[69]=$( echo $Test | cut -d' ' -f1 )
Samples[70]=$( echo $Test | cut -d' ' -f2 )
Samples[71]=$( echo $Test | cut -d' ' -f3 )
Samples[72]=$( echo $Test | cut -d' ' -f4 )
Samples[73]=$( echo $Test | cut -d' ' -f5 )
Samples[74]=$( echo $Test | cut -d' ' -f6 )
Samples[75]=$( echo $Test | cut -d' ' -f7 )
Samples[76]=$( echo $Test | cut -d' ' -f8 )

for SampleNum in {1..275}
do
RandomSeed=$(( RandomSeed + 1 ))

ChrNum=$( head -n$SampleNum $SamplesFile | tail -n1 )

perl ../../ConstantPopSize/ForwardSims/SampleTrajectories.pl ../../../../Results/UK10K/ForwardSims/4Ns_-25/ReducedTrajectories_$ChrNum.txt 1 $ResampledTrajFile $RandomSeed

# ../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOut

# perl ../DistanceToFirstSegregatingSite.pl $MsselOut $HapLengths 

Num=$(( $ChrNum + 1 ))

LeftRec=$( head -n$SampleNum RecRateMissenseOnePercentLeftNoCpG.txt | tail -n1 )
RightRec=$( head -n$SampleNum RecRateMissenseOnePercentRightNoCpG.txt | tail -n1 )

# ../../../../Programs/Mssel/mssel3 73 273 1 72 $ResampledTrajFile 1 -r tbs 250000 -t 8278.425 -eN 0.0 1.0 -eN 0.0001382 0.0121128 -eN 0.0006568 0.0053045 -eN 0.0014541 0.0412624 -eN 0.0042196 0.0208101 < RecRateMissenseOnePercentLeft.txt > $MsselOutNoRec
../../../../Programs/Mssel/mssel3 $Num 1 1 $ChrNum $ResampledTrajFile 1 -r $LeftRec 250000 -t 6167.325 -eN 0.0 1.0 -eN 0.0001490 0.0077465 -eN 0.0008817 0.0071263 -eN 0.0019518 0.0553806 -eN 0.0056639 0.0279335 -seeds $RandomSeed $Num $Num < RecRateMissenseOnePercentLeftNoCpG.txt > $MsselOutNoRec

time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOutNoRec $DistancesFileOne 1 $ChrNum 0 0 25 250000 

cat $DistancesFileOne >> $DistancesFile
echo "#" >> $DistancesFile
# ../../../../Programs/Mssel/mssel3 73 273 1 72 $ResampledTrajFile 1 -r tbs 250000 -t 8278.425 -eN 0.0 1.0 -eN 0.0001382 0.0121128 -eN 0.0006568 0.0053045 -eN 0.0014541 0.0412624 -eN 0.0042196 0.0208101 < RecRateMissenseOnePercentRight.txt > $MsselOutNoRec
../../../../Programs/Mssel/mssel3 $Num 1 1 $ChrNum $ResampledTrajFile 1 -r $RightRec 250000 -t 6167.325 -eN 0.0 1.0 -eN 0.0001490 0.0077465 -eN 0.0008817 0.0071263 -eN 0.0019518 0.0553806 -eN 0.0056639 0.0279335 -seeds $RandomSeed $Num $RandomSeed < RecRateMissenseOnePercentRightNoCpG.txt > $MsselOutNoRec

time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOutNoRec $DistancesFileTwo 1 $ChrNum 0 0 25 250000

cat $DistancesFileTwo >> $DistancesFile
echo "#" >> $DistancesFile
rm $ResampledTrajFile
rm $DistancesFileTwo
rm $DistancesFileOne
# rm $MsselOut
rm $MsselOutNoRec
# rm $MsselOutMultiSeq
# rm $MsselOutNoRecAnc

done
done
done

