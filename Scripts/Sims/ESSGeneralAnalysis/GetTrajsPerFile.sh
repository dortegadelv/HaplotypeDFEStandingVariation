Directory[1]="AncientBottleneck"
Directory[2]="ConstantPopSize"
Directory[3]="PopExpansion"
Directory[4]="PopExpansion100GensAgo"
Directory[5]="PopExpansion1000GensAgo"
Directory[6]="PopExpansion10000GensAgo"
Directory[7]="PopExpansion100000GensAgo"
Directory[8]="PopExpansionCEU"
Directory[9]="PopExpansionYRI"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_50"
FourNs[3]="4Ns_100"
FourNs[4]="4Ns_-50"
FourNs[5]="4Ns_-100"

for i in {1..9}
do
for j in {1..5}
do
CurrentTrajs="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/ReducedTrajectories10000.txt"
Ages=$( grep 'age' $CurrentTrajs | wc -l | awk '{print $1}' )
echo "${Directory[$i]} ${FourNs[$j]} $Ages"
done
done

Directory[1]="ConstantPopSizeBoyko/ForwardSims"
Directory[2]="ConstantPopSizeMouse/ForwardSims"
Directory[3]="PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart"
Directory[4]="PopExpansionBoykoPlusPositive/ForwardSims/PositivePart"
Directory[5]="PopExpansionMousePlusPositive/ForwardSims/MousePart"
Directory[6]="PopExpansionMousePlusPositive/ForwardSims/PositivePart"

for i in {1..6}
do

CurrentTrajs="../../../Results/"${Directory[$i]}"/ReducedTrajectories50000.txt"
Ages=$( grep 'age' $CurrentTrajs | wc -l | awk '{print $1}' )
echo "${Directory[$i]} ${FourNs[$j]} $Ages"

done

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_25"
FourNs[3]="4Ns_50"
FourNs[4]="4Ns_-25"
FourNs[5]="4Ns_-50"

for j in {1..5}
do
for i in {69..76}
do
CurrentTrajs="../../../Results/UK10K/ForwardSims/"${FourNs[$j]}"/ReducedTrajectories_$i.txt"
Ages=$( grep 'age' $CurrentTrajs | wc -l | awk '{print $1}' )
# ls -l $CurrentTrajs
echo "$i ${FourNs[$j]} $Ages"
done
done

for j in {1..3}
do
for i in {69..76}
do
CurrentTrajs="../../../Results/UK10K/ForwardSims/"${FourNs[$j]}"/ReducedTrajectories99Percent_$i.txt"
Ages=$( grep 'age' $CurrentTrajs | wc -l | awk '{print $1}' )
# ls -l $CurrentTrajs
echo "$i ${FourNs[$j]} $Ages"
done
done

