#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

Directories[1]="/scratch/midway2/diegoortega/ConstantPopSizeBoyko/"
Directories[2]="/scratch/midway2/diegoortega/ConstantPopSizeMouse/"
Directories[3]="/scratch/midway2/diegoortega/PopExpansionBoyko/"
Directories[4]="/scratch/midway2/diegoortega/PopExpansionMouse/"

Theta[1]="40.0"
Theta[2]="130.0"
Theta[3]="18.0"
Theta[4]="60.0"

DirNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 100 + 1 ))
Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 100 + 1 ))

if [ $SLURM_ARRAY_TASK_ID -le 200  ]
then

CurrentFile=${Directories[$DirNumber]}"OutputSmall."$Repetition".resampledsfs.txt"
ThetaFileCount=${Directories[$DirNumber]}"OutputSmall."$Repetition".numberfileresampledsfs.txt"
LLSelectionFile=${Directories[$DirNumber]}"OutputSmall."$Repetition".MaxLL.txt"
echo $CurrentFile
time python EstimateDFE_PartTwoSmall.py $CurrentFile ${Theta[$DirNumber]} $LLSelectionFile

else


CurrentFile=${Directories[$DirNumber]}"OutputSmall."$Repetition".resampledsfs.txt"
ThetaFileCount=${Directories[$DirNumber]}"OutputSmall."$Repetition".numberfileresampledsfs.txt"
LLSelectionFile=${Directories[$DirNumber]}"OutputSmall."$Repetition".MaxLL.txt"

echo $CurrentFile
time python EstimateDFEPopExpansion_PartTwoSmall.py $CurrentFile ${Theta[$DirNumber]} $LLSelectionFile

fi

