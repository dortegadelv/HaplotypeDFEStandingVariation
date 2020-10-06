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

for i in {1..11}
do
for j in {1..5}
do
echo ${Directory[$i]}
CurrentFile="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/ReducedTrajectories10000.txt"
AlleleAgesFile="../../../Results/AlleleAges/Ages"${Directory[$i]}"_"${FourNs[$j]}".txt"
grep 'age' $CurrentFile | awk '{print $6}' > $AlleleAgesFile
done
done

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_25"
FourNs[3]="4Ns_50"
FourNs[4]="4Ns_-25"
FourNs[5]="4Ns_-50"

for i in {12..12}
do
for j in {1..5}
do
echo ${Directory[$i]}
CurrentFile="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/ReducedTrajectories10000.txt"
AlleleAgesFile="../../../Results/AlleleAges/Ages"${Directory[$i]}"_"${FourNs[$j]}".txt"
grep 'age' $CurrentFile | awk '{print $6}' > $AlleleAgesFile
done
done

