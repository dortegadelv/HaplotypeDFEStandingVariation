
for i in {2..6}
do
# Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/PopExpansion/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecN"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansion"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

