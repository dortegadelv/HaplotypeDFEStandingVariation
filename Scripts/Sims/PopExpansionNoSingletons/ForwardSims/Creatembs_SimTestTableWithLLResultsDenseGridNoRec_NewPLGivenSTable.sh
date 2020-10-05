#$ -l h_rt=24:00:00
#$ -cwd
#$ -A diegoort
#$ -N HapLength

NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

Directory="/u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/PopulationExpansionTest_August2_2015/TestData/run."$SGE_TASK_ID"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFilembsNoRecN_NewTable"${NumberOfMarkers[$k]}".txt"
rm $ResultsFile
for j in {1..23}
do
HapFile=$Directory"HapLength_mbs_NoRecN"${NumberOfMarkers[$k]}"_"$j".txt"
perl ../../CalculatePLengthGivenS.pl $HapFile 500000 /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/PopulationExpansionTest_August2_2015/TableToTest.txt /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/TestT2Bounds.txt $ResultsFile
done
done

