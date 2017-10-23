
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

Selection[2]="0"
Selection[3]="-50"
Selection[4]="-100"
Selection[5]="50"
Selection[6]="100"

ActualSelection[2]="0"
ActualSelection[3]="-50"
ActualSelection[4]="-100"
ActualSelection[5]="50"
ActualSelection[6]="100"

Dir[2]="4Ns_0"
Dir[3]="4Ns_-50"
Dir[4]="4Ns_-100"
Dir[5]="4Ns_50"
Dir[6]="4Ns_100"


for i in {2..6}
do
# Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecN"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSize"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$i"/"
for k in {1..3}
do
ResultsFile=$Directory"ExitFileNoRecN"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/SelectionNoRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFileNoRecN_NewTable"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/SelectionNoRec_NewTable"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
echo $ResultsFile
echo $DataSummarized
done
done


NumberOfMarkers[1]="100"

for k in {2..6}
do
Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$k"/"
AllResultsFile=$Directory"ExitFileMultiSeqN"${NumberOfMarkers[1]}".txt"
rm $AllResultsFile
for j in {1..1000}
do
File=$Directory"ExitFileMultiSeqN"${NumberOfMarkers[1]}"_"$j".txt"
cat $File >> $AllResultsFile
done
done


for i in {2..6}
do
Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$i"/"
for k in {1..1}
do
ResultsFile=$Directory"ExitFileMultiSeqN"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/SelectionMultiSeq"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$i"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFileRecAwareN"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/SelectionRecAware"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

##### mbs
i=2
Directory="/u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$i"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFileNoRec_mbs_NewTable"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/Selection_mbs_RecAware"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done

i=2
Directory="/u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$i"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFile_mbs_NewTable"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/Selection_mbs_"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done

