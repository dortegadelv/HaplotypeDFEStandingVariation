#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=02:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


Start=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) * 1 + 1 ))
End=$(( ( $SLURM_ARRAY_TASK_ID ) * 1 ))

# Directory="../../../../Results/ConstantPopSizeBoyko/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/"
# ResultsFile="../../../../Results/ConstantPopSizeBoyko/ForwardSims/"${FourNs[$SGE_TASK_ID]}"/HapLengths/ExitFileNoRecN"${NumberOfMarkers[$k]}".txt"
# rm $ResultsFile
for (( i = $Start ; i <= $End ; i++ ))
do
HapFile="../../../../Results/ConstantPopSizeMouse/ForwardSims/HapLengths/HapLengths"$i".txt"
ResultsFile="../../../../Results/ConstantPopSizeMouse/ForwardSims/HapLengths/ExitFileNoRecSmallN"$i".txt"
rm $ResultsFile

perl ../../ConstantPopSize/ForwardSims/CalculatePLengthGivenS.pl $HapFile 250000 ../../../../Results/ConstantPopSizeBoyko/ImportanceSampling/DFETableToTestSmall.txt ../ImportanceSamplingSims/TestT2Bounds.txt $ResultsFile
done


