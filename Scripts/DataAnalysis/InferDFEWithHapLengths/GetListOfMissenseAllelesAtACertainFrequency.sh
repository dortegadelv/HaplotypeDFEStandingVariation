#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

InputFile="../../../Data/Plink/PlinkFrequencyAnnotationAncestralAllele"$SGE_TASK_ID".frq"
OutputFile="../../../Data/Plink/MissenseOnePercent"$SGE_TASK_ID".frq"
perl GetListOfMissenseAllelesAtACertainFrequency.pl 0.0095 0.0105 $InputFile $OutputFile

