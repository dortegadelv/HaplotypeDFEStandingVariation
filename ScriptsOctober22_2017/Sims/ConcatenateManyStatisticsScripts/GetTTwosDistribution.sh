#$ -l h_vmem=4g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash


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

if [ $SGE_TASK_ID -le "55" ]
then
FourNs[1]="4Ns_0"
FourNs[2]="4Ns_50"
FourNs[3]="4Ns_100"
FourNs[4]="4Ns_-50"
FourNs[5]="4Ns_-100"
else
FourNs[1]="4Ns_0"
FourNs[2]="4Ns_25"
FourNs[3]="4Ns_50"
FourNs[4]="4Ns_-25"
FourNs[5]="4Ns_-50"

fi

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
Ne[11]=20000
Ne[12]="220758"

DemHistNumber=$(( ( ( $SGE_TASK_ID - 1) / 5 ) + 1 ))
FourNsNumber=$(( ( ( $SGE_TASK_ID - 1) % 5 ) + 1 ))

i=$DemHistNumber

j=$FourNsNumber

echo ${Directory[$i]}
CurrentFile="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/ReducedTrajectories10000.txt"
TTwosFile="../../../Results/TTwos/TTwos"${Directory[$i]}"_"${FourNs[$j]}".txt"
ExitDir="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/Trajectories"
if [ $SGE_TASK_ID -le "55" ]
then
DemHist="../../../Scripts/Sims/"${Directory[$i]}"/ImportanceSamplingSims/"${DemScenario[$i]}
else
DemHist="../../../Scripts/Sims/"${Directory[$i]}"_OnePercenters/ImportanceSamplingSims/"${DemScenario[$i]}
fi
# grep 'age' $CurrentFile | awk '{print $6}' > $AlleleAgesFile
mkdir $ExitDir
for k in {1..1}
do
perl SampleTrajectories.pl $CurrentFile 10000 $ExitDir $k $DemHist
done

TrajFile="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/Trajectories/Traj_"
ExitT2File="../../../Results/TTwos/"${Directory[$i]}"_"${FourNs[$j]}".txt"
perl CalculateDistributionOfT2_Trajectory.pl $TrajFile 10000 ${Ne[$i]} $ExitT2File 


