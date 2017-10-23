### Old code

SGE_TASK_ID=1
GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m10 -t11 -z1 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RBottleneck.txt -S1 1 Test/

perl GetListOfRunsWhereFrequencyMatches.pl 0.0 0.1 Test/run.1/full_out.run.1.num.11.N.1000.h.0.500000.F.0.000000.txt Test/run.1/Alleles11.txt 0 25100

GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m10 -t11 -z1 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -TTest/run.1/Alleles11.txt Test/run.1/Traj_11.txt -n20 -RBottleneck.txt -S1 1 Test/

perl TrajToMsselFormat.pl Test/run.1/Traj_ 100 Test/run.1/AllTrajs.txt 4 0 11 11

### New code

GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile11.txt 11

perl GetListOfRunsWhereFrequencyMatches.pl 0.0 0.1 MiniTest/Output.11.full_out.txt MiniTest/Alleles11.txt 0 25100

GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile11_B.txt 11

perl TrajToMsselFormat.pl MiniTest/Traj_ 100 MiniTest/AllTrajs.txt 4 0 11 11

diff MiniTest/AllTrajs.txt Test/run.1/AllTrajs.txt


