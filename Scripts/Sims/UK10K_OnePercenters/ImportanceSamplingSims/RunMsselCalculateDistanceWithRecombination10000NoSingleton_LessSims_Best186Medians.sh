#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

FileNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 1 + 1 ))
Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 1 + 1 ))

File="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMssel_0.01_0_"$FileNumber".txtTrajectory.txt"
ExitMssel="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/TrajParTrajPartMsselOut_"$FileNumber"_"$Repetition".txt"

# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

StartSeedNumber=$(( ( $FileNumber * 10 + $Repetition) * 1000 ))

for j in {1..21}
do
DistancesFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$j"/DistancesFileWithRec10000_"$FileNumber"_"$Repetition".txt"
# rm $DistancesFile
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
done

RecRate[1]="0"
RecRate[2]="238.203"
RecRate[3]="616.605"
RecRate[4]="975.415"
RecRate[5]="1343.438"
RecRate[6]="1705.498"
RecRate[7]="2351.484"
RecRate[8]="2794.042"
RecRate[9]="3127.865"
RecRate[10]="3586.951"
RecRate[11]="4222.188"
RecRate[12]="4951.6"
RecRate[13]="5744.157"
RecRate[14]="6491.999"
RecRate[15]="7306.68"
RecRate[16]="8671.667"
RecRate[17]="9668.756"
RecRate[18]="10579.003"
RecRate[19]="12717.045"
RecRate[20]="16163.458"
RecRate[21]="28635.585"

for i in {801..1000}
do
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 102365
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency
SeedNumber=$(( $StartSeedNumber + $i  ))

for j in {1..21}
do
MsselFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$j"/MsselFileOut_"$FileNumber"_"$Repetition".txt"
DistancesFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$j"/DistancesFileWithRec10000_"$FileNumber"_"$Repetition".txt"

rm $MsselFile

if (( $(echo "$LastFrequency == 0.0" |bc -l) ))
then
echo "NO"
# for k in {1..1000}
# do

../../../../Programs/Mssel/mssel3 73 100 1 72 $ExitMssel 1 -r ${RecRate[$j]} 250000 -t 7677.375 -eN 0.0 1.0 -eN 0.0001221 0.0063791 -eN 0.0007082 0.0057246 -eN 0.0015679 0.0444879 -eN 0.0045499 0.0224393 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
# done
time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequenceFractions.pl $MsselFile $DistancesFile 1 72 0 0 25 250000 TestT2Bounds.txt
else
Bounds=$( wc -l TestT2Bounds.txt | awk '{print $1}' )
Bounds=$(( $Bounds - 1 ))
Line=""
l=0
while [ "$l" -le "$Bounds" ]; do
  echo "$l"
  l=$(($l + 1))
Line=$Line"0	"
done

echo $Line >> $DistancesFile
fi
done
done
