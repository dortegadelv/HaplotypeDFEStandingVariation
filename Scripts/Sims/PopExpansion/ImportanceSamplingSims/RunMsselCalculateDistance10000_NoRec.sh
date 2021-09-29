#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


FileNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 10 + 1 ))
Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 10 + 1 ))

File="../../../../Results/PopExpansion/ImportanceSamplingSims/ExitMssel_0.01_0_"$FileNumber".txtTrajectory.txt"
ExitMssel="../../../../Results/PopExpansion/ImportanceSamplingSims/TrajParTrajPartMsselOut_NoRec_"$FileNumber"_"$Repetition".txt"
MsselFile="../../../../Results/PopExpansion/ImportanceSamplingSims/MsselFileOut_NoRec_"$FileNumber"_"$Repetition".txt"
DistancesFile="../../../../Results/PopExpansion/ImportanceSamplingSims/DistancesFile10000_NoRec_"$FileNumber"_"$Repetition".txt"
# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

SeedNumber=$(( $FileNumber * 10 + $Repetition ))

rm $DistancesFile
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
for i in {1..1000}
do
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 50000
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency
if (( $(echo "$LastFrequency == 0.0" |bc -l) ))
then
echo "NO"
rm $MsselFile
# for k in {1..1000}
# do
../../../../Programs/Mssel/mssel3 41 100 1 40 $ExitMssel 1 -r 0 250000 -t 600 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
# done
# time perl ../../ConstantPopSize/ImportanceSamplingSims/DistanceToFirstSegregatingSite.pl $MsselFile $DistancesFile 250000 TestT2Bounds.txt
time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequenceFractionsIncludeSingletons.pl $MsselFile $DistancesFile 1 40 0 0 25 250000 TestT2Bounds.txt
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

