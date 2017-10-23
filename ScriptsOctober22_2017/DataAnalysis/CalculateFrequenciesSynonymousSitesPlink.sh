#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

PlinkFile="../../Data/Plink/PlinkReduced"$SGE_TASK_ID
FreqFile="../../Data/Plink/PlinkFreq"$SGE_TASK_ID
SynSites="../../Data/Plink/SynSites"$SGE_TASK_ID".txt"
plink --bfile $PlinkFile --out $FreqFile --extract $SynSites --freq --allow-no-sex --missing-genotype 8
