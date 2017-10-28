#### Check alternative weights and ESS

cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0.txtWeightYearsTest2.txt

cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_100_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_100.txtWeightYears.txt

cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_-100_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_-100.txtWeightYears.txt

cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_0_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_0.txtWeightYears.txt

cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_100_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_100.txtWeightYears.txt

cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_-100_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_-100.txtWeightYears.txt

cat ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_200_{1001..1100}.txtWeightYears.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_200.txtWeightYears.txt

###### HighPop Test

time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_100.txtWeightYears.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/SumDistancesFile10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniSDHighPop10000.txt

awk '{print $1}' ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop10000.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/FirstColumnHighPop.txt

paste -d "\t" ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/FirstColumnHighPop.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/TableToTestHighPop.txt

## Test 2
time perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateHapLengthWeight.pl ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_100.txtWeightYears.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/SumDistancesFile10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop_100_10000.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniSDHighPop_100_10000.txt

awk '{print $1}' ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop_100_10000.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/FirstColumnHighPop.txt

paste -d "\t" ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/FirstColumnHighPop.txt ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/NewMiniExpHighPop_100_10000.txt > ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile1/TableToTestHighPop.txt

