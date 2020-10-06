#$ -l express,h_rt=2:00:00
#$ -cwd
#$ -A diegoort
#$ -N ForWF

GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z8 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -N1000 -n20 -RConstantSizeDemHist.txt -S0 /u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/

# perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.2/full_out.run.2.num.$SGE_TASK_ID.N.10000.h.0.500000.F.0.000000.txt TestData/run.2/Alleles$SGE_TASK_ID.txt 0 250000

# GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -A10000 -a250000 -B0 -b0 -C0 -c0 -m1000 -t$SGE_TASK_ID -z2 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -TTestData/run.2/Alleles$SGE_TASK_ID.txt TestData/run.2/Traj_0.01_$SGE_TASK_ID.txt -n20 -S0 /u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/TestData/
