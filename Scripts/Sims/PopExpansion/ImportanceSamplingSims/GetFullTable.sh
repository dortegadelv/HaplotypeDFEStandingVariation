rm FullTable.txt
touch FullTable.txt
for i in {1..21}
do
cat ../../../../Results/PopExpansion/ImportanceSamplingSims/Quantile$i/TableToTest.txt >> FullTable.txt
done

