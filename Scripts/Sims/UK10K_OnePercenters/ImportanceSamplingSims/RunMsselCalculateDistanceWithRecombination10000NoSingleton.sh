#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=48:00:00
#SBATCH --partition=jnovembre
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
RecRate[2]="191.352"
RecRate[3]="495.326"
RecRate[4]="783.562"
RecRate[5]="1079.2"
RecRate[6]="1370.047"
RecRate[7]="1888.974"
RecRate[8]="2244.487"
RecRate[9]="2512.65"
RecRate[10]="2881.44"
RecRate[11]="3391.733"
RecRate[12]="3977.678"
RecRate[13]="4614.348"
RecRate[14]="5215.098"
RecRate[15]="5869.541"
RecRate[16]="6966.051"
RecRate[17]="7767.025"
RecRate[18]="8498.236"
RecRate[19]="10215.751"
RecRate[20]="12984.294"
RecRate[21]="23003.3"

for i in {801..1000}
do
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 82231
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

../../../../Programs/Mssel/mssel3 73 100 1 72 $ExitMssel 1 -r ${RecRate[$j]} 250000 -t 6167.325 -eN 0.0 1.0 -eN 0.0001490 0.0077465 -eN 0.0008817 0.0071263 -eN 0.0019518 0.0553806 -eN 0.0056639 0.0279335 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
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
