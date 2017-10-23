#$ -l h_vmem=2g
#$ -cwd


#$ -N ForWF
#$ -o /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/ChangingPopulationSizeAfricanPop_June24_2015/Trash
#$ -e /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/ChangingPopulationSizeAfricanPop_June24_2015/Trash

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z3 -gpoint 0.00025 -f1.0 -h0.5 -F0.0 -n20 -RPopulationExpansionModel.txt -S0 TestData/

time perl ../../../ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.0099 0.00501 TestData/run.3/full_out.run.3.num.$SGE_TASK_ID.N.10000.h.0.500000.F.0.000000.txt TestData/run.3/Alleles$SGE_TASK_ID.txt 0 80100

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z3 -gpoint 0.00025 -f1.0 -h0.5 -F0.0 -n20 -RPopulationExpansionModel.txt -S0 -TTestData/run.3/Alleles$SGE_TASK_ID.txt TestData/run.3/Traj_0.005_$SGE_TASK_ID.txt TestData/

FileToDelete="TestData/run.3/dog_out.run.3.num."$SGE_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
rm $FileToDelete

FileToDelete="TestData/run.3/full_out.run.3.num."$SGE_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
rm $FileToDelete

FileToDelete="TestData/run.3/sfs_out.run.3.num."$SGE_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
rm $FileToDelete

