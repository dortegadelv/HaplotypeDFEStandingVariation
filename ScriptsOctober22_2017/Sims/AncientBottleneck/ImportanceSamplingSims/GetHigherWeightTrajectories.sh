ColumnToTake="3"
NumberOfBestTrajectories="10"

Vector[1]="1"

for i in $(seq 1 $NumberOfBestTrajectories)
do
Vector[$i]=$( cat BottleneckDenserGrid/Exit_0.01_0.txtWeightYears.txt | grep -n '.' | awk '{print $1,$103}' | sort -n -k2,2 | tail -n$i | head -n1 | awk '{print $1}' | cut -d':' -f1 )
done


for i in $(seq 1 $NumberOfBestTrajectories)
do
echo ${Vector[$i]}
FileToOpen=$(( ( ${Vector[$i]} - 1 ) / 1001 +  1 )) 
echo $FileToOpen
Number=$(( FileToOpen + 1000 ))
File="BottleneckDenserGrid/Exit_DemHistAfricanTennessen.txt_0.01_0_"$Number".txtTrajectory.txt"
echo $File
RowToTake=$(( ${Vector[$i]} - ( $FileToOpen - 1 ) * 1001 - 1 ))
echo $RowToTake
TrajFile="Trajectories/Trajectory"$i".txt"
perl PrintParticularTrajectories.pl $File $TrajFile $RowToTake
done

cat BottleneckDenserGrid/Exit_0.01_0.txtWeightYears.txt | grep -n '.' | awk '{print $1,$103}' | sort -n -k2,2 | tail -n$NumberOfBestTrajectories

