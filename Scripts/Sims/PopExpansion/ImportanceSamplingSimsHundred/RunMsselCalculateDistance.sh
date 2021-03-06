#$ -l h_vmem=2g
#$ -cwd

#$ -N ForWF
#$ -o ../../../../Results/Trash/
#$ -e ../../../../Results/Trash/

File="../../../../Results/PopExpansion/ImportanceSamplingSims/ExitMssel_0.01_0_"$SGE_TASK_ID".txtTrajectory.txt"
ExitMssel="../../../../Results/PopExpansion/ImportanceSamplingSims/TrajParTrajPartMsselOut_"$SGE_TASK_ID".txt"
MsselFile="../../../../Results/PopExpansion/ImportanceSamplingSims/MsselFileOut_"$SGE_TASK_ID".txt"
DistancesFile="../../../../Results/PopExpansion/ImportanceSamplingSims/DistancesFile_"$SGE_TASK_ID".txt"
# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

rm $DistancesFile
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
for i in {1..1000}
do
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajectoryPartMssel.pl $File $i $ExitMssel 50000
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo $LastFrequency
if [ "$LastFrequency" == "0" ]
then
echo "NO"
rm $MsselFile
# for k in {1..1000}
# do
../../../../Programs/Mssel/mssel3 3 1000 1 2 $ExitMssel 1 -r 1000 250000 -t 1200 -eN 0.0 1.0 -eN 0.0005 0.1 >> $MsselFile
# done
time perl ../../ConstantPopSize/ImportanceSamplingSims/DistanceToFirstSegregatingSite.pl $MsselFile $DistancesFile 500000 ../../ConstantPopSize/ImportanceSamplingSims/TestT2Bounds.txt
else
Bounds=$( wc -l ../../ConstantPopSize/ImportanceSamplingSims/TestT2Bounds.txt | awk '{print $1}' )
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
