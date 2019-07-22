#$ -l h_vmem=4g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

InputFile="../../Data/Plink/PlinkReduced"$SGE_TASK_ID
OutputFile="../../Data/Plink/PlinkPrunedSNPs"$SGE_TASK_ID

plink --bfile $InputFile --keep IndividualsFromTwinsUKCohort.txt --indep-pairwise 3000 1000 0.2 --out $OutputFile 
