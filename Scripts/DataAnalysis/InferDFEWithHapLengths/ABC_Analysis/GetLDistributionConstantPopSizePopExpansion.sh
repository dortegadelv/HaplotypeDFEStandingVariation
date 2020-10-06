Values[1]=$( awk '$1 >= 0.0 && $1 <= 0.2 {print $1}' ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )
Values[2]=$( awk '$1 > 0.2 && $1 <= 0.4 {print $1}' ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )
Values[3]=$( awk '$1 > 0.4 && $1 <= 0.6 {print $1}' ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )
Values[4]=$( awk '$1 > 0.6 && $1 <= 0.8 {print $1}' ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )
Values[5]=$( awk '$1 > 0.8 && $1 <= 1.0 {print $1}' ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )
Values[6]=$( awk '$1 > 1.0 {print $1}' ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )

Sum=$(( ${Values[1]} + ${Values[2]} + ${Values[3]} + ${Values[4]} + ${Values[5]} + ${Values[6]} ))

echo "${Values[1]}\t$Sum\n"

Fraction[1]=$( echo "scale=15 ; ${Values[1]} / $Sum" | bc )
Fraction[2]=$( echo "scale=15 ; ${Values[2]} / $Sum" | bc )
Fraction[3]=$( echo "scale=15 ; ${Values[3]} / $Sum" | bc )
Fraction[4]=$( echo "scale=15 ; ${Values[4]} / $Sum" | bc )
Fraction[5]=$( echo "scale=15 ; ${Values[5]} / $Sum" | bc )
Fraction[6]=$( echo "scale=15 ; ${Values[6]} / $Sum" | bc )

echo "${Fraction[1]}	${Fraction[2]}	${Fraction[3]}	${Fraction[4]}	${Fraction[5]}	${Fraction[6]}" > LDistributionConstantPopSize.txt


Values[1]=$( awk '$1 >= 0.0 && $1 <= 0.2 {print $1}' ../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )
Values[2]=$( awk '$1 > 0.2 && $1 <= 0.4 {print $1}' ../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )
Values[3]=$( awk '$1 > 0.4 && $1 <= 0.6 {print $1}' ../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )
Values[4]=$( awk '$1 > 0.6 && $1 <= 0.8 {print $1}' ../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )
Values[5]=$( awk '$1 > 0.8 && $1 <= 1.0 {print $1}' ../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )
Values[6]=$( awk '$1 > 1.0 {print $1}' ../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengths/HapLengthsLess1.txt | wc -l )

Sum=$(( ${Values[1]} + ${Values[2]} + ${Values[3]} + ${Values[4]} + ${Values[5]} + ${Values[6]} ))

echo "${Values[1]}\t$Sum\n"

Fraction[1]=$( echo "scale=15 ; ${Values[1]} / $Sum" | bc )
Fraction[2]=$( echo "scale=15 ; ${Values[2]} / $Sum" | bc )
Fraction[3]=$( echo "scale=15 ; ${Values[3]} / $Sum" | bc )
Fraction[4]=$( echo "scale=15 ; ${Values[4]} / $Sum" | bc )
Fraction[5]=$( echo "scale=15 ; ${Values[5]} / $Sum" | bc )
Fraction[6]=$( echo "scale=15 ; ${Values[6]} / $Sum" | bc )

echo "${Fraction[1]}	${Fraction[2]}	${Fraction[3]}	${Fraction[4]}	${Fraction[5]}	${Fraction[6]}" > LDistributionPopExpansion.txt

