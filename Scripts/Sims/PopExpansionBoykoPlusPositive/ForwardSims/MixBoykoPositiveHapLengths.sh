for i in {1..100}
do

echo $i

FileOne="../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/HapLengths$i.txt"
FileTwo="../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/PositivePart/HapLengths/HapLengths$i.txt"
PartOne="../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/MixBoykoPositive/HapLengths/PartOne$i.txt"
PartTwo="../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/MixBoykoPositive/HapLengths/PartTwo$i.txt"
CompleteFile="../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/MixBoykoPositive/HapLengths/AllHapLengths$i.txt"

head -n444600 $FileOne > $PartOne
head -n23400 $FileTwo > $PartTwo

cat $PartOne $PartTwo > $CompleteFile

rm $PartOne
rm $PartTwo

done

