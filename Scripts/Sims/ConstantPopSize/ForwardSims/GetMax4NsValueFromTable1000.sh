
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

for i in {2..6}
do
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSize"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessAncestryMisspecifiedN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeAncestryMisspecified"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessPhasingN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessPhasingN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizePhasing"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessStatPhasingN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessStatPhasingN${NumberOfMarkers[$k]}_{0..99}.txt > $ResultsFile
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeLessStatPhasing"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


#### Rec and Mut Misspecification


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessFivePercentSmallRecN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessFivePercentSmallRecN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeFivePercentSmallRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessFivePercentSmallMutN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessFivePercentSmallMutN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeFivePercentSmallMut"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessFivePercentBigRecN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessFivePercentBigRecN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeFivePercentBigRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessFivePercentBigMutN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessFivePercentBigMutN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeFivePercentBigMut"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessNotSoSmallRecN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessNotSoSmallRecN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeNotSoSmallRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessNotSoSmallMutN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessNotSoSmallMutN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeNotSoSmallMut"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessNotSoBigRecN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessNotSoBigRecN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeNotSoBigRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessNotSoBigMutN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessNotSoBigMutN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeNotSoBigMut"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessSmallRecN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessSmallRecN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeSmallRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessSmallMutN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessSmallMutN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeSmallMut"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessBigRecN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessBigRecN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeBigRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessBigMutN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessBigMutN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSizeBigMut"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

################ 1000 case


for i in {2..6}
do
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSize1000_"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

################ 100 case

for i in {2..6}
do
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/ConstantPopSize/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSize100_"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done



