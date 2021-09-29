FourNs[1]="0"
FourNs[2]="25"
FourNs[3]="50"
FourNs[4]="-25"
FourNs[5]="-50"

SampleSize[1]="68"
SampleSize[2]="69"
SampleSize[3]="70"
SampleSize[4]="71"
SampleSize[5]="72"
SampleSize[6]="73"
SampleSize[7]="74"
SampleSize[8]="75"
SampleSize[9]="76"

for i in {1..5}
do
for j in {1..9}
do

ParameterFile="ParameterFile_4Ns"${FourNs[$i]}"_B.txt"
ParameterFileCopy="ParameterFile_4Ns"${FourNs[$i]}"_"${SampleSize[$j]}"_B.txt"

AlleleNum="Alleles_"${SampleSize[$j]}
TrajNum="\/Traj_"${SampleSize[$j]}

cp $ParameterFile $ParameterFileCopy

sed -i "s/Alleles/$AlleleNum/g" "$ParameterFileCopy"
sed -i "s/\/Traj/$TrajNum/g" "$ParameterFileCopy"

done
done

