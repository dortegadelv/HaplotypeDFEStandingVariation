
Frequency[1]="0.005"
# Frequency[2]="0.02"
Frequency[2]="0.01"
Frequency[3]="0.03"
Frequency[4]="0.05"
Frequency[5]="0.075"
Frequency[6]="0.01"

Selection[1]="0"
# Selection[2]="-50"
Selection[2]="-1"
# Selection[4]="-5"
# Selection[5]="-1"
Selection[3]="-5"
Selection[4]="-10"
Selection[5]="-50"
Selection[6]="-100"

for i in {2..2}
do
for j in {1..1}
do
PrefixFile="Exit_"${Frequency[$i]}"_"${Selection[$j]}
L2PrefixFile="L2_"${Frequency[$i]}"_"${Selection[$j]}
# cat ConstantSize/$PrefixFile"_"{1001..1100}".txtWeightYears.txt" > ConstantSize/$PrefixFile".txtWeightYears.txt"
cat ConstantSize/$L2PrefixFile"_"{1001..1100}".txt" > ConstantSize/$L2PrefixFile".txt"

done
done

