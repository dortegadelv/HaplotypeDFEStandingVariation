FourNs[1]="4Ns_0"
FourNs[2]="4Ns_25"
FourNs[3]="4Ns_50"
FourNs[4]="4Ns_-25"
FourNs[5]="4Ns_-50"

for i in {1..5}
do
for j in {69..76}
do

Value=$( wc -l ../../../../Results/UK10K/ForwardSims/${FourNs[$i]}/Alleles_{1..500}.$j.txt | tail -n1 | awk '{print $1}' )
ValueTwo=$( wc -l ../../../../Results/UK10K/ForwardSims/${FourNs[$i]}/Alleles99Percent_{1..500}.$j.txt | tail -n1 | awk '{print $1}' )

echo -e "${FourNs[$i]}\t$j\t$Value\t$ValueTwo"

done
done

