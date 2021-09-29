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
RecRate[2]="225.389"
RecRate[3]="583.433"
RecRate[4]="922.939"
RecRate[5]="1271.164"
RecRate[6]="1613.746"
RecRate[7]="2224.979"
RecRate[8]="2643.729"
RecRate[9]="2959.593"
RecRate[10]="3393.982"
RecRate[11]="3995.044"
RecRate[12]="4685.215"
RecRate[13]="5435.134"
RecRate[14]="6142.744"
RecRate[15]="6913.597"
RecRate[16]="8205.151"
RecRate[17]="9148.599"
RecRate[18]="10009.877"
RecRate[19]="12032.897"
RecRate[20]="15293.901"
RecRate[21]="27095.057"

for i in {501..1000}
do
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 96858
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

../../../../Programs/Mssel/mssel3 73 100 1 72 $ExitMssel 1 -r ${RecRate[$j]} 250000 -t 7264.35 -eN 0.0 1.0 -eN 0.0001316 0.0056061 -eN 0.0007485 0.0060501 -eN 0.0016571 0.0470173 -eN 0.0048086 0.0237151 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
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
