i=$1

ResultsFile[1]="PopExpansionChangedRecRate"
ResultsFile[2]="PopExpansionChangedRecRate4Ns50"
ResultsFile[3]="PopExpansionChangedRecRate4Ns100"
ResultsFile[4]="PopExpansionChangedRecRateBoykoDFE"

for j in {1..4}
do
for k in {1..100}
do
ResultsFile="../../../../Results/"${ResultsFile[$j]}"/ForwardSims/HapLengths/ExitFileNoRecLessN"$k".txt"
NewResultsFile="../../../../Results/"${ResultsFile[$j]}"/ForwardSims/HapLengths/ExitFileNoRecLessN"$k"_"$i".txt"
cp $ResultsFile $NewResultsFile
done
done


cd ../../../Sims/PopExpansion/ForwardSims/

Dir[2]="PopExpansionChangedRecRate"
Dir[3]="PopExpansionChangedRecRate4Ns50"
Dir[4]="PopExpansionChangedRecRate4Ns100"
Dir[5]="PopExpansionChangedRecRateBoykoDFE"

for j in {2..5}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/"${Dir[$j]}"/ForwardSims/HapLengths/ExitFileNoRecLess.txt"
cat ../../../../Results/"${Dir[$j]}"/ForwardSims/HapLengths/ExitFileNoRecLessN{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansionSLiM"${Dir[$j]}".txt"
NewDataSummarized="../../../../Results/ResultsSelectionInferred/SelectionPopExpansionSLiM"${Dir[$j]}"_"$i".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTableOnlyNegative.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
cp $DataSummarized $NewDataSummarized
done
done



