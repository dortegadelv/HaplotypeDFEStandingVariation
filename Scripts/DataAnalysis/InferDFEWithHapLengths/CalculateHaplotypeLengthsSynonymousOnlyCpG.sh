#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

## These calculations will be done removing synonymous sites that appear only once in the sample of derived alleles
perl CalculateHaplotypeLengthsSynonymousOnlyCpG.pl $SGE_TASK_ID
