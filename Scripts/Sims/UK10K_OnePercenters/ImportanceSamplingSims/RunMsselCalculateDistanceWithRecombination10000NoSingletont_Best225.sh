#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=96:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

FileNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 1 + 1 ))
Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 1 + 1 ))

File="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMssel_0.01_0_"$FileNumber".txtTrajectory.txt"
ExitMssel="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/TrajParTrajPartMsselOut_"$FileNumber"_"$Repetition".txt"

# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

SeedNumber=$(( ( $FileNumber * 10 + $Repetition) * 1000 ))

for j in {1..21}
do
DistancesFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$j"/DistancesFileWithRec10000_"$FileNumber"_"$Repetition".txt"
rm $DistancesFile
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
done

RecRate[1]="0"
RecRate[2]="244.244"
RecRate[3]="632.242"
RecRate[4]="1000.151"
RecRate[5]="1377.508"
RecRate[6]="1748.75"
RecRate[7]="2411.118"
RecRate[8]="2864.9"
RecRate[9]="3207.188"
RecRate[10]="3677.917"
RecRate[11]="4329.264"
RecRate[12]="5077.173"
RecRate[13]="5889.83"
RecRate[14]="6656.637"
RecRate[15]="7491.979"
RecRate[16]="8891.582"
RecRate[17]="9913.958"
RecRate[18]="10847.288"
RecRate[19]="13039.552"
RecRate[20]="16573.367"
RecRate[21]="29361.79"

for i in {1..10}
do
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 104961
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency
SeedNumber=$(( $SeedNumber + 1  ))

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

../../../../Programs/Mssel/mssel3 73 100 1 72 $ExitMssel 1 -r ${RecRate[$j]} 250000 -t 7872.075 -eN 0.0 1.0 -eN 0.0001191 0.0076981 -eN 0.0006907 0.0055830 -eN 0.0015291 0.0433875 -eN 0.0044374 0.0218843 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
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
