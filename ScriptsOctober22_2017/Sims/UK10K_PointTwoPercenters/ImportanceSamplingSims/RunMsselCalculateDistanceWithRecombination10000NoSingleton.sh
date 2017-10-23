#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -e ../../../../Results/Trash/
#$ -o ../../../../Results/Trash/

FileNumber=$(( ( $SGE_TASK_ID - 1 ) / 10 + 1 ))
Repetition=$(( ( $SGE_TASK_ID - 1 ) % 10 + 1 ))

File="../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/ExitMssel_0.01_0_"$FileNumber".txtTrajectory.txt"
ExitMssel="../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/TrajParTrajPartMsselOut_"$FileNumber"_"$Repetition".txt"

# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

SeedNumber=$(( $FileNumber * 10 + $Repetition ))

for j in {1..21}
do
DistancesFile="../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$j"/DistancesFileWithRec10000_"$FileNumber"_"$Repetition".txt"
rm $DistancesFile
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
done

RecRate[1]="0"
RecRate[2]="449.262"
RecRate[3]="1107.195"
RecRate[4]="1748.897"
RecRate[5]="2393.696"
RecRate[6]="3093.856"
RecRate[7]="3827.001"
RecRate[8]="4561.394"
RecRate[9]="5314.573"
RecRate[10]="6320.064"
RecRate[11]="7379.585"
RecRate[12]="8492.028"
RecRate[13]="9529.426"
RecRate[14]="10686.593"
RecRate[15]="12168.528"
RecRate[16]="13779.627"
RecRate[17]="15619.779"
RecRate[18]="18236.258"
RecRate[19]="22322.332"
RecRate[20]="28716.438"
RecRate[21]="65803.144"


for i in {1..1000}
do
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 158191
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency

for j in {1..21}
do
MsselFile="../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$j"/MsselFileOut_"$FileNumber"_"$Repetition".txt"
DistancesFile="../../../../Results/UK10K_PointTwoPercenters/ImportanceSamplingSims/Quantile"$j"/DistancesFileWithRec10000_"$FileNumber"_"$Repetition".txt"

rm $MsselFile

if [ "$LastFrequency" == "0" ]
then
echo "NO"
# for k in {1..1000}
# do

../../../../Programs/Mssel/mssel3 16 100 1 15 $ExitMssel 1 -r ${RecRate[$j]} 250000 -t 11864.325 -eN 0.0 1.0 -eN 0.0001296 0.0034705 -eN 0.0031686 0.0181300 -eN 0.0030232 0.0151715 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
# done
time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequenceFractions.pl $MsselFile $DistancesFile 1 15 0 0 25 250000 TestT2Bounds.txt
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

