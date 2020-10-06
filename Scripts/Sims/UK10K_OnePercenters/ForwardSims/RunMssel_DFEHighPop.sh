#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=03:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


TrajNum=$( wc -l ../../../../Results/UK10K/ForwardSims/DFETest/Alleles{1..120}.txt | tail -n1 | awk '{print $1}' )
echo $TrajNum

## For Single Sequence
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="273"

## For Multi Sequence
# NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="500"
# NumberOfMarkers[3]="1000"


ResampledTrajFile="../../../../Results/UK10K/ForwardSims/DFETestHighPop/ResampledTraj"$SLURM_ARRAY_TASK_ID".txt"
MsselOut="../../../../Results/UK10K/ForwardSims/DFETestHighPop/MsselOut"$SLURM_ARRAY_TASK_ID".txt"
HapLengths="../../../../Results/UK10K/ForwardSims/DFETestHighPop/HapLength"$SLURM_ARRAY_TASK_ID".txt"
MsselOutNoRec="../../../../Results/UK10K/ForwardSims/DFETestHighPop/MsselOutNoRec"$SLURM_ARRAY_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/UK10K/ForwardSims/DFETestHighPop/HapLengthNoRec"$SLURM_ARRAY_TASK_ID".txt"
MsselOutNoRecAnc="../../../../Results/UK10K/ForwardSims/DFETestHighPop/MsselOutNoRecAnc"$SLURM_ARRAY_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/UK10K/ForwardSims/DFETestHighPop/HapLengthNoRecAnc"$SLURM_ARRAY_TASK_ID".txt"

MsselOutMultiSeq="../../../../Results/UK10K/ForwardSims/DFETestHighPop/MsselOutMultiSeq"$SLURM_ARRAY_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/UK10K/ForwardSims/DFETestHighPop/HapLengthMultiSeq"$SLURM_ARRAY_TASK_ID".txt"
T2File="../../../../Results/UK10K/ForwardSims/DFETestHighPop/T2Values"$SLURM_ARRAY_TASK_ID".txt"

# perl TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/DFETest/Traj_0.01_ 20000 ../../../../Results/UK10K/ForwardSims/DFETest/TrajMsselLike.txt $TrajNum 0 1000
# cat ../../../../Results/UK10K/ForwardSims/DFETest/TrajMsselLike.txt | ../stepftn > ../../../../Results/UK10K/ForwardSims/DFETest/ReducedTrajectories.txt

for i in {3..3}
do
HapLengths="../../../../Results/UK10K/ForwardSims/DFETestHighPop/HapLengthN"${NumberOfMarkers[$i]}"_"$SLURM_ARRAY_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/UK10K/ForwardSims/DFETestHighPop/HapLengthNoRecN"${NumberOfMarkers[$i]}"_"$SLURM_ARRAY_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/UK10K/ForwardSims/DFETestHighPop/HapLengthMultiSeqN"${NumberOfMarkers[$i]}"_"$SLURM_ARRAY_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/UK10K/ForwardSims/DFETestHighPop/HapLengthNoRecAncN"${NumberOfMarkers[$i]}"_"$SLURM_ARRAY_TASK_ID".txt"
HapLengthsRecAware="../../../../Results/UK10K/ForwardSims/DFETestHighPop/HapLengthRecAwareN"${NumberOfMarkers[$i]}"_"$SLURM_ARRAY_TASK_ID".txt"
DistancesFileOne="../../../../Results/UK10K/ForwardSims/DFETestHighPop/SimDistancesPartOneMssel"${NumberOfMarkers[$i]}"_"$SLURM_ARRAY_TASK_ID".txt"
DistancesFileTwo="../../../../Results/UK10K/ForwardSims/DFETestHighPop/SimDistancesPartTwoMssel"${NumberOfMarkers[$i]}"_"$SLURM_ARRAY_TASK_ID".txt"
DistancesFile="../../../../Results/UK10K/ForwardSims/DFETestHighPop/SimDistancesMssel"${NumberOfMarkers[$i]}"_"$SLURM_ARRAY_TASK_ID".txt"


perl ../../ConstantPopSize/ForwardSims/SampleTrajectories.pl ../../../../Results/UK10K/ForwardSims/DFETestHighPop/ReducedTrajectories10000.txt 273 $ResampledTrajFile $SLURM_ARRAY_TASK_ID

# ../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOut

# perl ../DistanceToFirstSegregatingSite.pl $MsselOut $HapLengths 

# ../../../../Programs/Mssel/mssel3 73 273 1 72 $ResampledTrajFile 1 -r tbs 250000 -t 8484.45 -eN 0.0 1.0 -eN 0.0001017 0.0066121 -eN 0.0006409 0.0051756 -eN 0.0014188 0.0402604 -eN 0.0041171 0.0203048 < RecRateMissenseOnePercentLeftNoCpG.txt > $MsselOutNoRec

../../../../Programs/Mssel/mssel3 73 273 1 72 $ResampledTrajFile 1 -r tbs 250000 -t 8484.45 -eN 0.0 1.0 -eN 0.0001017 0.0066121 -eN 0.0006409 0.0051756 -eN 0.0014188 0.0402604 -eN 0.0041171 0.0203048 -seeds $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID < RecRateMissenseOnePercentRightNoCpG.txt > $MsselOutNoRec

time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOutNoRec $DistancesFileOne 1 72 0 0 25 250000 

# ../../../../Programs/Mssel/mssel3 73 611 1 72 $ResampledTrajFile 1 -r tbs 250000 -t 8484.45 -eN 0.0 1.0 -eN 0.0001017 0.0066121 -eN 0.0006409 0.0051756 -eN 0.0014188 0.0402604 -eN 0.0041171 0.0203048 < RecRateMissenseOnePercentRightNoCpG.txt > $MsselOutNoRec

../../../../Programs/Mssel/mssel3 73 273 1 72 $ResampledTrajFile 1 -r tbs 250000 -t 8484.45 -eN 0.0 1.0 -eN 0.0001017 0.0066121 -eN 0.0006409 0.0051756 -eN 0.0014188 0.0402604 -eN 0.0041171 0.0203048 -seeds $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID < RecRateMissenseOnePercentLeftNoCpG.txt > $MsselOutNoRec

time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOutNoRec $DistancesFileTwo 1 72 0 0 25 250000

cat $DistancesFileOne $DistancesFileTwo > $DistancesFile
# perl ../../DistanceToFirstSegregatingSite.pl $MsselOutNoRec $HapLengthsNoRec

# perl ../Sardinia_July5_2015/GetT2s.pl $MsselOutNoRec $T2File
# ../../mssel3 102 ${NumberOfMarkers[$i]} 100 2 $ResampledTrajFile 1 -r 1000 500000 -t 1000 -eN 0.0 1.0 -eN 0.0005 0.1 > $MsselOutNoRecAnc

# perl ../DistanceToFirstSegregatingSite.pl $MsselOutNoRecAnc $HapLengthsNoRecAnc

# perl ../../DistanceToFirstSegregatingSiteRecAware.pl $MsselOutNoRecAnc $HapLengthsRecAware 100 2

# ../mssel3 51 ${NumberOfMarkers[$i]} 1 50 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOutMultiSeq

# perl ../DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOutMultiSeq $HapLengthsMultiSeq 1 50 

rm $ResampledTrajFile
rm $DistancesFileTwo
rm $DistancesFileOne
# rm $MsselOut
rm $MsselOutNoRec
# rm $MsselOutMultiSeq
# rm $MsselOutNoRecAnc

done


