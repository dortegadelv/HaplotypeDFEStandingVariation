
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
# Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/AncientBottleneck/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/AncientBottleneck/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFile
# ResultsFile="../../../../Results/PopExpansion/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
ResultsFileRight="../../../../Results/AncientBottleneck/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessRightN"${NumberOfMarkers[$k]}".txt"
cat ../../../../Results/AncientBottleneck/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessRightN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFileRight

ResultsFileDown="../../../../Results/AncientBottleneck/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessDown50N"${NumberOfMarkers[$k]}".txt"
ResultsFileRightDown="../../../../Results/AncientBottleneck/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessRightDown50N"${NumberOfMarkers[$k]}".txt"
ResultsFileTwoUp="../../../../Results/AncientBottleneck/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessUp50N"${NumberOfMarkers[$k]}".txt"
ResultsFileRightTwoUp="../../../../Results/AncientBottleneck/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessRightUp50N"${NumberOfMarkers[$k]}".txt"
ResultsFileRight="../../../../Results/AncientBottleneck/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessRightN"${NumberOfMarkers[$k]}".txt"

head -n50 $ResultsFile > $ResultsFileTwoUp
tail -n50 $ResultsFile > $ResultsFileDown
head -n50 $ResultsFileRight > $ResultsFileRightTwoUp
tail -n50 $ResultsFileRight > $ResultsFileRightDown

# ResultsFileRight="../../../../Results/PopExpansion/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessRightN"${NumberOfMarkers[$k]}".txt"
# cat ../../../../Results/PopExpansion/ForwardSims/${Dir[$i]}/HapLengths/ExitFileNoRecLessRightN${NumberOfMarkers[$k]}_{1..100}.txt > $ResultsFileRight
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionAncientBottleneck"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl ../../ConstantPopSize/ForwardSims/GetMax4NsValueFromTableBothSides.pl $ResultsFile $ResultsFileRight $DataSummarized ${ActualSelection[$i]}

done
done



for i in {2..6}
do
# Directory="/u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/run."$i"/"
for k in {3..3}
do
ResultsFile="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessN"${NumberOfMarkers[$k]}".txt"
ResultsFileRight="../../../../Results/ConstantPopSize/ForwardSims/"${Dir[$i]}"/HapLengths/ExitFileNoRecLessRightN"${NumberOfMarkers[$k]}".txt"
DataSummarized="../../../../Results/ResultsSelectionInferred/SelectionConstantPopSize"${Selection[$i]}"_N"${NumberOfMarkers[$k]}".txt"
perl GetMax4NsValueFromTableBothSides.pl $ResultsFile $ResultsFileRight $DataSummarized ${ActualSelection[$i]}
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

