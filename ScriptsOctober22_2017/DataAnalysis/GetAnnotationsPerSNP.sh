#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

perl GetAnnotationsPerSNP.pl $SGE_TASK_ID
