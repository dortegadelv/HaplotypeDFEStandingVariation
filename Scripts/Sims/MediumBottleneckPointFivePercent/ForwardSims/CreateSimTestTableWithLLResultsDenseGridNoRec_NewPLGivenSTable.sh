#$ -l h_rt=24:00:00
#$ -cwd
#$ -A diegoort
#$ -N HapLength

NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

Directory="TestData/run."$SGE_TASK_ID"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFileNoRecN_NewTable"${NumberOfMarkers[$k]}".txt"
rm $ResultsFile
for j in {1..100}
do
HapFile=$Directory"HapLengthNoRecN"${NumberOfMarkers[$k]}"_"$j".txt"
perl ../../CalculatePLengthGivenS.pl $HapFile 500000 /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/SmootherBottleneck_November5_2015/TableToTest.txt /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/TestT2Bounds.txt $ResultsFile
done
done


