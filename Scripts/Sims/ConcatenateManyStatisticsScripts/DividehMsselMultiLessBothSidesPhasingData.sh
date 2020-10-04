DemographicScenario[1]="ConstantPopSize"
DemographicScenario[2]="PopExpansion"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_50"
FourNs[3]="4Ns_100"
FourNs[4]="4Ns_-50"
FourNs[5]="4Ns_-100"

for j in {1..2}
do
for k in {1..5}
do
echo ${DemographicScenario[$j]}" "${FourNs[$k]}
for i in {1..100}
do

LineNumberStart=$(( $i * 1560 ))

head -n$LineNumberStart ../../../Results/${DemographicScenario[$j]}/ForwardSims/${FourNs[$k]}/HapLengths/HapLengthsLessUnphased1.txt | tail -n1560 > ../../../Results/${DemographicScenario[$j]}/ForwardSims/${FourNs[$k]}/HapLengths/HapLengthsLessUnphased1Part$i.txt

done
done
done

DemographicScenario[1]="UK10K"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_50"
FourNs[3]="4Ns_25"
FourNs[4]="4Ns_-50"
FourNs[5]="4Ns_-25"

for j in {1..1}
do
for k in {1..5}
do
echo ${DemographicScenario[$j]}" "${FourNs[$k]}
for i in {1..100}
do

LineNumberStart=$(( $i * 5112 ))

head -n$LineNumberStart ../../../Results/${DemographicScenario[$j]}/ForwardSims/${FourNs[$k]}/HapLengths/HapLengthsLessUnphased1.txt | tail -n5112 > ../../../Results/${DemographicScenario[$j]}/ForwardSims/${FourNs[$k]}/HapLengths/HapLengthsLessUnphased1Part$i.txt

done
done
done


