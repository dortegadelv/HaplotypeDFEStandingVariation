#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o Trash
#$ -e Trash

InputFile="../../../Data/Plink/PlinkFrequencyAnnotationAncestralAlleleCpG"$SGE_TASK_ID".frq"
OutputFile="../../../Data/Plink/MissenseOnePercentCpG"$SGE_TASK_ID".frq"
perl GetListOfMissenseAllelesAtACertainFrequencyCpG.pl 0.0095 0.0105 $InputFile $OutputFile

