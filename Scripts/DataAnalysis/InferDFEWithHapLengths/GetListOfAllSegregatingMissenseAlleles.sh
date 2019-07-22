#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

InputFile="../../../Data/Plink/PlinkFrequencyAnnotationAncestralAllele"$SGE_TASK_ID".frq"
OutputFile="../../../Data/Plink/MissenseAllAlleles"$SGE_TASK_ID".frq"
perl GetListOfMissenseAllelesAtACertainFrequency.pl 0.00 1.0 $InputFile $OutputFile

