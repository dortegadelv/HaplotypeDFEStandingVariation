#$ -l h_rt=24:00:00
#$ -cwd
#$ -A diegoort
#$ -N IS

Frequency[1]="0.005"
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

Number=$(( ( ( $SGE_TASK_ID - 1) % 100 ) + 1001 ))
SeriesNumber=$(( ( $SGE_TASK_ID - 1 ) / 100 + 1 ))
FrequencyNumber=$(( ( ( $SeriesNumber - 1) / 6 ) + 1 ))
SelectionNumber=$(( ( ( $SeriesNumber - 1) % 6 ) + 1 ))

File="ConstantSize/Exit_"${Frequency[$FrequencyNumber]}"_"${Selection[$SelectionNumber]}"_"$Number".txtTrajectory.txt"
BoundsFile="TestT2Bounds.txt"
LTwoFile="ConstantSize/L2_"${Frequency[$FrequencyNumber]}"_"${Selection[$SelectionNumber]}"_"$Number".txt"

perl CalculateDistributionOfT2.pl $File $BoundsFile $LTwoFile
