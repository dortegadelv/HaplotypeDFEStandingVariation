#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

InputFile="../../../Data/Plink/PlinkFrequencyAnnotationAncestralAllele"$SGE_TASK_ID".frq"
OutputFile="../../../Data/Plink/MissensePointFivePercent"$SGE_TASK_ID".frq"
perl GetListOfMissenseAllelesAtACertainFrequency.pl 0.0015 0.0025 $InputFile $OutputFile
