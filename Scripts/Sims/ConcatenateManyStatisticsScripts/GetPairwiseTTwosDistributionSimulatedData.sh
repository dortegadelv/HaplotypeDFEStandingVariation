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


for i in {3..3}
do
for j in {1..1}
do
CurrentTrajs="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/ReducedTrajectories10000.txt"
ExitT2File="../../../Results/TTwos/"${Directory[$i]}"_"${FourNs[$j]}".txt"
ExitTreeFile="../../../Results/TTwos/Tree"${Directory[$i]}"_"${FourNs[$j]}".txt"

TreesOutput="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/MsselFiles/T2_"
ExitTTwoDistribution="../../../Results/TTwos/Sim"${Directory[$i]}"_"${FourNs[$j]}".txt"
echo $TTwoOutput
echo $ExitTTwoDistribution

Line[1]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -eN 0.0 1.0 -eN 0.25 0.2 -eN 0.26 1.0 -seeds 1 1 1 -T"
Line[2]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -eN 0.0 1.0 -eN 0.25 0.2 -eN 0.26 1.0 -seeds 1 1 1 -T"
# Bases = Theta /(4Nu) = 120/(4*10000*1.2e-8) = 250000
Line[3]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -seeds 1 1 1 -T"
Line[4]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -seeds 1 1 1 -T"
Line[11]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -seeds 1 1 1 -T"
# Bases = Theta /(4Nu) = 120/(4*5000*1.2e-8) = 500000
Line[5]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -eN 0.0 1.0 -eN 0.1 0.2 -eN 0.11 1.0 -seeds 1 1 1 -T"
Line[6]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -eN 0.0 1.0 -eN 0.1 0.2 -eN 0.11 1.0 -seeds 1 1 1 -T"
# Bases = Theta /(4Nu) = 600/(4*50000*1.2e-8) = 250000
Line[7]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds 1 1 1 -T"
Line[8]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds 1 1 1 -T"
# Bases = Theta /(4Nu) = 120/(4*5000*1.2e-8) = 500000
Line[9]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -eN 0.0 1.0 -eN 0.005 0.5 -eN 0.015 1.0 -seeds 1 1 1 -T"
Line[10]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -eN 0.0 1.0 -eN 0.005 0.5 -eN 0.015 1.0 -seeds 1 1 1 -T"
Line[12]="../../../Programs/Mssel/mssel3 41 10000 1 40 $CurrentTrajs 1 -r 0 2 -t 1 -T -seeds 1 1 1 -eN 0.0000867 0.1291653 -eN 0.0001768 0.0421744 -eN 0.0013261 0.0107298 -eN 0.0029405 0.0834516 -eN 0.0085331 0.0420890 -T"

${Line[i]} | grep '(' > $ExitTreeFile


done
done
