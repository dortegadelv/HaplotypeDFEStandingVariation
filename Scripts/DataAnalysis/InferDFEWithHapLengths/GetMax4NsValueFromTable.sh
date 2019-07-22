
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

for i in {1..3}
do
for j in {1..4}
do
for k in {1..4}
do
Number=$(( $j - 1 ))
File="../../../Results/UK10K/ImportanceSamplingSimsErrorRate"${ErrorRate[$k]}"MutRate"${MutRate[$i]}"RecRate"${RecRate[$j]}"/ExitFileGroup"$Number".txt"
ls $File
Results=""
perl ../../Sims/ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.pl $File 
done
done
done
