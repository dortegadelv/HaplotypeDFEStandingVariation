#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

Start=$(( ( $SGE_TASK_ID - 1 ) * 10 + 1 ))
End=$(( ( $SGE_TASK_ID ) * 10 ))

# Directory="../../../../Results/ConstantPopSizeBoyko/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/"
# ResultsFile="../../../../Results/ConstantPopSizeBoyko/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/HapLengths/ExitFileNoRecN"${NumberOfMarkers[$k]}".txt"
# rm $ResultsFile
for (( i = $Start ; i <= $End ; i++ ))
do
HapFile="../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/HapLengths/HapLengths"$i".txt"
ResultsFile="../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/HapLengths/ExitFileNoRecN"$i".txt"
rm $ResultsFile

perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 ../../../../Results/PopExpansionBoykoPlusPositive/ImportanceSampling/DFETableToTest.txt ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile
done


