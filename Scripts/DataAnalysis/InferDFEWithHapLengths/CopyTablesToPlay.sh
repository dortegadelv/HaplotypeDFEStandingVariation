
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
echo $i $j $k
Directory="ImportanceSamplingSimsErrorRate"${ErrorRate[$k]}"MutRate"${MutRate[$i]}"RecRate"${RecRate[$j]}
echo $Directory
TableFile="../../../Results/UK10K/"$Directory"/TableToTest.txt"
echo $TableFile
ls -l $TableFile
CopyTable="../../../Results/UK10K/ListAllTables/TableErrorRate"${ErrorRate[$k]}"MutRate"${MutRate[$i]}"RecRate"${RecRate[$j]}".txt"
cp $TableFile $CopyTable
done
done
done
