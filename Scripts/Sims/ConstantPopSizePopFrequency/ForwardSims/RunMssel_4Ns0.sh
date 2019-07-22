#$ -l h_rt=24:00:00
#$ -cwd
#$ -A diegoort
#$ -N ForWF

TrajNum=$( wc -l ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Alleles{1..1000}.txt | tail -n1 | awk '{print $1}' )
echo $TrajNum

## For Single Sequence
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

## For Multi Sequence
# NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="500"
# NumberOfMarkers[3]="1000"


ResampledTrajFile="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/ResampledTraj"$SGE_TASK_ID".txt"
MsselOut="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/MsselOut"$SGE_TASK_ID".txt"
HapLengths="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLength"$SGE_TASK_ID".txt"
MsselOutNoRec="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/MsselOutNoRec"$SGE_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengthNoRec"$SGE_TASK_ID".txt"
MsselOutNoRecAnc="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/MsselOutNoRecAnc"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengthNoRecAnc"$SGE_TASK_ID".txt"

MsselOutMultiSeq="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/MsselOutMultiSeq"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengthMultiSeq"$SGE_TASK_ID".txt"
T2File="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/T2Values"$SGE_TASK_ID".txt"

# perl TrajToMsselFormat.pl ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Traj_0.01_ 20000 ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/TrajMsselLike.txt $TrajNum 0 1000
# cat ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/TrajMsselLike.txt | ../stepftn > ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/ReducedTrajectories.txt

for i in {3..3}
do
HapLengths="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengthN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRec="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengthNoRecN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengthMultiSeqN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengthNoRecAncN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsRecAware="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengthRecAwareN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"

perl SampleTrajectories.pl ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/ReducedTrajectories.txt ${NumberOfMarkers[$i]} $ResampledTrajFile $SGE_TASK_ID

#../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOut

# perl GetT2s.pl $MsselOutNoRec $T2File
# perl ../DistanceToFirstSegregatingSite.pl $MsselOut $HapLengths 

../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 100 500000 -t 100 -T > $MsselOutNoRec

perl Sardinia_July5_2015/GetT2s.pl $MsselOutNoRec $T2File
#perl ../DistanceToFirstSegregatingSite.pl $MsselOutNoRec $HapLengthsNoRec

## Next Line and perl ../DistanceToFirstSegregatingSiteRecAware.pl $MsselOutNoRecAnc $HapLengthsRecAware 100 2 were used to do analysis
# ../mssel3 102 ${NumberOfMarkers[$i]} 100 2 $ResampledTrajFile 1 -r 100 500000 -t 100 -T > $MsselOutNoRecAnc

# perl ../DistanceToFirstSegregatingSite.pl $MsselOutNoRecAnc $HapLengthsNoRecAnc

# perl ../DistanceToFirstSegregatingSiteRecAware.pl $MsselOutNoRecAnc $HapLengthsRecAware 100 2

# ../mssel3 51 ${NumberOfMarkers[$i]} 1 50 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOutMultiSeq

# perl ../DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOutMultiSeq $HapLengthsMultiSeq 1 50 

rm $ResampledTrajFile
# rm $MsselOut
rm $MsselOutNoRec
# rm $MsselOutMultiSeq
# rm $MsselOutNoRecAnc

done


