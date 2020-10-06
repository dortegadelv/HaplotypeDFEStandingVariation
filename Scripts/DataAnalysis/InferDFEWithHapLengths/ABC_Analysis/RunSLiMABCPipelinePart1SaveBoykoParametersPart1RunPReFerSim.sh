i=$1

Directory[1]="PopExpansionChangedRecRate"
Directory[2]="PopExpansionChangedRecRate4Ns50"
Directory[3]="PopExpansionChangedRecRate4Ns100"
Directory[4]="PopExpansionChangedRecRateBoykoDFE"

ExitFile[1]="LDistributionPopExpansionSLiM4Ns0.txt"
ExitFile[2]="LDistributionPopExpansionSLiM4Ns50.txt"
ExitFile[3]="LDistributionPopExpansionSLiM4Ns100.txt"
ExitFile[4]="LDistributionPopExpansionSLiMBoykoDFE.txt"

for j in {4..4}
do

SynLDFile="../../../Sims/SLiM/PopExpansion/"${Directory[$j]}"/LDistributionSynSitesRand"$i".txt"

FractionOne=$( head -n1 $SynLDFile | tail -n1 )
FractionTwo=$( head -n2 $SynLDFile | tail -n1 )
FractionThree=$( head -n3 $SynLDFile | tail -n1 )
FractionFour=$( head -n4 $SynLDFile | tail -n1 )
FractionFive=$( head -n5 $SynLDFile | tail -n1 )
FractionSix=$( head -n6 $SynLDFile | tail -n1 )

Sum=$(( $FractionOne + $FractionTwo + $FractionThree + $FractionFour + $FractionFive + $FractionSix))

PartOne=$(  echo "scale=15 ; ( $FractionOne ) / $Sum" | bc  )
PartTwo=$(  echo "scale=15 ; ( $FractionTwo ) / $Sum" | bc  )
PartThree=$(  echo "scale=15 ; ( $FractionThree ) / $Sum" | bc  )
PartFour=$(  echo "scale=15 ; ( $FractionFour ) / $Sum" | bc  )
PartFive=$(  echo "scale=15 ; ( $FractionFive ) / $Sum" | bc  )
PartSix=$(  echo "scale=15 ; ( $FractionSix ) / $Sum" | bc  )

echo -e "$PartOne\t$PartTwo\t$PartThree\t$PartFour\t$PartFive\t$PartSix" > ${ExitFile[$j]}

done

perl CalculateMismatchStatisticSLiMBoykoDFE_NotCpG.pl

### Run bash shell instructions



rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpG.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowDistanceNotCpG.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGZero.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGFifty.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGHundred.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGBoyko.txt
rm ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/AllLeftParametersNotCpG.txt

for (( j = 1 ; j <= 5000 ; j++ ))
do
echo "j = "$j
File="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowDistanceOutNotCpG"$j".txt"
MismatchFileZero="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowMismatchNotCpG4Ns_0"$j".txt"
MismatchFileFifty="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowMismatchNotCpG4Ns_50"$j".txt"
MismatchFileHundred="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowMismatchNotCpG4Ns_100"$j".txt"
MismatchFileBoyko="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowMismatchNotCpGBoykoDFE"$j".txt"
ParsFile="../../../../Results/ABCAnalysisPopExpansionLessFiveFold/LeftParameters"$j".txt"
NumberOfLines=$( wc -l $File | awk '{print $1}')

MinusOneLines=$(( $NumberOfLines ))

head -n$MinusOneLines $File >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowDistanceNotCpG.txt

# head -n$MinusOneLines $MismatchFileZero >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGZero.txt
# head -n$MinusOneLines $MismatchFileFifty >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGFifty.txt
# head -n$MinusOneLines $MismatchFileHundred >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGHundred.txt
head -n$MinusOneLines $MismatchFileBoyko >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGBoyko.txt

head -n$MinusOneLines $ParsFile >> ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/AllLeftParametersNotCpG.txt

done

paste -d "\t" ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/AllLeftParametersNotCpG.txt ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowMismatchNotCpGBoyko.txt ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/AllWindowDistanceNotCpG.txt  > ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpGBoyko.txt

sort -k 4,4 ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/ParametersAndStatisticsNotCpGBoyko.txt | head -n100 > ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt
# cp ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpG.txt ../../../../Results/ABCResults/Best100NotCpGPopExpansion$j.txt
# rm ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt

rm ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt

ValueOne=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $1}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n51 | tail -n1 )

Median=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $2}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n51 | tail -n1 )

MedianTwo=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

ValueOne=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n50 | tail -n1 )
ValueTwo=$( awk '{print $3}' ../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Best100NotCpGBoyko.txt | sort -g | head -n51 | tail -n1 )

MedianThree=$(  echo "scale=15 ; ( $ValueOne + $ValueTwo ) / 2" | bc  )

echo -e "$Median\t$MedianTwo\t$MedianThree" >> ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt


Dir="ForwardSimsBoyko"$i

### End of running bash shell instructions
j=4

cd ../../../DataAnalysis/InferDFEWithHapLengths/ABC_Analysis/

NOne=$( head -n$j ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt | tail -n1 | awk '{print $1}' )
NOneInt=$( head -n$j ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt | tail -n1 | awk '{print $1}' |  awk '{print int($1+0.5)}' )
NTwo=$( head -n$j ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt | tail -n1 | awk '{print $2}' )
Time=$( head -n$j ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt | tail -n1 |  awk '{print int($3+0.5)}' )
TwoN=$( echo "scale=15 ; $NOne * 2" | bc | awk '{print int($1+0.5)}' )
TwoNOne=$( echo "scale=15 ; $NTwo * 2" | bc | awk '{print int($1+0.5)}' )
BurnTime=$( echo "scale=15 ; $NTwo * 10" | bc | awk '{print int($1+0.5)}' )

FractionOne=$(  echo "scale=15 ; $NTwo / $NOne" | bc )
FractionTwo=$(  echo "scale=15 ; $Time / ( 4 * $NOne )" | bc )
OneOverFourNs=$(  echo "scale=15 ; 1 / ( 4 * $NOne )" | bc )

Theta=$( echo "scale=15 ; 4 * $NOne * 0.000000012 * 5 * 250000" | bc )

export TwoN
export FractionOne
export FractionTwo
export OneOverFourNs
export NOne
export NOneInt
export Theta
export i
echo "$j = $TwoN $FractionOne $FractionTwo $OneOverFourNs $NOne $NOneInt $Theta"
# perl -pi -e 's/-N (.+) -s/-N $ENV{TwoN} -s/' ../../../Sims/PopExpansion/${ImpDir[$j]}/RunImportanceSamplingPopulationExpansion.sh
# perl -pi -e 's/eN (.+) (.+) 0/eN $ENV{FractionTwo} $ENV{FractionOne} 0/ if $. == 2' ../../../Sims/PopExpansion/${ImpDir[$j]}/DemHistExpansion.txt
# perl -pi -e 's/SelectionCoef = -(.+);/SelectionCoef = -$ENV{OneOverFourNs};/ if $. == 5' ../../../Sims/PopExpansion/${ImpDir[$j]}/CreateNewSelectionValues.pl
# perl -pi -e 's/SelectionCoef = (.+);/SelectionCoef = $ENV{OneOverFourNs};/ if $. == 12' ../../../Sims/PopExpansion/${ImpDir[$j]}/CreateNewSelectionValues.pl



mkdir ../../../Sims/PopExpansion/$Dir/
cp ../../../Sims/PopExpansionMousePlusPositive/ForwardSims/ParameterFileMouseFiveFold.txt ../../../Sims/PopExpansion/$Dir/ParameterFileMouseFiveFold.txt
cd ../../../Sims/PopExpansion/$Dir/

echo '#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFileMouseFiveFold.txt $SLURM_ARRAY_TASK_ID
' > RunScript.sh

mkdir ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart$i

perl -pi -e 's/MousePart/MousePart$ENV{i}/' ParameterFileMouseFiveFold.txt

echo "$TwoNOne $BurnTime
$TwoN $Time" > PopulationExpansionModel.txt

sbatch --array=1-400 RunScript.sh
# perl CreateNewSelectionValues.pl
# sbatch --array=601-700 RunImportanceSamplingPopulationExpansion.sh




