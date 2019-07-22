#$ -l h_rt=24:00:00
#$ -cwd
#$ -A diegoort
#$ -N HapLength

NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$SGE_TASK_ID"/"
for k in {1..3}
do
ResultsFile=$Directory"ExitFileNoRecN"${NumberOfMarkers[$k]}".txt"
rm $ResultsFile
for j in {1..1000}
do
HapFile=$Directory"HapLengthNoRecN"${NumberOfMarkers[$k]}"_"$j".txt"
perl ../CalculatePLengthGivenS.pl $HapFile 500000 /u/home/d/diegoort/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/MiniExpDense.txt /u/home/d/diegoort/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/TestT2Bounds.txt $ResultsFile
done
done


