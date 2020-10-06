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

## Not CpG

rm ../../../../Results/ABCAnalysis/ParametersAndStatisticsNotCpG.txt
rm ../../../../Results/ABCAnalysis/Output/AllWindowDistanceNotCpG.txt
rm ../../../../Results/ABCAnalysis/Output/AllWindowMismatchNotCpG.txt
rm ../../../../Results/ABCAnalysis/AllLeftParametersNotCpG.txt

for (( i = 1 ; i <= 500 ; i++ ))
do

File="../../../../Results/ABCAnalysis/Output/WindowDistanceOutNotCpG"$i".txt"
MismatchFile="../../../../Results/ABCAnalysis/Output/WindowMismatchNotCpG"$i".txt"
ParsFile="../../../../Results/ABCAnalysis/LeftParameters"$i".txt"
NumberOfLines=$( wc -l $File | awk '{print $1}')

MinusOneLines=$(( $NumberOfLines ))

head -n$MinusOneLines $File >> ../../../../Results/ABCAnalysis/Output/AllWindowDistanceNotCpG.txt
head -n$MinusOneLines $MismatchFile >> ../../../../Results/ABCAnalysis/Output/AllWindowMismatchNotCpG.txt
head -n$MinusOneLines $ParsFile >> ../../../../Results/ABCAnalysis/AllLeftParametersNotCpG.txt

done

paste -d "\t" ../../../../Results/ABCAnalysis/AllLeftParametersNotCpG.txt ../../../../Results/ABCAnalysis/Output/AllWindowMismatchNotCpG.txt ../../../../Results/ABCAnalysis/Output/AllWindowDistanceNotCpG.txt  > ../../../../Results/ABCAnalysis/ParametersAndStatisticsNotCpG.txt

sort -k 5,5 ../../../../Results/ABCAnalysis/ParametersAndStatisticsNotCpG.txt | head -n100 > ../../../../Results/ABCAnalysis/Best100NotCpG.txt


### Constant Pop Size

rm ../../../../Results/ABCResults/MedianResultsConstantPopSizes.txt
touch ../../../../Results/ABCResults/MedianResultsConstantPopSizes.txt
for (( j = 1 ; j <= 100 ; j++ ))
do

File="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengths/HapLengthsLess"$j".txt"

Values[1]=$( awk '$1 >= 0.0 && $1 <= 0.2 {print $1}' $File | wc -l )
Values[2]=$( awk '$1 > 0.2 && $1 <= 0.4 {print $1}' $File | wc -l )
Values[3]=$( awk '$1 > 0.4 && $1 <= 0.6 {print $1}' $File | wc -l )
Values[4]=$( awk '$1 > 0.6 && $1 <= 0.8 {print $1}' $File | wc -l )
Values[5]=$( awk '$1 > 0.8 && $1 <= 1.0 {print $1}' $File | wc -l )
Values[6]=$( awk '$1 > 1.0 {print $1}' $File | wc -l )

Sum=$(( ${Values[1]} + ${Values[2]} + ${Values[3]} + ${Values[4]} + ${Values[5]} + ${Values[6]} ))

echo "${Values[1]}\t$Sum\n"

Fraction[1]=$( echo "scale=15 ; ${Values[1]} / $Sum" | bc )
Fraction[2]=$( echo "scale=15 ; ${Values[2]} / $Sum" | bc )
Fraction[3]=$( echo "scale=15 ; ${Values[3]} / $Sum" | bc )
Fraction[4]=$( echo "scale=15 ; ${Values[4]} / $Sum" | bc )
Fraction[5]=$( echo "scale=15 ; ${Values[5]} / $Sum" | bc )
Fraction[6]=$( echo "scale=15 ; ${Values[6]} / $Sum" | bc )

echo -e "${Fraction[1]}\t${Fraction[2]}\t${Fraction[3]}\t${Fraction[4]}\t${Fraction[5]}\t${Fraction[6]}" > LDistributionConstantPopSize.txt

perl CalculateMismatchStatisticConstantPopSizes_NotCpG.pl

rm ../../../../Results/ABCAnalysisConstantPopSize/ParametersAndStatisticsNotCpG.txt
rm ../../../../Results/ABCAnalysisConstantPopSize/Output/AllWindowDistanceNotCpG.txt
rm ../../../../Results/ABCAnalysisConstantPopSize/Output/AllWindowMismatchNotCpG.txt
rm ../../../../Results/ABCAnalysisConstantPopSize/AllLeftParametersNotCpG.txt

for (( i = 1 ; i <= 1000 ; i++ ))
do

File="../../../../Results/ABCAnalysisConstantPopSize/Output/WindowDistanceOutNotCpG"$i".txt"
MismatchFile="../../../../Results/ABCAnalysisConstantPopSize/Output/WindowMismatchNotCpG"$i".txt"
ParsFile="../../../../Results/ABCAnalysisConstantPopSize/LeftParameters"$i".txt"
NumberOfLines=$( wc -l $File | awk '{print $1}')

MinusOneLines=$(( $NumberOfLines ))

head -n$MinusOneLines $File >> ../../../../Results/ABCAnalysisConstantPopSize/Output/AllWindowDistanceNotCpG.txt
head -n$MinusOneLines $MismatchFile >> ../../../../Results/ABCAnalysisConstantPopSize/Output/AllWindowMismatchNotCpG.txt
head -n$MinusOneLines $ParsFile >> ../../../../Results/ABCAnalysisConstantPopSize/AllLeftParametersNotCpG.txt

done

paste -d "\t" ../../../../Results/ABCAnalysisConstantPopSize/AllLeftParametersNotCpG.txt ../../../../Results/ABCAnalysisConstantPopSize/Output/AllWindowMismatchNotCpG.txt ../../../../Results/ABCAnalysisConstantPopSize/Output/AllWindowDistanceNotCpG.txt  > ../../../../Results/ABCAnalysisConstantPopSize/ParametersAndStatisticsNotCpG.txt

sort -k 2,2 ../../../../Results/ABCAnalysisConstantPopSize/ParametersAndStatisticsNotCpG.txt | head -n100 > ../../../../Results/ABCAnalysisConstantPopSize/Best100NotCpG.txt

cp ../../../../Results/ABCAnalysisConstantPopSize/Best100NotCpG.txt ../../../../Results/ABCResults/Best100NotCpGConstantPopSize$j.txt

ValueOne=$( awk '{print $1}' ../../../../Results/ABCAnalysisConstantPopSize/Best100NotCpG.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $1}' ../../../../Results/ABCAnalysisConstantPopSize/Best100NotCpG.txt | sort -g | head -n51 | tail -n1 )

Median=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

echo $Median >> ../../../../Results/ABCResults/MedianResultsConstantPopSizes.txt

done


############# Pop Expansion


rm ../../../../Results/ABCResults/MedianResultsPopExpansion.txt
touch ../../../../Results/ABCResults/MedianResultsPopExpansion.txt
for (( j = 1 ; j <= 100 ; j++ ))
do

File="../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengths/HapLengthsLess"$j".txt"

Values[1]=$( awk '$1 >= 0.0 && $1 <= 0.2 {print $1}' $File | wc -l )
Values[2]=$( awk '$1 > 0.2 && $1 <= 0.4 {print $1}' $File | wc -l )
Values[3]=$( awk '$1 > 0.4 && $1 <= 0.6 {print $1}' $File | wc -l )
Values[4]=$( awk '$1 > 0.6 && $1 <= 0.8 {print $1}' $File | wc -l )
Values[5]=$( awk '$1 > 0.8 && $1 <= 1.0 {print $1}' $File | wc -l )
Values[6]=$( awk '$1 > 1.0 {print $1}' $File | wc -l )

Sum=$(( ${Values[1]} + ${Values[2]} + ${Values[3]} + ${Values[4]} + ${Values[5]} + ${Values[6]} ))

echo "${Values[1]}\t$Sum\n"

Fraction[1]=$( echo "scale=15 ; ${Values[1]} / $Sum" | bc )
Fraction[2]=$( echo "scale=15 ; ${Values[2]} / $Sum" | bc )
Fraction[3]=$( echo "scale=15 ; ${Values[3]} / $Sum" | bc )
Fraction[4]=$( echo "scale=15 ; ${Values[4]} / $Sum" | bc )
Fraction[5]=$( echo "scale=15 ; ${Values[5]} / $Sum" | bc )
Fraction[6]=$( echo "scale=15 ; ${Values[6]} / $Sum" | bc )

echo -e "${Fraction[1]}\t${Fraction[2]}\t${Fraction[3]}\t${Fraction[4]}\t${Fraction[5]}\t${Fraction[6]}" > LDistributionPopExpansion.txt

perl CalculateMismatchStatisticPopExpansion_NotCpG.pl

rm ../../../../Results/ABCAnalysisPopExpansion/ParametersAndStatisticsNotCpG.txt
rm ../../../../Results/ABCAnalysisPopExpansion/Output/AllWindowDistanceNotCpG.txt
rm ../../../../Results/ABCAnalysisPopExpansion/Output/AllWindowMismatchNotCpG.txt
rm ../../../../Results/ABCAnalysisPopExpansion/AllLeftParametersNotCpG.txt

for (( i = 1 ; i <= 1000 ; i++ ))
do

File="../../../../Results/ABCAnalysisPopExpansion/Output/WindowDistanceOutNotCpG"$i".txt"
MismatchFile="../../../../Results/ABCAnalysisPopExpansion/Output/WindowMismatchNotCpG"$i".txt"
ParsFile="../../../../Results/ABCAnalysisPopExpansion/LeftParameters"$i".txt"
NumberOfLines=$( wc -l $File | awk '{print $1}')

MinusOneLines=$(( $NumberOfLines ))

head -n$MinusOneLines $File >> ../../../../Results/ABCAnalysisPopExpansion/Output/AllWindowDistanceNotCpG.txt
head -n$MinusOneLines $MismatchFile >> ../../../../Results/ABCAnalysisPopExpansion/Output/AllWindowMismatchNotCpG.txt
head -n$MinusOneLines $ParsFile >> ../../../../Results/ABCAnalysisPopExpansion/AllLeftParametersNotCpG.txt

done

paste -d "\t" ../../../../Results/ABCAnalysisPopExpansion/AllLeftParametersNotCpG.txt ../../../../Results/ABCAnalysisPopExpansion/Output/AllWindowMismatchNotCpG.txt ../../../../Results/ABCAnalysisPopExpansion/Output/AllWindowDistanceNotCpG.txt  > ../../../../Results/ABCAnalysisPopExpansion/ParametersAndStatisticsNotCpG.txt

sort -k 4,4 ../../../../Results/ABCAnalysisPopExpansion/ParametersAndStatisticsNotCpG.txt | head -n100 > ../../../../Results/ABCAnalysisPopExpansion/Best100NotCpG.txt

cp ../../../../Results/ABCAnalysisPopExpansion/Best100NotCpG.txt ../../../../Results/ABCResults/Best100NotCpGPopExpansion$j.txt

ValueOne=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansion/Best100NotCpG.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansion/Best100NotCpG.txt | sort -g | head -n51 | tail -n1 )

Median=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansion/Best100NotCpG.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansion/Best100NotCpG.txt | sort -g | head -n51 | tail -n1 )

MedianTwo=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansion/Best100NotCpG.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansion/Best100NotCpG.txt | sort -g | head -n51 | tail -n1 )

MedianThree=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

echo -e "$Median\t$MedianTwo\t$MedianThree" >> ../../../../Results/ABCResults/MedianResultsPopExpansion.txt

done

############ 4Ns = 0


rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpG.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowDistanceNotCpG.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGZero.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGFifty.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGHundred.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGBoyko.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/AllLeftParametersNotCpG.txt

for (( i = 1 ; i <= 2000 ; i++ ))
do

File="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowDistanceOutNotCpG"$i".txt"
MismatchFileZero="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowMismatchNotCpG4Ns_0"$i".txt"
MismatchFileFifty="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowMismatchNotCpG4Ns_50"$i".txt"
MismatchFileHundred="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowMismatchNotCpG4Ns_100"$i".txt"
MismatchFileBoyko="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowMismatchNotCpGBoykoDFE"$i".txt"
ParsFile="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/LeftParameters"$i".txt"
NumberOfLines=$( wc -l $File | awk '{print $1}')

MinusOneLines=$(( $NumberOfLines ))

head -n$MinusOneLines $File >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowDistanceNotCpG.txt

head -n$MinusOneLines $MismatchFileZero >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGZero.txt
head -n$MinusOneLines $MismatchFileFifty >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGFifty.txt
head -n$MinusOneLines $MismatchFileHundred >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGHundred.txt
head -n$MinusOneLines $MismatchFileBoyko >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGBoyko.txt

head -n$MinusOneLines $ParsFile >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/AllLeftParametersNotCpG.txt

done


paste -d "\t" ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/AllLeftParametersNotCpG.txt ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGZero.txt ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowDistanceNotCpG.txt  > ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpGZero.txt

paste -d "\t" ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/AllLeftParametersNotCpG.txt ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGFifty.txt ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowDistanceNotCpG.txt  > ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpGFifty.txt

paste -d "\t" ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/AllLeftParametersNotCpG.txt ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGHundred.txt ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowDistanceNotCpG.txt  > ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpGHundred.txt

paste -d "\t" ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/AllLeftParametersNotCpG.txt ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGBoyko.txt ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowDistanceNotCpG.txt  > ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpGBoyko.txt

sort -k 4,4 ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpGZero.txt | head -n100 > ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGZero.txt
sort -k 4,4 ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpGFifty.txt | head -n100 > ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGFifty.txt
sort -k 4,4 ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpGHundred.txt | head -n100 > ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGHundred.txt
sort -k 4,4 ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpGBoyko.txt | head -n100 > ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt
# cp ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpG.txt ../../../../Results/ABCResults/Best100NotCpGPopExpansion$j.txt

ValueOne=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGZero.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGZero.txt | sort -g | head -n51 | tail -n1 )

Median=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGZero.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGZero.txt | sort -g | head -n51 | tail -n1 )

MedianTwo=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGZero.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGZero.txt | sort -g | head -n51 | tail -n1 )

MedianThree=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

echo -e "$Median\t$MedianTwo\t$MedianThree" >> ../../../../Results/ABCResults/MedianResultsPopExpansionSLiM.txt


ValueOne=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGFifty.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGFifty.txt | sort -g | head -n51 | tail -n1 )

Median=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGFifty.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGFifty.txt | sort -g | head -n51 | tail -n1 )

MedianTwo=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGFifty.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGFifty.txt | sort -g | head -n51 | tail -n1 )

MedianThree=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

echo -e "$Median\t$MedianTwo\t$MedianThree" >> ../../../../Results/ABCResults/MedianResultsPopExpansionSLiM.txt


ValueOne=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGHundred.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGHundred.txt | sort -g | head -n51 | tail -n1 )

Median=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGHundred.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGHundred.txt | sort -g | head -n51 | tail -n1 )

MedianTwo=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGHundred.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGHundred.txt | sort -g | head -n51 | tail -n1 )

MedianThree=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

echo -e "$Median\t$MedianTwo\t$MedianThree" >> ../../../../Results/ABCResults/MedianResultsPopExpansionSLiM.txt


ValueOne=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n51 | tail -n1 )

Median=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n51 | tail -n1 )

MedianTwo=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n51 | tail -n1 )

MedianThree=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

echo -e "$Median\t$MedianTwo\t$MedianThree" >> ../../../../Results/ABCResults/MedianResultsPopExpansionSLiM.txt




