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
ResultsFile="../../../../Results/UK10K_PointTwoPercenters/ForwardSims/LLData.txt"

HapFilePrefix="../../../../Data/Plink/HapLengthsPointFive/HapLengthPoint5"

perl CalculatePLengthGivenSQuantile.pl $HapFilePrefix 250000 ../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile ../../../../Data/LeftBpRecRatePerVariantPointFive.txt ../../../../Data/RightBpRecRatePerVariantPointFive.txt 5952 ../../../../Data/VariantNumberPointFiveToInclude.txt MissensePointTwoPercent.txt 790955



