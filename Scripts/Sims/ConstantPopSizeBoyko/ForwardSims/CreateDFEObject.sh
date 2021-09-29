#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=02:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

Directories[1]="/scratch/midway2/diegoortega/ConstantPopSizeBoyko/"
Directories[2]="/scratch/midway2/diegoortega/ConstantPopSizeMouse/"
Directories[3]="/scratch/midway2/diegoortega/PopExpansionBoyko/"
Directories[4]="/scratch/midway2/diegoortega/PopExpansionMouse/"

DirNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 100 + 1 ))
Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 100 + 1 ))

if [ $SLURM_ARRAY_TASK_ID -le 1  ]
then

CurrentFile=${Directories[$DirNumber]}"Output."$Repetition".numberfileresampledsfs.txt"
echo $CurrentFile
time python EstimateDFE.py 1 1 1

else

CurrentFile=${Directories[$DirNumber]}"Output."$Repetition".numberfileresampledsfs.txt"
echo $CurrentFile
time python EstimateDFEPopExpansion.py 1 1 1

fi

