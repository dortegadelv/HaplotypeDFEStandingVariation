#$ -l h_rt=2:00:00,express
#$ -cwd
#$ -A diegoort
#$ -N ForWF

TrajNum=$( wc -l ../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/Alleles{1..300}.txt | tail -n1 | awk '{print $1}' )
echo $TrajNum

## For Single Sequence
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

## For Multi Sequence
# NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="500"
# NumberOfMarkers[3]="1000"


ResampledTrajFile="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/ResampledTraj"$SGE_TASK_ID".txt"
MsselOut="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/MsselOut"$SGE_TASK_ID".txt"
HapLengths="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/HapLength"$SGE_TASK_ID".txt"
MsselOutNoRec="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/MsselOutNoRec"$SGE_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/HapLengthNoRec"$SGE_TASK_ID".txt"
MsselOutNoRecAnc="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/MsselOutNoRecAnc"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/HapLengthNoRecAnc"$SGE_TASK_ID".txt"

MsselOutMultiSeq="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/MsselOutMultiSeq"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/HapLengthMultiSeq"$SGE_TASK_ID".txt"
# perl TrajToMsselFormat.pl TestData/run.2/Traj_0.01_ 20000 TestData/run.2/TrajMsselLike.txt $TrajNum 0 1000
# cat TestData/run.2/TrajMsselLike.txt | ../stepftn > TestData/run.2/ReducedTrajectories.txt
T2File="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/T2Values"$SGE_TASK_ID".txt"

for i in {3..3}
do
HapLengths="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/HapLengthN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/HapLengthNoRecN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/HapLengthMultiSeqN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/HapLengthNoRecAncN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsRecAware="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/HapLengthRecAwareN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"

perl ../SampleTrajectories.pl ../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/ReducedTrajectories.txt ${NumberOfMarkers[$i]} $ResampledTrajFile $SGE_TASK_ID

# ../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOut

# perl ../DistanceToFirstSegregatingSite.pl $MsselOut $HapLengths 

../../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 100 500000 -t 100 -eN 0.0 1.0 -eN 0.005 0.2 -eN 0.015 1.0 -T > $MsselOutNoRec

perl ../../DistanceToFirstSegregatingSite.pl $MsselOutNoRec $HapLengthsNoRec

perl ../Sardinia_July5_2015/GetT2s.pl $MsselOutNoRec $T2File

# ../../mssel3 102 ${NumberOfMarkers[$i]} 100 2 $ResampledTrajFile 1 -r 1000 500000 -t 1000 -eN 0.0 1.0 -eN 0.0005 0.1 > $MsselOutNoRecAnc

# perl ../DistanceToFirstSegregatingSite.pl $MsselOutNoRecAnc $HapLengthsNoRecAnc

# perl ../../DistanceToFirstSegregatingSiteRecAware.pl $MsselOutNoRecAnc $HapLengthsRecAware 100 2

# ../mssel3 51 ${NumberOfMarkers[$i]} 1 50 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOutMultiSeq

# perl ../DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOutMultiSeq $HapLengthsMultiSeq 1 50 

rm $ResampledTrajFile
# rm $MsselOut
rm $MsselOutNoRec
# rm $MsselOutMultiSeq
# rm $MsselOutNoRecAnc

done


