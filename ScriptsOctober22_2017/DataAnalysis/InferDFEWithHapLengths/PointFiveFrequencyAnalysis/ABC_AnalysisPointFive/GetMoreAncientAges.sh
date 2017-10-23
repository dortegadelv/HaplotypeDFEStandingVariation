
FileNumber=$( ls -l ../../../../../Results/ABCAnalysisPointFive/Output/TrajOutputAlleles_1_* | wc -l )
echo $FileNumber

for (( i = 1 ; i <= $FileNumber ; i++ ))
do

ThisFile="../../../../../Results/ABCAnalysisPointFive/Output/TrajOutputAlleles_1_"$i".txt"
echo $ThisFile

AlleleID=$( head -n1 $ThisFile | awk '{print $1}' )
grep "$AlleleID" $ThisFile | wc -l
done
