#$ -l h_vmem=4g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

PlinkFile="../../../Data/Plink/Plink"$SGE_TASK_ID
PlinkOut="../../../Data/Plink/PlinkReduced"$SGE_TASK_ID
PlinkTFileOut="../../../Data/Plink/PlinkTFileReduced"$SGE_TASK_ID
# plink --tfile $PlinkFile --make-bed --out $PlinkOut --allow-no-sex --missing-genotype 8 --keep ../../Data/ListUnrelatedSamplesUK10K_3781-samples_annotated_release_20130515.txt
plink --tfile $PlinkFile --allow-no-sex --out $PlinkOut --missing-genotype 8 --keep ../../../Data/ListUnrelatedSamplesUK10K_3781-samples_annotated_release_20130515.txt --freq


