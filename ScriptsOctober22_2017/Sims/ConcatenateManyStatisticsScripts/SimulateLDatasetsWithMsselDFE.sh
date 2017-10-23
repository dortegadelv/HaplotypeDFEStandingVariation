#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

Directory[1]="ConstantPopSizeBoyko/ForwardSims"
Directory[2]="ConstantPopSizeMouse/ForwardSims"
Directory[3]="PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart"
Directory[4]="PopExpansionBoykoPlusPositive/ForwardSims/PositivePart"
Directory[5]="PopExpansionMousePlusPositive/ForwardSims/MousePart"
Directory[6]="PopExpansionMousePlusPositive/ForwardSims/PositivePart"

DemScenario[1]="DemographicHistoryConstant.txt"
DemScenario[2]="DemographicHistoryConstant.txt"
DemScenario[3]="DemHistExpansion.txt"
DemScenario[4]="DemHistExpansion.txt"
DemScenario[5]="DemHistExpansion.txt"
DemScenario[6]="DemHistExpansion.txt"

Ne[1]="20000"
Ne[2]="20000"
Ne[3]="100000"
Ne[4]="100000"
Ne[5]="100000"
Ne[6]="100000"

DemHistNumber=$(( ( ( $SGE_TASK_ID - 1) / 100 ) + 1 ))
SeriesNumber=$(( ( $SGE_TASK_ID - 1 ) % 100 + 1 ))

i=$DemHistNumber

echo "DemHist = $DemHistNumber Series = $SeriesNumber"

Start=$(( ( $SeriesNumber - 1 ) * 10 + 1 ))
End=$(( $SeriesNumber * 10 ))
echo ${Directory[$i]}
CurrentTrajs="../../../Results/"${Directory[$i]}"/ReducedTrajectories50000.txt"
# TTwosFile="../../../Results/TTwos/TTwos"${Directory[$i]}"_"${FourNs[$j]}".txt"
# ExitDir="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/Trajectories"
# DemHist="../../../Scripts/Sims/"${Directory[$i]}"/ImportanceSamplingSims/"${DemScenario[$i]}
# grep 'age' $CurrentFile | awk '{print $6}' > $AlleleAgesFile
# mkdir $ExitDir

DirToCreate="../../../Results/"${Directory[$i]}"/HapLengths/"
mkdir $DirToCreate
for (( k = $Start ; k <= $End ; k++ ))
do

MsselOut="../../../Results/"${Directory[$i]}"/MsselFiles/MsselOut_"$k".txt"
TTwoOutput="../../../Results/"${Directory[$i]}"/MsselFiles/T2_"$k".txt"
ResampledTrajectory="../../../Results/"${Directory[$i]}"/MsselFiles/ResampledTraj"$k".txt"
HapLengths=$DirToCreate"HapLengths"$k".txt"
perl ../../Sims/ConstantPopSize/ForwardSims/SampleTrajectories.pl $CurrentTrajs 10000 $ResampledTrajectory $k ${Ne[$i]}
# Bases = Theta /(4Nu) = 120/(4*10000*1.2e-8) = 250000
Line[1]="../../../Programs/Mssel/mssel3 3 10000 1 2 $ResampledTrajectory 1 -r 100 250000 -t 120 -seeds $k $k $k"
Line[2]="../../../Programs/Mssel/mssel3 3 10000 1 2 $ResampledTrajectory 1 -r 100 250000 -t 120 -seeds $k $k $k"
# Bases = Theta /(4Nu) = 600/(4*50000*1.2e-8) = 250000
Line[3]="../../../Programs/Mssel/mssel3 3 10000 1 2 $ResampledTrajectory 1 -r 500 250000 -t 600 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds $k $k $k"
Line[4]="../../../Programs/Mssel/mssel3 3 10000 1 2 $ResampledTrajectory 1 -r 500 250000 -t 600 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds $k $k $k"
Line[5]="../../../Programs/Mssel/mssel3 3 10000 1 2 $ResampledTrajectory 1 -r 500 250000 -t 600 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds $k $k $k"
Line[6]="../../../Programs/Mssel/mssel3 3 10000 1 2 $ResampledTrajectory 1 -r 500 250000 -t 600 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds $k $k $k"

${Line[$i]} > $MsselOut
perl DistanceToFirstSegregatingSite.pl $MsselOut $HapLengths
rm $MsselOut
rm $ResampledTrajectory
done
# perl GetT2s.pl $MsselOut $TTwoOutput

# TrajFile="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/Trajectories/Traj_"
# ExitT2File="../../../Results/TTwos/"${Directory[$i]}"_"${FourNs[$j]}".txt"
# perl CalculateDistributionOfT2_Trajectory.pl $TrajFile 10000 ${Ne[$i]} $ExitT2File 


