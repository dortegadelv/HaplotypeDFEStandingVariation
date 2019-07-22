#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/RecentBottleneck/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/RecentBottleneck/ForwardSims/4Ns_0/Trash


NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_-50"
FourNs[3]="4Ns_-100"
FourNs[4]="4Ns_50"
FourNs[5]="4Ns_100"

Directory="../../../../Results/RecentBottleneck/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/"
for k in {3..3}
do
ResultsFile="../../../../Results/RecentBottleneck/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/HapLengths/ExitFileNoRecN"${NumberOfMarkers[$k]}".txt"
rm $ResultsFile
for j in {1..100}
do
HapFile="../../../../Results/RecentBottleneck/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/HapLengths/HapLengths"$j".txt"
perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 500000 ../../../../Results/RecentBottleneck/ImportanceSamplingSims/TableToTest.txt ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile
done
done





