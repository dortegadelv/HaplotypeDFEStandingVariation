cat ../../../../Results/ABCAnalysis/Output/WindowDistanceOut{1..250}.txt > ../../../../Results/ABCAnalysis/Output/AllWindowDistance.txt
cat ../../../../Results/ABCAnalysis/Output/WindowMismatch{1..250}.txt > ../../../../Results/ABCAnalysis/Output/AllWindowMismatch.txt
cat ../../../../Results/ABCAnalysis/LeftParameters{1..250}.txt > ../../../../Results/ABCAnalysis/AllLeftParameters.txt
paste -d "\t" ../../../../Results/ABCAnalysis/AllLeftParameters.txt ../../../../Results/ABCAnalysis/Output/AllWindowMismatch.txt ../../../../Results/ABCAnalysis/Output/AllWindowDistance.txt  > ../../../../Results/ABCAnalysis/ParametersAndStatistics.txt

## Second try

rm ../../../../Results/ABCAnalysis/ParametersAndStatistics.txt
rm ../../../../Results/ABCAnalysis/Output/AllWindowDistance.txt
rm ../../../../Results/ABCAnalysis/Output/AllWindowMismatch.txt
rm ../../../../Results/ABCAnalysis/AllLeftParameters.txt

for (( i = 1 ; i <= 500 ; i++ ))
do

File="../../../../Results/ABCAnalysis/Output/WindowDistanceOut"$i".txt"
MismatchFile="../../../../Results/ABCAnalysis/Output/WindowMismatch"$i".txt"
ParsFile="../../../../Results/ABCAnalysis/LeftParameters"$i".txt"
NumberOfLines=$( wc -l $File | awk '{print $1}')

MinusOneLines=$(( $NumberOfLines ))

head -n$MinusOneLines $File >> ../../../../Results/ABCAnalysis/Output/AllWindowDistance.txt
head -n$MinusOneLines $MismatchFile >> ../../../../Results/ABCAnalysis/Output/AllWindowMismatch.txt
head -n$MinusOneLines $ParsFile >> ../../../../Results/ABCAnalysis/AllLeftParameters.txt

done

paste -d "\t" ../../../../Results/ABCAnalysis/AllLeftParameters.txt ../../../../Results/ABCAnalysis/Output/AllWindowMismatch.txt ../../../../Results/ABCAnalysis/Output/AllWindowDistance.txt  > ../../../../Results/ABCAnalysis/ParametersAndStatistics.txt

sort -k 5,5 ../../../../Results/ABCAnalysis/ParametersAndStatistics.txt | head -n100 > ../../../../Results/ABCAnalysis/Best100.txt
