#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

perl CalculateFrequenciesSynonymousSites.pl $SGE_TASK_ID
