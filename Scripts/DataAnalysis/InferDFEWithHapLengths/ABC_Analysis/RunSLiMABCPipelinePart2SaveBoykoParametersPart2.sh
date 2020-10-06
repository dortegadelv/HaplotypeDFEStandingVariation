i=$1


ImpDir[1]="ImportanceSamplingSimsZero"
ImpDir[2]="ImportanceSamplingSimsFifty"
ImpDir[3]="ImportanceSamplingSimsHundred"
ImpDir[4]="ImportanceSamplingSimsBoyko"

j=$i
## Part 2

cd ../../../DataAnalysis/InferDFEWithHapLengths/ABC_Analysis/

NOne=$( head -n1 ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt | tail -n1 | awk '{print $1}' )
NOneInt=$( head -n1 ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt | tail -n1 | awk '{print $1}' |  awk '{print int($1+0.5)}' )
NTwo=$( head -n1 ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt | tail -n1 | awk '{print $2}' )
Time=$( head -n1 ../../../../Results/ABCResults/MedianResultsPopExpansionSLiMBoyko.txt | tail -n1 | awk '{print $3}' )
TwoN=$( echo "scale=15 ; $NOne * 2" | bc | awk '{print int($1+0.5)}' )

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

cd ../../../Sims/PopExpansion/${ImpDir[4]}/

perl -pi -e 's/One 1000 (.+)/One 1000 $ENV{NOneInt}/' TransformTrajectoriesToMsselFormat.sh
sbatch TransformTrajectoriesToMsselFormat.sh


