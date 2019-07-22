
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

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_50"
FourNs[3]="4Ns_100"
FourNs[4]="4Ns_-50"
FourNs[5]="4Ns_-100"

for i in {1..10}
do

for j in {1..5}
do
SimFile="../../../Results/TTwos/Sim"${Directory[$i]}"_"${FourNs[$j]}".txt"
CalculationFile="../../../Results/TTwos/"${Directory[$i]}"_"${FourNs[$j]}".txt"
echo ${Directory[$i]}"_"${FourNs[$j]}
perl GetExpectedValueSDT2.pl $SimFile
perl GetExpectedValueSDT2.pl $CalculationFile
cat $SimFile |  awk '{ sum+=$2} END {print sum}'
done
done

