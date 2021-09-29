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
ExitMssel="../../../../Results/PopExpansion/ImportanceSamplingSims/TrajParTrajPartMsselOut_"$FileNumber"_"$Repetition".txt"

for j in {1..21}
do
MsselFile="../../../../Results/PopExpansion/ImportanceSamplingSims/MsselFileOut_"$FileNumber"_"$Repetition".txt"
DistancesFile="../../../../Results/PopExpansion/ImportanceSamplingSims/Quantile$j/DistancesFileWithRec10000_"$FileNumber"_"$Repetition".txt"
# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel
SeedNumber=$(( $FileNumber * 10 + $Repetition ))
rm $DistancesFile
done


RecRate[1]="0"
RecRate[2]="112.089"
RecRate[3]="141.46"
RecRate[4]="180.308"
RecRate[5]="217.36"
RecRate[6]="243.29"
RecRate[7]="266.524"
RecRate[8]="309.23"
RecRate[9]="362.2"
RecRate[10]="402.83"
RecRate[11]="474.635"
RecRate[12]="522.213"
RecRate[13]="564.33"
RecRate[14]="614.147"
RecRate[15]="665.195"
RecRate[16]="719"
RecRate[17]="869.9"
RecRate[18]="987.515"
RecRate[19]="1090.666"
RecRate[20]="1286.915"
RecRate[21]="2137.75"


# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
for i in {1..1000}
do
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 50000
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency
SeedNumber=$(( $StartSeedNumber + $i  ))

for j in {1..21}
do
MsselFile="../../../../Results/PopExpansion/ImportanceSamplingSims/Quantile$j/MsselFileOut_"$FileNumber"_"$Repetition".txt"
DistancesFile="../../../../Results/PopExpansion/ImportanceSamplingSims/Quantile$j/DistancesFileWithRec10000_"$FileNumber"_"$Repetition".txt"

rm $MsselFile

if (( $(echo "$LastFrequency == 0.0" |bc -l) ))
then
echo "NO"
rm $MsselFile
# for k in {1..1000}
# do
../../../../Programs/Mssel/mssel3 41 100 1 40 $ExitMssel 1 -r ${RecRate[$j]} 250000 -t 600 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
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
done
