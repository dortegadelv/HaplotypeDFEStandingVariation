#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/Trash
#$ -e ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/Trash

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns-100.txt $SGE_TASK_ID

time perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/Output.$SGE_TASK_ID.full_out.txt ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/Alleles_$SGE_TASK_ID.txt 0 160000

File="../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/Output."$SGE_TASK_ID".full_out.txt"

rm $File


time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns-100_B.txt $SGE_TASK_ID



## Old stuff
# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z6 -gpoint 0.0025 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 /u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/

# time perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.6/full_out.run.6.num.$SGE_TASK_ID.N.20000.h.0.500000.F.0.000000.txt TestData/run.6/Alleles$SGE_TASK_ID.txt 0 160000

# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z6 -gpoint 0.0025 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 -TTestData/run.6/Alleles$SGE_TASK_ID.txt TestData/run.6/Traj_0.01_$SGE_TASK_ID.txt /u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/TestData/
