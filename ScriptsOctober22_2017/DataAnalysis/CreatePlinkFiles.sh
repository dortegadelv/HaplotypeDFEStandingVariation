#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

perl CreatePlinkFiles.pl $SGE_TASK_ID
