
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

Selection[2]="0"
Selection[3]="-5"
Selection[4]="-10"
Selection[5]="-50"
Selection[6]="-100"
Selection[8]="50"

ActualSelection[2]="0"
ActualSelection[3]="5"
ActualSelection[4]="10"
ActualSelection[5]="-50"
ActualSelection[6]="100"
ActualSelection[8]="50"

for i in {2..2}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFileNoRecN_NewTable"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {5..5}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFileNoRecN_NewTable"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {8..8}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFileNoRecN_NewTable"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..2}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFilembsNoRecN_NewTable"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/Selectionmbs"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {5..5}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFilembsNoRecN_NewTable"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/Selectionmbs"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {8..8}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile=$Directory"ExitFilembsNoRecN_NewTable"${NumberOfMarkers[$k]}".txt"
DataSummarized="ResultsSelectionInferred/Selectionmbs"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

