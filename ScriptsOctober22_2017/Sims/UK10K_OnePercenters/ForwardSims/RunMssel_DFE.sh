#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

TrajNum=$( wc -l ../../../../Results/UK10K/ForwardSims/DFETest/Alleles{1..120}.txt | tail -n1 | awk '{print $1}' )
echo $TrajNum

## For Single Sequence
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="611"

## For Multi Sequence
# NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="500"
# NumberOfMarkers[3]="1000"


ResampledTrajFile="../../../../Results/UK10K/ForwardSims/DFETest/ResampledTraj"$SGE_TASK_ID".txt"
MsselOut="../../../../Results/UK10K/ForwardSims/DFETest/MsselOut"$SGE_TASK_ID".txt"
HapLengths="../../../../Results/UK10K/ForwardSims/DFETest/HapLength"$SGE_TASK_ID".txt"
MsselOutNoRec="../../../../Results/UK10K/ForwardSims/DFETest/MsselOutNoRec"$SGE_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/UK10K/ForwardSims/DFETest/HapLengthNoRec"$SGE_TASK_ID".txt"
MsselOutNoRecAnc="../../../../Results/UK10K/ForwardSims/DFETest/MsselOutNoRecAnc"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/UK10K/ForwardSims/DFETest/HapLengthNoRecAnc"$SGE_TASK_ID".txt"

MsselOutMultiSeq="../../../../Results/UK10K/ForwardSims/DFETest/MsselOutMultiSeq"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/UK10K/ForwardSims/DFETest/HapLengthMultiSeq"$SGE_TASK_ID".txt"
T2File="../../../../Results/UK10K/ForwardSims/DFETest/T2Values"$SGE_TASK_ID".txt"

# perl TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/DFETest/Traj_0.01_ 20000 ../../../../Results/UK10K/ForwardSims/DFETest/TrajMsselLike.txt $TrajNum 0 1000
# cat ../../../../Results/UK10K/ForwardSims/DFETest/TrajMsselLike.txt | ../stepftn > ../../../../Results/UK10K/ForwardSims/DFETest/ReducedTrajectories.txt

for i in {3..3}
do
HapLengths="../../../../Results/UK10K/ForwardSims/DFETest/HapLengthN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/UK10K/ForwardSims/DFETest/HapLengthNoRecN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/UK10K/ForwardSims/DFETest/HapLengthMultiSeqN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/UK10K/ForwardSims/DFETest/HapLengthNoRecAncN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsRecAware="../../../../Results/UK10K/ForwardSims/DFETest/HapLengthRecAwareN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
DistancesFileOne="../../../../Results/UK10K/ForwardSims/DFETest/SimDistancesPartOneMssel"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
DistancesFileTwo="../../../../Results/UK10K/ForwardSims/DFETest/SimDistancesPartTwoMssel"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
DistancesFile="../../../../Results/UK10K/ForwardSims/DFETest/SimDistancesMssel"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"


perl ../../ConstantPopSize/ForwardSims/SampleTrajectories.pl ../../../../Results/UK10K/ForwardSims/DFETest/ReducedTrajectories50000.txt 611 $ResampledTrajFile $SGE_TASK_ID

# ../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOut

# perl ../DistanceToFirstSegregatingSite.pl $MsselOut $HapLengths 

../../../../Programs/Mssel/mssel3 73 611 1 72 $ResampledTrajFile 1 -r tbs 250000 -t 8278.425 -eN 0.0 1.0 -eN 0.0001382 0.0121128 -eN 0.0006568 0.0053045 -eN 0.0014541 0.0412624 -eN 0.0042196 0.0208101 < RecRateMissenseOnePercentLeft.txt > $MsselOutNoRec

time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOutNoRec $DistancesFileOne 1 72 0 0 25 250000 

../../../../Programs/Mssel/mssel3 73 611 1 72 $ResampledTrajFile 1 -r tbs 250000 -t 8278.425 -eN 0.0 1.0 -eN 0.0001382 0.0121128 -eN 0.0006568 0.0053045 -eN 0.0014541 0.0412624 -eN 0.0042196 0.0208101 < RecRateMissenseOnePercentRight.txt > $MsselOutNoRec

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


