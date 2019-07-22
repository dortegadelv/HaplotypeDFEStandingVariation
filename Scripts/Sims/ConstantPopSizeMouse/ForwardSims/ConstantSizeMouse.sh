#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash


time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFileMouse.txt $SGE_TASK_ID

time perl ../../ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 ../../../../Results/ConstantPopSizeMouse/ForwardSims/Output.$SGE_TASK_ID.full_out.txt ../../../../Results/ConstantPopSizeMouse/ForwardSims/Alleles_$SGE_TASK_ID.txt 0 160000

File="../../../../Results/ConstantPopSizeMouse/ForwardSims/Output."$SGE_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFileMouse_B.txt $SGE_TASK_ID

# time perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.2/full_out.run.2.num.$SGE_TASK_ID.N.20000.h.0.500000.F.0.000000.txt TestData/run.2/Alleles$SGE_TASK_ID.txt 0 160000

# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z2 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 -TTestData/run.2/Alleles$SGE_TASK_ID.txt TestData/run.2/Traj_0.01_$SGE_TASK_ID.txt /u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/TestData/
