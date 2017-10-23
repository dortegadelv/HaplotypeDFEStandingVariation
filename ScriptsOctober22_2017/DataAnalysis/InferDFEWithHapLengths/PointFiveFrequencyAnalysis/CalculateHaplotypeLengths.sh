#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

perl CalculateHaplotypeLengths.pl $SGE_TASK_ID
