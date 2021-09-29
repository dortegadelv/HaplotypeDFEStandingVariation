#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


Directory[1]="AncientBottleneck"
Directory[2]="ConstantPopSize"
Directory[3]="PopExpansion"
Directory[4]="UK10K"

if [ $SGE_TASK_ID -le "15" ]
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
DemScenario[2]="DemographicHistoryConstant.txt"
DemScenario[3]="DemHistExpansion.txt"
DemScenario[4]="DemHistExpansion.txt"

Ne[1]="10000"
Ne[2]="20000"
Ne[3]="100000"
Ne[4]="164462"

DemHistNumber=$(( ( ( $SLURM_ARRAY_TASK_ID - 1) / 5 ) + 1 ))
FourNsNumber=$(( ( ( $SLURM_ARRAY_TASK_ID - 1) % 5 ) + 1 ))

i=$DemHistNumber

j=$FourNsNumber

echo ${Directory[$i]}
CurrentFile="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/ReducedTrajectories10000.txt"
TTwosFile="../../../Results/TTwos/TTwos"${Directory[$i]}"_"${FourNs[$j]}".txt"
ExitDir="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/Trajectories"
if [ $SLURM_ARRAY_TASK_ID -le "15" ]
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




