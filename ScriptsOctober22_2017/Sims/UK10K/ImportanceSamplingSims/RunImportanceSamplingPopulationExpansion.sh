#$ -l h_vmem=2g
#$ -cwd

#$ -N IS
#$ -o ../../../../Results/Trash/
#$ -e ../../../../Results/Trash/

Frequency[1]="0.01"
# Frequency[2]="0.02"
Frequency[2]="0.01"
Frequency[3]="0.00926"
Frequency[4]="0.05"
Frequency[5]="0.075"
Frequency[6]="0.01"

Selection[1]="0"
# Selection[2]="-50"
Selection[2]="-5"
# Selection[4]="-5"
# Selection[5]="-1"
Selection[3]="-10"
Selection[4]="-50"
Selection[5]="-100"
Selection[6]="100"

DemHist[1]="DemHistExpansion.txt"
DemHist[3]="AfricanDenserGrid/DemHistAfricanTennessen_2.txt"

FDemHist[1]="DemHistAfricanTennessen.txt"
FDemHist[3]="DemHistAfricanTennessen_2.txt"

# SGE_TASK_ID="601"

Number=$(( ( ( $SGE_TASK_ID - 1) % 100 ) + 1001 ))
SeriesNumber=$(( ( $SGE_TASK_ID - 1 ) / 100 + 1 ))
FrequencyNumber=$(( ( ( $SeriesNumber - 1) / 6 ) + 1 ))
SelectionNumber=$(( ( ( $SeriesNumber - 1) % 6 ) + 1 ))
echo "SeriesNumber = "$SeriesNumber" Number = "$Number" FrequencyNum = "$FrequencyNumber" SelectionNum = "$SelectionNumber
File="ExitFileFreq"${Frequency[$FrequencyNumber]}"Selection"${Selection[$SelectionNumber]}".txt"
echo "$File"
SelectionS=${Selection[$SelectionNumber]}
echo "Selection = "$SelectionS
SelectionCoef1=$( echo "scale=10;$SelectionS / 14600" | bc )
SelectionCoef2=$( echo "scale=10;$SelectionCoef1 * 2" | bc )
File="Exit_"${FDemHist[$FrequencyNumber]}"_"${Frequency[$FrequencyNumber]}"_"${Selection[$SelectionNumber]}"_"$Number".txt"
Seed=$(( $SGE_TASK_ID + 2001))
echo "time ./SlatkinISConstantSizeSISR -A $SelectionCoef2 -a $SelectionCoef1 -f ${Frequency[$FrequencyNumber]} -r 1000 -N 100000 -s $Seed -t 0 -M 0.0000003 -U 0.99999 -Q 0.0 -E 0.0001 -F ExpansionDenserGrid/$File -b ExpansionDenserGrid/Bounds.txt -D ${DemHist[$FrequencyNumber]} -X ExpansionDenserGrid/NewSelectionValues.txt -C 100000"
# g++ -o SlatkinISConstantSizeSISR SlatkinISConstantSizeSISR.cpp prob.cpp -lm
# ./SlatkinISConstantSizeSISR -A $SelectionCoef2 -a $SelectionCoef1 -f ${Frequency[$FrequencyNumber]} -r 20 -N 848000 -s $Seed -t 0 -M 0.0000003 -U 0.99999 -Q 0.0 -E 0.0001 -F $File -b Bounds.txt -D DemographicHistoryAfricanTennessen.txt -C 0.8
time ../../../../Programs/ISProgram/SlatkinISConstantSizeSISR -A $SelectionCoef2 -a $SelectionCoef1 -f ${Frequency[$FrequencyNumber]} -r 1000 -N 346884  -s $Seed -t 0 -M 0.0000003 -U 0.99999 -Q 0.0 -E 0.0001 -F ../../../../Results/UK10K/ImportanceSamplingSims/$File -b ../../ConstantPopSize/ImportanceSamplingSims/Bounds.txt -D DemHistExpansion.txt -X NewSelectionValues.txt -C 100000 -p 7422

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
