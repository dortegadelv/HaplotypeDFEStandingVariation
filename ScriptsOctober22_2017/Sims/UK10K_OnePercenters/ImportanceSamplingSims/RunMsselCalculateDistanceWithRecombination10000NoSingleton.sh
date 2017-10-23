#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -e ../../../../Results/Trash/
#$ -o ../../../../Results/Trash/

FileNumber=$(( ( $SGE_TASK_ID - 1 ) / 10 + 1 ))
Repetition=$(( ( $SGE_TASK_ID - 1 ) % 10 + 1 ))

File="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMssel_0.01_0_"$FileNumber".txtTrajectory.txt"
ExitMssel="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/TrajParTrajPartMsselOut_"$FileNumber"_"$Repetition".txt"

# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

SeedNumber=$(( $FileNumber * 10 + $Repetition ))

for j in {1..21}
do
DistancesFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$j"/DistancesFileWithRec10000_"$FileNumber"_"$Repetition".txt"
rm $DistancesFile
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
done

RecRate[1]="0"
RecRate[2]="300.231"
RecRate[3]="846.136"
RecRate[4]="1234.701"
RecRate[5]="1660.525"
RecRate[6]="2172.44"
RecRate[7]="2694.225"
RecRate[8]="3057.498"
RecRate[9]="3571.309"
RecRate[10]="4076.5"
RecRate[11]="4900.635"
RecRate[12]="5717.831"
RecRate[13]="6638.492"
RecRate[14]="7466.195"
RecRate[15]="8665.738"
RecRate[16]="9866.227"
RecRate[17]="10825.972"
RecRate[18]="12143.342"
RecRate[19]="15062.506"
RecRate[20]="19707.05"
RecRate[21]="42653.959"

for i in {1..100}
do
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 110379
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency

for j in {1..21}
do
MsselFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$j"/MsselFileOut_"$FileNumber"_"$Repetition".txt"
DistancesFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile"$j"/DistancesFileWithRec10000_"$FileNumber"_"$Repetition".txt"

rm $MsselFile

if [ "$LastFrequency" == "0" ]
then
echo "NO"
# for k in {1..1000}
# do

../../../../Programs/Mssel/mssel3 73 100 1 72 $ExitMssel 1 -r ${RecRate[$j]} 250000 -t 8278.425 -eN 0.0 1.0 -eN 0.0001382 0.0121128 -eN 0.0006568 0.0053045 -eN 0.0014541 0.0412624 -eN 0.0042196 0.0208101 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
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

