i=$1


ImpDir[1]="ImportanceSamplingSimsZero"
ImpDir[2]="ImportanceSamplingSimsFifty"
ImpDir[3]="ImportanceSamplingSimsHundred"
ImpDir[4]="ImportanceSamplingSimsBoyko"


for j in {4..4}
do
cd ../../../DataAnalysis/InferDFEWithHapLengths/ABC_Analysis/
cd ../../../Sims/PopExpansion/${ImpDir[$j]}/

perl SumDistances10000.pl
sbatch CreateNewP_L_Given_S_Table.sh

done


