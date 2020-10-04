i=$1

ResultsFile[1]="PopExpansionChangedRecRate"
ResultsFile[2]="PopExpansionChangedRecRate4Ns50"
ResultsFile[3]="PopExpansionChangedRecRate4Ns100"
ResultsFile[4]="PopExpansionChangedRecRateBoykoDFE"

for j in {4..4}
do
for k in {1..100}
do

FileOne="../../../../Results/PopExpansionChangedRecRateBoyko/ForwardSims/HapLengths/ExitFileNoRecLessN"$k".txt"
FileTwo="../../../../Results/PopExpansionChangedRecRateBoyko/ForwardSims/HapLengths/ExitFileNoRecLessSmallN"$k".txt"
FileThree="../../../../Results/PopExpansionChangedRecRateBoyko/ForwardSims/HapLengths/ExitFileNoRecLessCombinedN"$k".txt"

paste -d "\t" $FileOne $FileTwo > $FileThree

NewResultsFile="../../../../Results/PopExpansionChangedRecRateBoyko/ForwardSims/HapLengths/ExitFileNoRecLessCombinedN"$k"_"$i".txt"
cp $FileThree $NewResultsFile
done
done


cd ../../../Sims/PopExpansion/ForwardSims/

Dir[2]="PopExpansionChangedRecRate"
Dir[3]="PopExpansionChangedRecRate4Ns50"
Dir[4]="PopExpansionChangedRecRate4Ns100"
Dir[5]="PopExpansionChangedRecRateBoykoDFE"

for j in {5..5}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/PopExpansionChangedRecRateBoyko/ForwardSims/HapLengths/ExitFileNoRecLessCombined.txt"
cat ../../../../Results/PopExpansionChangedRecRateBoyko/ForwardSims/HapLengths/ExitFileNoRecLessCombinedN{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansionSLiM"${Dir[$j]}".txt"
NewDataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansionSLiM"${Dir[$j]}"_"$i".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
cp $DataSummarized $NewDataSummarized
done
done



