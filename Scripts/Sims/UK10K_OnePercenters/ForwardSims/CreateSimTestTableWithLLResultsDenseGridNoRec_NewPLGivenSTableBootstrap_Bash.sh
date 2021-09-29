for SLURM_ARRAY_TASK_ID in {1..100}
do


Directory="../../../../Results/UK10K/ForwardSims/"${FourNs[$SLURM_ARRAY_TASK_ID]}"/"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLData.txt"
BootstrapExitFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataBootstrap"$SLURM_ARRAY_TASK_ID".txt"
HapFilePrefix="../../../../Data/Plink/HapLengths/HapLengthOnlyCpG"

perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileBootstrapCloseQuantileNew.pl $HapFilePrefix 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile ../../../../Data/LeftBpRecRatePerVariantNoCpG.txt ../../../../Data/RightBpRecRatePerVariantNoCpG.txt 275 ../../../../Data/Plink/CpGMisOnePercentNumberPositionsVar.txt ../../UK10K_PointTwoPercenters/ForwardSims/MissenseOnePercentNoCpG.txt 565630 $BootstrapExitFile

echo $SLURM_ARRAY_TASK_ID
HapFilePrefix="../../../../Data/Plink/HapLengths/HapLengthSynonymousNotCpG"
ResultsFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataSyn.txt"
BootstrapExitFile="../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataSynBootstrap"$SLURM_ARRAY_TASK_ID".txt"


perl ../../UK10K_PointTwoPercenters/ForwardSims/CalculatePLengthGivenSQuantileBootstrapCloseQuantileNew.pl $HapFilePrefix 250000 ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile ../../../../Data/LeftBpRecRatePerVariantNoCpGSynonymous.txt ../../../../Data/RightBpRecRatePerVariantNoCpGSynonymous.txt 142 ../../../../Data/Plink/CpGSynOnePercentNumberPositionsVar.txt ../../UK10K_PointTwoPercenters/ForwardSims/MissenseOnePercentNoCpG.txt 565630 $BootstrapExitFile

done
