$NumberIdentifiers=$1;
## Not CpG

rm ../Results/ParametersAndStatisticsNotCpG.txt
rm ../Results/AllWindowDistanceNotCpG.txt
rm ../Results/AllWindowMismatchNotCpG.txt
rm ../Results/AllLeftParametersNotCpG.txt

for (( i = 1 ; i <= NumberIdentifiers ; i++ ))
do

File="../Results/WindowDistanceOutNotCpG"$i".txt"
MismatchFile="../Results/WindowMismatchNotCpG"$i".txt"
ParsFile="../Results/LeftParameters"$i".txt"
NumberOfLines=$( wc -l $File | awk '{print $1}')

MinusOneLines=$(( $NumberOfLines ))

head -n$MinusOneLines $File >> ../Results/AllWindowDistanceNotCpG.txt
head -n$MinusOneLines $MismatchFile >> ../Results/AllWindowMismatchNotCpG.txt
head -n$MinusOneLines $ParsFile >> ../Results/AllLeftParametersNotCpG.txt

done

paste -d "\t"../Results/AllLeftParametersNotCpG.txt ../Results/AllWindowMismatchNotCpG.txt ../Results/AllWindowDistanceNotCpG.txt  > ../Results/ParametersAndStatisticsNotCpG.txt

sort -k 5,5 ../Results/ParametersAndStatisticsNotCpG.txt | head -n100 > ../Results/Best100NotCpG.txt

