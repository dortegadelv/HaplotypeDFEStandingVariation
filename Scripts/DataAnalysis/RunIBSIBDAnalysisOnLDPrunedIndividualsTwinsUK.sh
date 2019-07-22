#$ -l h_vmem=4g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

InputFile="../../Data/Plink/PlinkReduced"$SGE_TASK_ID
OutputFile="../../Data/Plink/GenomeIBSIBD"$SGE_TASK_ID
PrunedSNPs="../../Data/Plink/PlinkPrunedSNPs"$SGE_TASK_ID".prune.in"

plink --bfile $InputFile --keep IndividualsFromTwinsUKCohort.txt --allow-no-sex --missing-genotype 8 --extract $PrunedSNPs --genome --min 0.1 --out $OutputFile


