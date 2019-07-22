rm ConstantSize/NewSelectionValues.txt

touch ConstantSize/NewSelectionValues.txt
for i in {0..300}
do
s=$( echo "scale = 6; $i * -0.000025" | bc )
echo $s >> ConstantSize/NewSelectionValues.txt
done
