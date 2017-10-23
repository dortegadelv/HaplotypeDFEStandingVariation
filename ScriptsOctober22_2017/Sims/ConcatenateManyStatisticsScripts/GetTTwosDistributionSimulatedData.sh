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
Directory[12]="UK10K"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_50"
FourNs[3]="4Ns_100"
FourNs[4]="4Ns_-50"
FourNs[5]="4Ns_-100"

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
Ne[12]="346884"


for i in {12..12}
do
for j in {1..5}
do
TTwoOutput="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/MsselFiles/T2_"
ExitTTwoDistribution="../../../Results/TTwos/Sim"${Directory[$i]}"_"${FourNs[$j]}".txt"
echo $TTwoOutput
echo $ExitTTwoDistribution
perl CalculateDistributionOfT2SimData.pl $TTwoOutput ${Ne[$i]} 1000 $ExitTTwoDistribution

done
done
