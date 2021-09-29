#$ -l h_rt=24:00:00,h_data=4G
#$ -cwd
#$ -A diegoort
#$ -N ForWF
#$ -e /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/PopulationExpansionTest_August2_2015/Trash
#$ -o /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/PopulationExpansionTest_August2_2015/Trash

TrajNum=$( wc -l TestData/run.5/Alleles{1..700}.txt | tail -n1 | awk '{print $1}' )
echo $TrajNum

## For Single Sequence
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

## For Multi Sequence
# NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="500"
# NumberOfMarkers[3]="1000"


ResampledTrajFile="TestData/run.5/ResampledTraj"$SGE_TASK_ID".txt"
MsselOut="TestData/run.5/MsselOut"$SGE_TASK_ID".txt"
HapLengths="TestData/run.5/HapLength"$SGE_TASK_ID".txt"
MsselOutNoRec="TestData/run.5/MsselOutNoRec"$SGE_TASK_ID".txt"
HapLengthsNoRec="TestData/run.5/HapLengthNoRec"$SGE_TASK_ID".txt"
MsselOutNoRecAnc="TestData/run.5/MsselOutNoRecAnc"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="TestData/run.5/HapLengthNoRecAnc"$SGE_TASK_ID".txt"

MsselOutMultiSeq="TestData/run.5/MsselOutMultiSeq"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="TestData/run.5/HapLengthMultiSeq"$SGE_TASK_ID".txt"
T2File="TestData/run.5/T2Values"$SGE_TASK_ID".txt"

# perl TrajToMsselFormat.pl TestData/run.2/Traj_0.01_ 20000 TestData/run.2/TrajMsselLike.txt $TrajNum 0 1000
# cat TestData/run.2/TrajMsselLike.txt | ../stepftn > TestData/run.2/ReducedTrajectories.txt

for i in {3..3}
do
HapLengths="TestData/run.5/HapLengthN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRec="TestData/run.5/HapLengthNoRecN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsMultiSeq="TestData/run.5/HapLengthMultiSeqN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRecAnc="TestData/run.5/HapLengthNoRecAncN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsRecAware="TestData/run.5/HapLengthRecAwareN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"
HapLengthsNoRec_mbs="TestData/run.5/HapLength_mbs_NoRecN"${NumberOfMarkers[$i]}"_"$SGE_TASK_ID".txt"


Dir=$SCRATCH"/Trajs4NsMinus50_"$SGE_TASK_ID
mkdir $Dir
PopHistory="/u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/PopulationExpansionTest_August2_2015/DemHistExpansion.txt"
time perl SampleTrajectories_mbs.pl TestData/run.5/ReducedTrajectories.txt ${NumberOfMarkers[$i]} $Dir $SGE_TASK_ID $PopHistory

TrajPrefix="/u/scratch/d/diegoort/Trajs4NsMinus50_"$SGE_TASK_ID"/Traj"

time /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/Programs/mbs/mbs 3 -t 0.002 -r 0.002 -s 500000 1 -f ${NumberOfMarkers[$i]} 1 $TrajPrefix > $MsselOutNoRec
perl DistanceToFirstSegregatingSite_mbs.pl $MsselOutNoRec $HapLengthsNoRec_mbs 500000 1
# ../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOut

# perl ../DistanceToFirstSegregatingSite.pl $MsselOut $HapLengths 

# ../../mssel3 3 ${NumberOfMarkers[$i]} 1 2 $ResampledTrajFile 1 -r 1000 500000 -t 1000 -eN 0.0 1.0 -eN 0.0005 0.1 -T > $MsselOutNoRec

# perl ../../DistanceToFirstSegregatingSite.pl $MsselOutNoRec $HapLengthsNoRec

# perl ../Sardinia_July5_2015/GetT2s.pl $MsselOutNoRec $T2File
# ../../mssel3 102 ${NumberOfMarkers[$i]} 100 2 $ResampledTrajFile 1 -r 1000 500000 -t 1000 -eN 0.0 1.0 -eN 0.0005 0.1 > $MsselOutNoRecAnc

# perl ../DistanceToFirstSegregatingSite.pl $MsselOutNoRecAnc $HapLengthsNoRecAnc

# perl ../../DistanceToFirstSegregatingSiteRecAware.pl $MsselOutNoRecAnc $HapLengthsRecAware 100 2

# ../mssel3 51 ${NumberOfMarkers[$i]} 1 50 $ResampledTrajFile 1 -r 0.0 500000 -t 200 > $MsselOutMultiSeq

# perl ../DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOutMultiSeq $HapLengthsMultiSeq 1 50 

# rm $ResampledTrajFile
# rm $MsselOut
# rm $MsselOutNoRec
# rm $MsselOutMultiSeq
# rm $MsselOutNoRecAnc

done


