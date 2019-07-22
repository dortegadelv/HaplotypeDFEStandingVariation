#$ -l h_rt=24:00:00
#$ -cwd
#$ -A diegoort
#$ -N ForWF

# mkdir TargetFolder/
# mkdir TargetFolder/run.2
GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m10000 -t$SGE_TASK_ID -z2 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RCharlestonScenario.txt -N2162 -S0 TargetFolder/
# perl GetListOfRunsWhereFrequencyMatches.pl 0.1005 0.1010 TargetFolder/run.2/full_out.run.2.num.1.N.53092.h.0.500000.F.0.000000.txt TargetFolder/run.2/AllelesCharleston$SGE_TASK_ID.txt 0 36786
# GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z2 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RCharlestonScenario.txt -TTargetFolder/run.2/AllelesCharleston$SGE_TASK_ID.txt TargetFolder/run.2/Traj_0.10_0.txt -S0 TargetFolder/
