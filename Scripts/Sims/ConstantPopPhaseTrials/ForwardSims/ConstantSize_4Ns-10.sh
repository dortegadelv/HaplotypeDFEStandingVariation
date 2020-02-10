#$ -l h_vmem=2g
#$ -cwd


#$ -N ForWF

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z4 -gpoint 0.00025 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 /u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/

time perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.4/full_out.run.4.num.$SGE_TASK_ID.N.20000.h.0.500000.F.0.000000.txt TestData/run.4/Alleles$SGE_TASK_ID.txt 0 160000

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z4 -gpoint 0.00025 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 -TTestData/run.4/Alleles$SGE_TASK_ID.txt TestData/run.4/Traj_0.01_$SGE_TASK_ID.txt /u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/TestData/
