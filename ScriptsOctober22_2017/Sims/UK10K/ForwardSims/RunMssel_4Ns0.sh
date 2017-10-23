#$ -l h_rt=2:00:00,express
#$ -cwd
#$ -A diegoort
#$ -N ForWF

TrajNum=$( wc -l ../../../../Results/PopExpansion/ForwardSims/4Ns_0/Alleles{1..300}.txt | tail -n1 | awk '{print $1}' )
echo $TrajNum

## For Single Sequence
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

## For Multi Sequence
# NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="500"
# NumberOfMarkers[3]="1000"


ResampledTrajFile="../../../../Results/PopExpansion/ForwardSims/4Ns_0/ResampledTraj"$SGE_TASK_ID".txt"
MsselOut="../../../../Results/PopExpansion/ForwardSims/4Ns_0/MsselOut"$SGE_TASK_ID".txt"
HapLengths="../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLength"$SGE_TASK_ID".txt"
MsselOutNoRec="../../../../Results/PopExpansion/ForwardSims/4Ns_0/MsselOutNoRec"$SGE_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengthNoRec"$SGE_TASK_ID".txt"
MsselOutNoRecAnc="../../../../Results/PopExpansion/ForwardSims/4Ns_0/MsselOutNoRecAnc"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengthNoRecAnc"$SGE_TASK_ID".txt"

MsselOutMultiSeq="../../../../Results/PopExpansion/ForwardSims/4Ns_0/MsselOutMultiSeq"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengthMultiSeq"$SGE_TASK_ID".txt"
T2File="../../../../Results/PopExpansion/ForwardSims/4Ns_0/T2Values"$SGE_TASK_ID".txt"

# perl TrajToMsselFormat.pl ../../../../Results/PopExpansion/ForwardSims/4Ns_0/Traj_0.01_ 20000 ../../../../Results/PopExpansion/ForwardSims/4Ns_0/TrajMsselLike.txt $TrajNum 0 1000
# cat ../../../../Results/PopExpansion/ForwardSims/4Ns_0/TrajMsselLike.txt | ../stepftn > ../../../../Results/PopExpansion/ForwardSims/4Ns_0/ReducedTrajectories.txt

for i in {3..3}
do
HapLengths="../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengthN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengthNoRecN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengthMultiSeqN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengthNoRecAncN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsRecAware="../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengthRecAwareN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"

perl ../SampleTrajectories.pl ../../../../Results/PopExpansion/ForwardSims/4Ns_0/ReducedTrajectories.txt ${NumberOfMarkers[$i]} $ResampledTrajFile $SGE_TASK_ID

# ../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOut

# perl ../DistanceToFirstSegregatingSite.pl $MsselOut $HapLengths 

../../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 2081.304 250000 -t 4127.92 -eN 0.0 1.0 -eN 0.0000867 0.1291653 -eN 0.0001768 0.0421744 -eN 0.0013261 0.0107298 -eN 0.0029405 0.0834516 -eN 0.0085331 0.0420890 > $MsselOutNoRec

# perl ../../DistanceToFirstSegregatingSite.pl $MsselOutNoRec $HapLengthsNoRec

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


