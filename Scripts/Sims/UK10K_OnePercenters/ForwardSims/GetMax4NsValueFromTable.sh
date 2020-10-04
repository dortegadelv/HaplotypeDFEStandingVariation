
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

Selection[2]="0"
Selection[3]="-50"
Selection[4]="-25"
Selection[5]="50"
Selection[6]="25"

ActualSelection[2]="0"
ActualSelection[3]="-50"
ActualSelection[4]="-25"
ActualSelection[5]="50"
ActualSelection[6]="25"

Dir[2]="4Ns_0"
Dir[3]="4Ns_-50"
Dir[4]="4Ns_-25"
Dir[5]="4Ns_50"
Dir[6]="4Ns_25"


for i in {2..6}
do
for k in {3..3}
do
ResultsFile="../../../../Results/UK10K/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessPhasingN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/UK10K/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessPhasingN${NumberOfMarkers[$k]}_{1..50}.txt > $ResultsFile
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionUK10KPhasing"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

for i in {2..6}
do
for k in {3..3}
do
ResultsFile="../../../../Results/UK10K/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessStatPhasingN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/UK10K/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessStatPhasingN${NumberOfMarkers[$k]}_{0..49}.txt > $ResultsFile
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionUK10KLessStatPhasing"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

######################################

#### Rec and Mut Misspecification


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/UK10K/ForwardSims/"${Dir[$i]}"/LLSimsSingleRecHighRecMssel273_4496.201_9N"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/UK10K/ForwardSims/${Dir[$i]}/LLSimsSingleRecHighRecMssel273_4496.201_9_{1..50}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionUK10K9SmallRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/UK10K/ForwardSims/"${Dir[$i]}"/LLSimsSingleRecHighRecMssel273_4496.201_10N"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/UK10K/ForwardSims/${Dir[$i]}/LLSimsSingleRecHighRecMssel273_4496.201_10_{1..50}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionUK10K10SmallRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/UK10K/ForwardSims/"${Dir[$i]}"/LLSimsSingleRecHighRecMssel273_4496.201_11N"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/UK10K/ForwardSims/${Dir[$i]}/LLSimsSingleRecHighRecMssel273_4496.201_11_{1..50}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionUK10K11SmallRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/UK10K/ForwardSims/"${Dir[$i]}"/LLSimsSingleRecHighRecMssel273_4496.201_12N"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/UK10K/ForwardSims/${Dir[$i]}/LLSimsSingleRecHighRecMssel273_4496.201_12_{1..50}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionUK10K12SmallRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


for i in {2..6}
do
Directory="TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/UK10K/ForwardSims/"${Dir[$i]}"/LLSimsSingleRecHighRecMssel273_4496.201_13N"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/UK10K/ForwardSims/${Dir[$i]}/LLSimsSingleRecHighRecMssel273_4496.201_13_{1..50}.txt > $ResultsFile
# DataSummarized="ResultsSelectionInferred/Selection"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionUK10K13SmallRec"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done


######################################

for i in {2..6}
do
# Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/UK10K/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecN"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionUK10K"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
# perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $ResultsFile $DataSummarized ${ActualSelection[$i]}
done
done

sort -nrk2,2 ../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFE.txt | head
