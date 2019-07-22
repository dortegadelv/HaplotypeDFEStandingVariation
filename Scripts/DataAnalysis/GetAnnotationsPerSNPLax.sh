#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

perl GetAnnotationsPerSNPLax.pl $SGE_TASK_ID
