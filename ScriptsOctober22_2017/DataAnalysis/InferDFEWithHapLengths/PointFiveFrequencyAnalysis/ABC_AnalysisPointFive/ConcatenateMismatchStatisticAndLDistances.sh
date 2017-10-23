cat ../../../../Results/ABCAnalysis/Output/WindowDistanceOut{1..250}.txt > ../../../../Results/ABCAnalysis/Output/AllWindowDistance.txt
cat ../../../../Results/ABCAnalysis/Output/WindowMismatch{1..250}.txt > ../../../../Results/ABCAnalysis/Output/AllWindowMismatch.txt
cat ../../../../Results/ABCAnalysis/LeftParameters{1..250}.txt > ../../../../Results/ABCAnalysis/AllLeftParameters.txt
paste -d "\t" ../../../../Results/ABCAnalysis/AllLeftParameters.txt ../../../../Results/ABCAnalysis/Output/AllWindowMismatch.txt ../../../../Results/ABCAnalysis/Output/AllWindowDistance.txt  > ../../../../Results/ABCAnalysis/ParametersAndStatistics.txt

## Second try
rm ../../../../../Results/ABCAnalysisPointFive/ParametersAndStatistics.txt
rm ../../../../../Results/ABCAnalysisPointFive/Output/AllWindowDistance.txt
rm ../../../../../Results/ABCAnalysisPointFive/Output/AllWindowMismatch.txt
rm ../../../../../Results/ABCAnalysisPointFive/AllLeftParameters.txt
rm ../../../../../Results/ABCAnalysisPointFive/AllAlleleAges.txt

for (( i = 1 ; i <= 500 ; i++ ))
do

File="../../../../../Results/ABCAnalysisPointFive/Output/WindowDistanceOut"$i".txt"
MismatchFile="../../../../../Results/ABCAnalysisPointFive/Output/WindowMismatch"$i".txt"
ParsFile="../../../../../Results/ABCAnalysisPointFive/LeftParameters"$i".txt"
AlleleAgesFile="../../../../../Results/ABCAnalysisPointFive/Output/AlleleAges"$i".txt"
NumberOfLines=$( wc -l $File | awk '{print $1}')

MinusOneLines=$(( $NumberOfLines ))

head -n$MinusOneLines $File >> ../../../../../Results/ABCAnalysisPointFive/Output/AllWindowDistance.txt
head -n$MinusOneLines $MismatchFile >> ../../../../../Results/ABCAnalysisPointFive/Output/AllWindowMismatch.txt
head -n$MinusOneLines $ParsFile >> ../../../../../Results/ABCAnalysisPointFive/AllLeftParameters.txt
head -n$MinusOneLines $AlleleAgesFile >> ../../../../../Results/ABCAnalysisPointFive/AllAlleleAges.txt

done

paste -d "\t" ../../../../../Results/ABCAnalysisPointFive/AllLeftParameters.txt ../../../../../Results/ABCAnalysisPointFive/Output/AllWindowMismatch.txt ../../../../../Results/ABCAnalysisPointFive/AllAlleleAges.txt ../../../../../Results/ABCAnalysisPointFive/Output/AllWindowDistance.txt  > ../../../../../Results/ABCAnalysisPointFive/ParametersAndStatisticsOld.txt

sort -k 7,7 ../../../../../Results/ABCAnalysisPointFive/ParametersAndStatisticsOld.txt | head -n100 > ../../../../../Results/ABCAnalysisPointFive/BestOld100.txt

paste -d "\t" ../../../../../Results/ABCAnalysisPointFive/AllLeftParameters.txt ../../../../../Results/ABCAnalysisPointFive/Output/AllWindowMismatch.txt ../../../../../Results/ABCAnalysisPointFive/Output/AllWindowDistance.txt  > ../../../../../Results/ABCAnalysisPointFive/ParametersAndStatistics.txt

sort -k 7,7 ../../../../../Results/ABCAnalysisPointFive/ParametersAndStatistics.txt | head -n100 > ../../../../../Results/ABCAnalysisPointFive/Best100.txt

