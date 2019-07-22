
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
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/AncientBottleneck/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecN"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionAncientBottleneck"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
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


