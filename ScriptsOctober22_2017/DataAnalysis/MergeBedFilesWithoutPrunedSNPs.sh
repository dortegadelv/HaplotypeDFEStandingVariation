#$ -l h_vmem=4g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

cat ../../Data/Plink/PlinkPrunedSNPs{1..22}.prune.in > ../../Data/Plink/AllPrunedSNPs.txt
plink --bfile ../../Data/Plink/PlinkReduced1 --merge-list AllFiles.txt --keep IndividualsFromTwinsUKCohort.txt --extract ../../Data/Plink/AllPrunedSNPs.txt --make-bed --out ../../Data/Plink/PlinkReducedMerged
