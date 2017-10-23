#$ -l express,h_rt=2:00:00
#$ -cwd

#$ -N ForWF

File="BottleneckDenserGrid/ExitMssel_0.01_0_"$SGE_TASK_ID".txtTrajectory.txt"
ExitMssel="BottleneckDenserGrid/TrajParTrajPartMsselOut_"$SGE_TASK_ID".txt"
MsselFile="MsselFiles/MsselFileOut_"$SGE_TASK_ID".txt"
DistancesFile="BottleneckDenserGrid/DistancesFile_"$SGE_TASK_ID".txt"
# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

rm $DistancesFile
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
for i in {1..1001}
do
perl ../TrajectoryPartMssel.pl $File $i $ExitMssel 50000
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency
if [ "$LastFrequency" == "0" ]
then
echo "NO"
rm $MsselFile
# for k in {1..1000}
# do
../mssel3 3 1000 1 2 $ExitMssel 1 -r 100 500000 -t 100 -eN 0.0 1.0 -eN 0.005 0.2 -eN 0.015 1.0  >> $MsselFile
# done
time perl ../DistanceToFirstSegregatingSite.pl $MsselFile $DistancesFile 500000 ../TestT2Bounds.txt
else
Bounds=$( wc -l ../TestT2Bounds.txt | awk '{print $1}' )
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
