#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=02:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


Frequency[1]="0.00005"
# Frequency[2]="0.02"
Frequency[2]="0.01"
Frequency[3]="0.03"
Frequency[4]="0.05"
Frequency[5]="0.075"
Frequency[6]="0.01"

Selection[1]="0"
# Selection[2]="-50"
Selection[2]="-1"
# Selection[4]="-5"
# Selection[5]="-1"
Selection[3]="-5"
Selection[4]="-10"
Selection[5]="-50"
Selection[6]="-100"

# SGE_TASK_ID="601"

Number=$(( ( ( $SLURM_ARRAY_TASK_ID - 1) % 100 ) + 1001 ))
SeriesNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 100 + 1 ))
FrequencyNumber=$(( ( ( $SeriesNumber - 1) / 6 ) + 1 ))
SelectionNumber=$(( ( ( $SeriesNumber - 1) % 6 ) + 1 ))
echo "SeriesNumber = "$SeriesNumber" Number = "$Number" FrequencyNum = "$FrequencyNumber" SelectionNum = "$SelectionNumber
File="ExitFileFreq"${Frequency[$FrequencyNumber]}"Selection"${Selection[$SelectionNumber]}".txt"
echo "$File"
SelectionS=${Selection[$SelectionNumber]}
echo "Selection = "$SelectionS
SelectionCoef1=$( echo "scale=10;$SelectionS / 40000" | bc )
SelectionCoef2=$( echo "scale=10;$SelectionCoef1 * 2" | bc )
File="Exit_"${Frequency[$FrequencyNumber]}"_"${Selection[$SelectionNumber]}"_"$Number".txt"
Seed=$(( $SLURM_ARRAY_TASK_ID + 2001))
echo "./SlatkinISConstantSizeF -A $SelectionCoef2 -a $SelectionCoef1 -f ${Frequency[$FrequencyNumber]} -r 2000 -N 20000 -s $Seed -t 0 -M 0.0000003 -U 0.99999 -Q 0.0 -E 0.0001 -F $SCRATCH/$File -S 2 0.0 0.0 -D DemographicHistoryAfricanTennessen.txt"
# g++ -o SlatkinISConstantSizeSISR SlatkinISConstantSizeSISR.cpp prob.cpp -lm
# ./SlatkinISConstantSizeSISR -A $SelectionCoef2 -a $SelectionCoef1 -f ${Frequency[$FrequencyNumber]} -r 20 -N 848000 -s $Seed -t 0 -M 0.0000003 -U 0.99999 -Q 0.0 -E 0.0001 -F $File -b Bounds.txt -D DemographicHistoryAfricanTennessen.txt -C 0.8
## from the line below: t M and U are useless parameters. Q gives a F values for using the Balding-Nicholls model. E is useless. C is useless.  
time ../../../../Programs/ISProgram/SlatkinISConstantSizeSISR -A $SelectionCoef2 -a $SelectionCoef1 -f ${Frequency[$FrequencyNumber]} -r 1000 -N 20000 -s $Seed -F ../../../../Results/ConstantPopSize/ImportanceSamplingSims/$File -b Bounds.txt -D DemographicHistoryConstant.txt -X NewSelectionValues.txt -p 4000

#### NOTE! All that is below should be documented
# WeightFile=$File"WeightYears.txt"
# TrajFile=$File"Trajectory.txt"
# MSSELTrajFile=$File"RHTrajectory.txt"
# MSSELExit=$File"MSSEL_exit.txt"
# MSSELStep=$File"Step_MSSEL_exit.txt"
# Ne="424000"
# Theta=$( echo "scale=10; 4 * $Ne * 0.000000012 * 400000 " | bc )
# Rho=$( echo "scale=10; 4 * $Ne * 0.00000001 * 400000 " | bc )
# MSSeed1=$(( $Seed + 14001))
# MSSeed2=$(( $Seed + 14002))
# MSSeed3=$(( $Seed + 14003))
# python /u/home/d/diegoort/project/PurifyingSelectionProject/TestAges/TennessenDemographies/ChangeSelectionForAncestralPopSizes/mssel/ExampleTrajectories/Trajs2stepftnFormat.py $Ne $SelectionCoef1 2000 $SCRATCH/$TrajFile > $SCRATCH/$MSSELTrajFile
# /u/home/d/diegoort/project/PurifyingSelectionProject/TestAges/TennessenDemographies/ChangeSelectionForAncestralPopSizes/mssel/ExampleTrajectories/mssel_sims/src/stepftn < $SCRATCH/$MSSELTrajFile > $SCRATCH/$MSSELStep
# /u/home/d/diegoort/project/PurifyingSelectionProject/TestAges/TennessenDemographies/ChangeSelectionForAncestralPopSizes/mssel/ExampleTrajectories/mssel_sims/src/mssel3 40 2000 0 40 $SCRATCH/$MSSELStep 1 -t $Theta -r $Rho 400000 -seeds $MSSeed1 $MSSeed2 $MSSeed3 -eG 0.0 0.016475022 -eN 0.000120873 0.034136873 -eN 0.003490568 0.017240607 > $SCRATCH/AfricanTennessen/$MSSELExit
# cp $SCRATCH/$WeightFile AfricanTennessen/$WeightFile
