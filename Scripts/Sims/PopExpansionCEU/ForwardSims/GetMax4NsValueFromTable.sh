

NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

Selection[2]="0"
Selection[3]="-50"
Selection[4]="-100"
Selection[5]="50"
Selection[6]="100"
Selection[7]="-25"
Selection[8]="25"

ActualSelection[2]="0"
ActualSelection[3]="-50"
ActualSelection[4]="-100"
ActualSelection[5]="50"
ActualSelection[6]="100"
ActualSelection[7]="-25"
ActualSelection[8]="25"

Dir[2]="4Ns_0"
Dir[3]="4Ns_-50"
Dir[4]="4Ns_-100"
Dir[5]="4Ns_50"
Dir[6]="4Ns_100"
Dir[7]="4Ns_-25"
Dir[8]="4Ns_25"

for i in {2..8}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/PopExpansionCEU/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/PopExpansionCEU/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansionCEU"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/PopExpansionCEU/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/PopExpansionCEU/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansionNewCEU"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/PopExpansionCEU/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/PopExpansionCEU/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansionCEU"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/PopExpansion10000GensAgo/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/PopExpansion10000GensAgo/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansion10000GensAgo"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/PopExpansion1000GensAgo/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/PopExpansion1000GensAgo/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansion1000GensAgo"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/PopExpansion100GensAgo/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/PopExpansion100GensAgo/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansion100GensAgo"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done




