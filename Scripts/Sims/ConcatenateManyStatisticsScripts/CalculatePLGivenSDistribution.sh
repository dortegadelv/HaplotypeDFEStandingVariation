Directory[1]="AncientBottleneck"
Directory[2]="AncientBottleneckPointFivePercent"
Directory[3]="ConstantPopSize"
Directory[4]="ConstantPopSizePointFivePercent"
Directory[5]="MediumBottleneck"
Directory[6]="MediumBottleneckPointFivePercent"
Directory[7]="PopExpansion"
Directory[8]="PopExpansionPointFivePercent"
Directory[9]="RecentBottleneck"
Directory[10]="RecentBottleneckPointFivePercent"
Directory[11]="ConstantPopSizePopFrequency"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_50"
FourNs[3]="4Ns_100"
FourNs[4]="4Ns_-50"
FourNs[5]="4Ns_-100"

DemScenario[1]="DemHistBottleneck.txt"
DemScenario[2]="DemHistBottleneck.txt"
DemScenario[3]="DemographicHistoryConstant.txt"
DemScenario[4]="DemographicHistoryConstant.txt"
DemScenario[5]="DemHistBottleneck.txt"
DemScenario[6]="DemHistBottleneck.txt"
DemScenario[7]="DemHistExpansion.txt"
DemScenario[8]="DemHistExpansion.txt"
DemScenario[9]="DemHistBottleneck.txt"
DemScenario[10]="DemHistBottleneck.txt"
DemScenario[11]="DemographicHistoryConstant.txt"

Ne[1]="10000"
Ne[2]="10000"
Ne[3]="20000"
Ne[4]="20000"
Ne[5]="10000"
Ne[6]="10000"
Ne[7]="100000"
Ne[8]="100000"
Ne[9]="10000"
Ne[10]="10000"
Ne[11]="20000"

rm ../../../Results/DistributionOfL/DistributionOfL.txt
touch ../../../Results/DistributionOfL/DistributionOfL.txt
# File="../../../Results/"${Directory[]}
for (( i = 7 ; i <= 7 ; i++ ))
do
for (( j = 1 ; j <= 5 ; j++ ))
do
echo $j
Files="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/HapLengths/HapLengths"
perl CalculatePLGivenSDistribution.pl ../../../Results/DistributionOfL/DistributionOfL.txt 1 100 $Files
done
done
