#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=00:20:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


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

DemScenario[1]="DemHistBottleneck.txt"
DemScenario[2]="DemHistBottleneck.txt"
DemScenario[3]="DemographicHistoryConstant.txt"
DemScenario[4]="DemographicHistoryConstant.txt"
DemScenario[5]="DemHistBottleneck.txt"
DemScenario[6]="DemHistBottleneck.txt"
DemScenario[7]="DemHistExpansion.txt"
DemScenario[8]="DemHistExpansion.txt"
DemScenario[9]="DemUK10KHistBottleneck.txt"
DemScenario[10]="DemHistBottleneck.txt"
DemScenario[11]="DemographicHistoryConstant.txt"
DemScenario[12]="DemHistExpansion.txt"

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

DemHistNumber=$(( ( ( $SLURM_ARRAY_TASK_ID - 1) / 50 ) + 1 ))
FourNsNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 -  ( ( $DemHistNumber - 1 ) * 50 ) ) / 10 + 1 ))
SeriesNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 10 + 1 ))

i=$DemHistNumber

j=$FourNsNumber

echo "DemHist = $DemHistNumber FourNs = $FourNsNumber Series = $SeriesNumber"

Start=$(( ( $SeriesNumber - 1 ) * 10 + 1 ))
End=$(( $SeriesNumber * 10 ))
echo ${Directory[$i]}
CurrentTrajs="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/ReducedTrajectories10000.txt"
# TTwosFile="../../../Results/TTwos/TTwos"${Directory[$i]}"_"${FourNs[$j]}".txt"
# ExitDir="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/Trajectories"
# DemHist="../../../Scripts/Sims/"${Directory[$i]}"/ImportanceSamplingSims/"${DemScenario[$i]}
# grep 'age' $CurrentFile | awk '{print $6}' > $AlleleAgesFile
# mkdir $ExitDir

DirToCreate="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/HapLengths/"
mkdir $DirToCreate
for (( k = $Start ; k <= $End ; k++ ))
do

MsselOut="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/MsselFiles/MsselOutLess_"$k".txt"
TTwoOutput="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/MsselFiles/T2Less_"$k".txt"
ResampledTrajectory="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/MsselFiles/ResampledTraj"$k".txt"
HapLengths=$DirToCreate"HapLengthsLessDeleteSingletons"$k".txt"
perl ../../Sims/ConstantPopSize/ForwardSims/SampleTrajectories.pl $CurrentTrajs 300 $ResampledTrajectory $k ${Ne[$i]}
# Bases = Theta /(4Nu) = 120/(4*5000*1.2e-8) = 500000
Line[1]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 500000 -r 200 999999 -t 240 -eN 0.0 1.0 -eN 0.25 0.2 -eN 0.26 1.0 -seeds $k $k $k"
Line[2]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 500000 -r 200 999999 -t 240 -eN 0.0 1.0 -eN 0.25 0.2 -eN 0.26 1.0 -seeds $k $k $k"
# Bases = Theta /(4Nu) = 120/(4*10000*1.2e-8) = 250000
Line[3]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 250000 -r 200 499999 -t 240 -seeds $k $k $k"
Line[4]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 250000 -r 200 499999 -t 240 -seeds $k $k $k"
Line[11]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 250000 -r 200 499999 -t 240 -seeds $k $k $k"
# Bases = Theta /(4Nu) = 120/(4*5000*1.2e-8) = 500000
Line[5]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 500000 -r 200 999999 -t 240 -eN 0.0 1.0 -eN 0.1 0.2 -eN 0.11 1.0 -seeds $k $k $k"
Line[6]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 500000 -r 200 999999 -t 240 -eN 0.0 1.0 -eN 0.1 0.2 -eN 0.11 1.0 -seeds $k $k $k"
# Bases = Theta /(4Nu) = 600/(4*50000*1.2e-8) = 250000
Line[7]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 250000 -r 1000 499999 -t 1200 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds $k $k $k"
Line[8]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 250000 -r 1000 499999 -t 1200 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds $k $k $k"
# Bases = Theta /(4Nu) = 120/(4*5000*1.2e-8) = 500000
Line[9]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 500000 -r 200 999999 -t 240 -eN 0.0 1.0 -eN 0.005 0.5 -eN 0.015 1.0 -seeds $k $k $k"
Line[10]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 500000 -r 200 999999 -t 240 -eN 0.0 1.0 -eN 0.005 0.5 -eN 0.015 1.0 -seeds $k $k $k"
Line[12]="../../../Programs/Mssel/mssel3 41 300 1 40 $ResampledTrajectory 250000 -r 0.0 250000 -t 16968.9 -eN 0.0 1.0 -eN 0.0001017 0.0066121 -eN 0.0006409 0.0051756 -eN 0.0014188 0.0402604 -eN 0.0041171 0.0203048 -seeds $k $k $k"

${Line[$i]} > $MsselOut
perl DistanceToFirstSegregatingSiteMultiSequence_BothSides.pl $MsselOut $HapLengths 1 40
# rm $MsselOut
rm $ResampledTrajectory
done
# perl GetT2s.pl $MsselOut $TTwoOutput

# TrajFile="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/Trajectories/Traj_"
# ExitT2File="../../../Results/TTwos/"${Directory[$i]}"_"${FourNs[$j]}".txt"
# perl CalculateDistributionOfT2_Trajectory.pl $TrajFile 10000 ${Ne[$i]} $ExitT2File 


