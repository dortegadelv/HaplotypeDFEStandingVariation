rm FinalStats.txt

wc -l ../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
wc -l ../../../Results/PopExpansion/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
wc -l ../../../Results/AncientBottleneck/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
wc -l ../../../Results/PopExpansion100000GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
wc -l ../../../Results/PopExpansion10000GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
wc -l ../../../Results/PopExpansion1000GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
wc -l ../../../Results/PopExpansion100GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
wc -l ../../../Results/PopExpansionCEU/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
wc -l ../../../Results/PopExpansionYRI/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
wc -l ../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0.txtWeightYears.txt

ls -l ../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
ls -l ../../../Results/PopExpansion/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
ls -l ../../../Results/AncientBottleneck/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
ls -l ../../../Results/PopExpansion100000GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
ls -l ../../../Results/PopExpansion10000GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
ls -l ../../../Results/PopExpansion1000GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
ls -l ../../../Results/PopExpansion100GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
ls -l ../../../Results/PopExpansionCEU/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
ls -l ../../../Results/PopExpansionYRI/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
ls -l ../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0.txtWeightYears.txt


perl ../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
perl ../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../Results/PopExpansion/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
perl ../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../Results/AncientBottleneck/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
perl ../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../Results/PopExpansion100000GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
perl ../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../Results/PopExpansion10000GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
perl ../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../Results/PopExpansion1000GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
perl ../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../Results/PopExpansion100GensAgo/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
perl ../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../Results/PopExpansionCEU/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
perl ../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../Results/PopExpansionYRI/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
perl ../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0.txtWeightYears.txt

