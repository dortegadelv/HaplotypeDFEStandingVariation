#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=02:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

FileNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 10 + 1 ))
Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 10 + 1 ))

File="../../../../Results/ConstantPopSize/ImportanceSamplingSims/ExitMssel_0.01_0_"$FileNumber".txtTrajectory.txt"
ExitMssel="../../../../Results/ConstantPopSize/ImportanceSamplingSims/TrajParTrajPartMsselOut_50Windows_"$FileNumber"_"$Repetition".txt"
MsselFile="../../../../Results/ConstantPopSize/ImportanceSamplingSims/MsselFileOut_50Windows_"$FileNumber"_"$Repetition".txt"
DistancesFile="../../../../Results/ConstantPopSize/ImportanceSamplingSims/DistancesFile10000_50Windows_"$FileNumber"_"$Repetition".txt"
# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

SeedNumber=$(( $FileNumber * 10 + $Repetition ))

rm $DistancesFile
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
for i in {1..1000}
do
perl TrajectoryPartMssel.pl $File $i $ExitMssel 10000
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency
if (( $(echo "$LastFrequency == 0.0" |bc -l) ))
then
echo "NO"
rm $MsselFile
# for k in {1..1000}
# do
../../../../Programs/Mssel/mssel3 41 100 1 40 $ExitMssel 1 -r 100 250000 -t 120 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
# done
time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequenceFractionsIncludeSingletons.pl $MsselFile $DistancesFile 1 40 0 0 25 250000 TestT2Bounds_50Windows.txt
else
Bounds=$( wc -l TestT2Bounds_50Windows.txt | awk '{print $1}' )
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

