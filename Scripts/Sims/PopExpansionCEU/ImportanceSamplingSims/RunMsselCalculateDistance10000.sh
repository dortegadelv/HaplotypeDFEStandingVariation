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

File="../../../../Results/PopExpansionCEU/ImportanceSamplingSims/ExitMssel_0.01_0_"$FileNumber".txtTrajectory.txt"
ExitMssel="../../../../Results/PopExpansionCEU/ImportanceSamplingSims/TrajParTrajPartMsselOut_"$FileNumber"_"$Repetition".txt"
MsselFile="../../../../Results/PopExpansionCEU/ImportanceSamplingSims/MsselFileOut_"$FileNumber"_"$Repetition".txt"
DistancesFile="../../../../Results/PopExpansionCEU/ImportanceSamplingSims/DistancesFile10000_"$FileNumber"_"$Repetition".txt"
# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

SeedNumber=$(( $FileNumber * 10 + $Repetition ))

rm $DistancesFile
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
for i in {1..1000}
do
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 834302
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency
if (( $(echo "$LastFrequency == 0.0" |bc -l) ))
then
echo "NO"
rm $MsselFile
# for k in {1..1000}
# do
../../../../Programs/Mssel/mssel3 41 100 1 40 $ExitMssel 1 -r 834.302 50000 -t 1001.1624 -eN 0.00000000 1 -eN 0.00000300 0.884588554 -eN 0.00000899 0.750308641 -eN 0.00001498 0.636414632 -eN 0.00002098 0.539806928 -eN 0.00002697 0.457865377 -eN 0.00003296 0.38836057 -eN 0.00003895 0.329408296 -eN 0.00004495 0.27940482 -eN 0.00005094 0.236990922 -eN 0.00005693 0.201015939 -eN 0.00006293 0.170501809 -eN 0.00006892 0.144621492 -eN 0.00007491 0.122667811 -eN 0.00008091 0.104046257 -eN 0.00008690 0.088253414 -eN 0.00009289 0.074855388 -eN 0.00009889 0.063492596 -eN 0.00010488 0.053855798 -eN 0.00011087 0.045678903 -eN 0.00011686 0.038746161 -eN 0.00012286 0.034697268 -eN 0.00354788 0.017523631 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
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

