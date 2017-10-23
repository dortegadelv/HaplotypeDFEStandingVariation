#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSizePointFivePercent/ForwardSims/4Ns_50/Trash
#$ -e ../../../../Results/ConstantPopSizePointFivePercent/ForwardSims/4Ns_50/Trash

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns50.txt $SGE_TASK_ID

time perl GetListOfRunsWhereFrequencyMatches.pl 0.005 0.005 ../../../../Results/ConstantPopSizePointFivePercent/ForwardSims/4Ns_50/Output.$SGE_TASK_ID.full_out.txt ../../../../Results/ConstantPopSizePointFivePercent/ForwardSims/4Ns_50/Alleles_$SGE_TASK_ID.txt 0 160000

File="../../../../Results/ConstantPopSizePointFivePercent/ForwardSims/4Ns_50/Output."$SGE_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns50_B.txt $SGE_TASK_ID


# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z10 -gpoint -0.00125 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/

# time perl GetListOfRunsWhereFrequencyMatches.pl 0.005 0.005 TestData/run.10/full_out.run.10.num.$SGE_TASK_ID.N.20000.h.0.500000.F.0.000000.txt TestData/run.10/Alleles$SGE_TASK_ID.txt 0 160000

# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z10 -gpoint -0.00125 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 -TTestData/run.10/Alleles$SGE_TASK_ID.txt TestData/run.10/Traj_0.005_$SGE_TASK_ID.txt /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/
