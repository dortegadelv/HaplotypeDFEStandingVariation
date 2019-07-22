#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_100/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_100/Trash


time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns100.txt $SGE_TASK_ID

time perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 ../../../../Results/ConstantPopSize/ForwardSims/4Ns_100/Output.$SGE_TASK_ID.full_out.txt ../../../../Results/ConstantPopSize/ForwardSims/4Ns_100/Alleles_$SGE_TASK_ID.txt 0 160000

File="../../../../Results/ConstantPopSize/ForwardSims/4Ns_100/Output."$SGE_TASK_ID".full_out.txt"

rm $File


time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns100_B.txt $SGE_TASK_ID


# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z11 -gpoint -0.0025 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/

# time perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.11/full_out.run.11.num.$SGE_TASK_ID.N.20000.h.0.500000.F.0.000000.txt TestData/run.11/Alleles$SGE_TASK_ID.txt 0 160000

# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z11 -gpoint -0.0025 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 -TTestData/run.11/Alleles$SGE_TASK_ID.txt TestData/run.11/Traj_0.01_$SGE_TASK_ID.txt /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/