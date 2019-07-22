#$ -l h_rt=24:00:00
#$ -cwd
#$ -A diegoort
#$ -N ForWF

TrajNum=$( wc -l TestData/run.2/Alleles{1..1000}.txt | tail -n1 | awk '{print $1}' )
echo $TrajNum

## For Single Sequence
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

## For Multi Sequence
# NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="500"
# NumberOfMarkers[3]="1000"


ResampledTrajFile="TestData/run.2/ResampledTraj"$SGE_TASK_ID".txt"
MsselOut="TestData/run.2/MsselOut"$SGE_TASK_ID".txt"
HapLengths="TestData/run.2/HapLength"$SGE_TASK_ID".txt"
MsselOutNoRec="TestData/run.2/MsselOutNoRec"$SGE_TASK_ID".txt"
HapLengthsNoRec="TestData/run.2/HapLengthNoRec"$SGE_TASK_ID".txt"
MsselOutNoRecAnc="TestData/run.2/MsselOutNoRecAnc"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="TestData/run.2/HapLengthNoRecAnc"$SGE_TASK_ID".txt"

MsselOutMultiSeq="TestData/run.2/MsselOutMultiSeq"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="TestData/run.2/HapLengthMultiSeq"$SGE_TASK_ID".txt"
T2File="TestData/run.2/T2Values"$SGE_TASK_ID".txt"

# perl TrajToMsselFormat.pl TestData/run.2/Traj_0.01_ 20000 TestData/run.2/TrajMsselLike.txt $TrajNum 0 1000
# cat TestData/run.2/TrajMsselLike.txt | ../stepftn > TestData/run.2/ReducedTrajectories.txt

for i in {3..3}
do
HapLengths="TestData/run.2/HapLengthN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRec="TestData/run.2/HapLengthNoRecN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="TestData/run.2/HapLengthMultiSeqN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="TestData/run.2/HapLengthNoRecAncN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsRecAware="TestData/run.2/HapLengthRecAwareN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"

perl SampleTrajectories.pl TestData/run.2/ReducedTrajectories.txt ${NumberOfMarkers[$i]} $ResampledTrajFile $SGE_TASK_ID

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


