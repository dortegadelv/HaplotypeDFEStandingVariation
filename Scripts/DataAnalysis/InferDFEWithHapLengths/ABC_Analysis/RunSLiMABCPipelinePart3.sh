i=$1

ImpDir[1]="ImportanceSamplingSimsZero"
ImpDir[2]="ImportanceSamplingSimsFifty"
ImpDir[3]="ImportanceSamplingSimsHundred"
ImpDir[4]="ImportanceSamplingSimsBoyko"


### Part 3
for j in {1..4}
do

cd ../../../DataAnalysis/InferDFEWithHapLengths/ABC_Analysis/

NOne=$( head -n$j ../../../../Results/ABCResults/MedianResultsPopExpansionSLiM.txt | tail -n1 | awk '{print $1}' )
NOneInt=$( head -n$j ../../../../Results/ABCResults/MedianResultsPopExpansionSLiM.txt | tail -n1 | awk '{print $1}' |  awk '{print int($1+0.5)}' )
NTwo=$( head -n$j ../../../../Results/ABCResults/MedianResultsPopExpansionSLiM.txt | tail -n1 | awk '{print $2}' )
Time=$( head -n$j ../../../../Results/ABCResults/MedianResultsPopExpansionSLiM.txt | tail -n1 |  awk '{print $3}' )
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

# cd ../../../DataAnalysis/InferDFEWithHapLengths/ABC_Analysis/
cd ../../../Sims/PopExpansion/${ImpDir[$j]}/


perl -pi -e 's/TrajectoryPartMssel.pl $File $i $ExitMssel (.+)/TrajectoryPartMssel.pl $File $i $ExitMssel $ENV{NOneInt}/' RunMsselCalculateDistance10000.sh
perl -pi -e 's/-t (.+) -eN 0.0 1.0 -eN (.+) (.+) -seeds/-t $ENV{Theta} -eN 0.0 1.0 -eN $ENV{FractionTwo} $ENV{FractionOne} -seeds/' RunMsselCalculateDistance10000.sh

sbatch --array=1-991:10 RunMsselCalculateDistance10000.sh

done

