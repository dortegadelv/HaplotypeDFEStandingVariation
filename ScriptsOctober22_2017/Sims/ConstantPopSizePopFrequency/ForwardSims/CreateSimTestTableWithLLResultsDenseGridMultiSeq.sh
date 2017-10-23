#$ -l h_rt=24:00:00
#$ -cwd
#$ -A diegoort
#$ -N HapLength
#$ -e /u/scratch/d/diegoort
#$ -o /u/scratch/d/diegoort

NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="5000"
# NumberOfMarkers[3]="10000"

# Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$SGE_TASK_ID"/"
for k in {2..6}
do
Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$k"/"
ResultsFile=$Directory"ExitFileMultiSeqN"${NumberOfMarkers[1]}"_"$SGE_TASK_ID".txt"
rm $ResultsFile

HapFile=$Directory"HapLengthMultiSeqN"${NumberOfMarkers[1]}"_"$SGE_TASK_ID".txt"
perl ../CalculatePLengthGivenS.pl $HapFile 500000 /u/home/d/diegoort/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/MiniExpDense.txt /u/home/d/diegoort/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/TestT2Bounds.txt $ResultsFile
done


