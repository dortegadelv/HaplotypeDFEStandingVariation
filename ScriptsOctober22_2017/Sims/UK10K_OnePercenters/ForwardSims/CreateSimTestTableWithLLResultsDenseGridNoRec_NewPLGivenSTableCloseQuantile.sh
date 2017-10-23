#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="10000"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_-50"
FourNs[3]="4Ns_-100"
FourNs[4]="4Ns_50"
FourNs[5]="4Ns_100"

Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengths/HapLength"

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSCloseQuantile.pl $HapFilePrefix 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile ../../../../Data/LeftBpRecRatePerVariant.txt ../../../../Data/RightBpRecRatePerVariant.txt 741 ../../../../Data/VariantNumberToInclude.txt ../../UK10K_PointTwoPercenters/ForwardSims/MissenseOnePercent.txt 551895

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSCloseQuantile.pl ../../../../Data/Plink/HapLengths/HapLengthSynonymous 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt ../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataSyn.txt ../../../../Data/LeftBpRecRatePerVariantSynonymous.txt ../../../../Data/RightBpRecRatePerVariantSynonymous.txt 531 ../../../../Data/VariantNumberToIncludeSynonymous.txt ../../UK10K_PointTwoPercenters/ForwardSims/MissenseOnePercent.txt 551895


