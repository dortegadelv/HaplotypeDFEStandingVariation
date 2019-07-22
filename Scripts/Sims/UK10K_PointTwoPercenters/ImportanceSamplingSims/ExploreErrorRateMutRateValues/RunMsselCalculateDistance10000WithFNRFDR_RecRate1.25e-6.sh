#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -e ../../../../../Results/Trash/
#$ -o ../../../../../Results/Trash/

MutRate[1]="0.000000012"
MutRate[2]="0.000000015"
MutRate[3]="0.00000002"

RecRate[1]="0.0000000025"
RecRate[2]="0.0000000075"
RecRate[3]="0.0000000125"
RecRate[4]="0.0000000234"

ErrorRate[1]="0.000005"
ErrorRate[2]="0.0000075"
ErrorRate[3]="0.00001"
ErrorRate[4]="0.0"

FileNumber=$(( ( $SGE_TASK_ID - 1 ) % 100 + 1 ))
ErrorRateValue=$(( ( ( $SGE_TASK_ID - 1 ) / 100 ) % 4 + 1 ))
MutRateValue=$(( ( ( $SGE_TASK_ID - 1 ) / 100 ) / 4 + 1 ))

RecRateValue="3"

File="../../../../../Results/UK10K/ImportanceSamplingSims/ExitMssel_0.01_0_"$FileNumber".txtTrajectory.txt"
ExitMssel="../../../../../Results/UK10K/ImportanceSamplingSimsErrorRate"${ErrorRate[$ErrorRateValue]}"MutRate"${MutRate[$MutRateValue]}"RecRate"${RecRate[$RecRateValue]}"/TrajParTrajPartMsselOut_"$FileNumber".txt"
MsselFile="../../../../../Results/UK10K/ImportanceSamplingSimsErrorRate"${ErrorRate[$ErrorRateValue]}"MutRate"${MutRate[$MutRateValue]}"RecRate"${RecRate[$RecRateValue]}"/MsselFileOut_"$FileNumber".txt"
DistancesFile="../../../../../Results/UK10K/ImportanceSamplingSimsErrorRate"${ErrorRate[$ErrorRateValue]}"MutRate"${MutRate[$MutRateValue]}"RecRate"${RecRate[$RecRateValue]}"/DistancesFile10000_"$FileNumber".txt"
# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

SeedNumber=$(( $SGE_TASK_ID ))
echo $FileNumber" "$ErrorRateValue" "$MutRateValue
rm $DistancesFile
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
for i in {1..1000}
do
perl ../../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 173442
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency
if [ "$LastFrequency" == "0" ]
then
echo "NO"
rm $MsselFile
# for k in {1..1000}
# do
ThetaValue=$( echo "4 * 173442 * ${MutRate[$MutRateValue]} * 250000" | bc )
RhoValue=$( echo "4 * 173442 * ${RecRate[$RecRateValue]} * 250000" | bc )
../../../../../Programs/Mssel/mssel3 3 1000 1 2 $ExitMssel 1 -r $RhoValue 250000 -t $ThetaValue -eN 0.0 1.0 -eN 0.0000867 0.1291653 -eN 0.0001768 0.0421744 -eN 0.0013261 0.0107298 -eN 0.0029405 0.0834516 -eN 0.0085331 0.0420890 -seeds $SeedNumber $SeedNumber $SeedNumber > $MsselFile
# done
time perl ../DistanceToFirstSegregatingSiteWithFDRFNR.pl $MsselFile $DistancesFile 250000 TestT2Bounds.txt ${ErrorRate[$ErrorRateValue]}
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

