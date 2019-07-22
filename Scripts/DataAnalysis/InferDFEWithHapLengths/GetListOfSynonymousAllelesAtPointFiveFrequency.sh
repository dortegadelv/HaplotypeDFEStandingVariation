#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

InputFile="../../../Data/Plink/PlinkFrequencyAnnotationAncestralAllele"$SGE_TASK_ID".frq"
OutputFile="../../../Data/Plink/SynonymousPointFivePercent"$SGE_TASK_ID".frq"
perl GetListOfSynonymousAllelesAtACertainFrequency.pl 0.0015 0.0025 $InputFile $OutputFile

