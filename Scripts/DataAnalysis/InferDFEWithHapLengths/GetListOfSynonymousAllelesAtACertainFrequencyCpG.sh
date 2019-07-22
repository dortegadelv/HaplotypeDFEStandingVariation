#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

InputFile="../../../Data/Plink/PlinkFrequencyAnnotationAncestralAlleleCpG"$SGE_TASK_ID".frq"
OutputFile="../../../Data/Plink/SynonymousOnePercentCpG"$SGE_TASK_ID".frq"
perl GetListOfSynonymousAllelesAtACertainFrequencyCpG.pl 0.0095 0.0105 $InputFile $OutputFile

