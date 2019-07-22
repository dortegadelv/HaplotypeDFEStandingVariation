#$ -l h_vmem=2g
#$ -cwd


#$ -N ForWF
#$ -o ../../../../Results/UK10K/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/UK10K/ForwardSims/4Ns_0/Trash

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns-100HighPop.txt $SGE_TASK_ID

time perl ../../ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.0095 0.0105 ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_-100/Output.$SGE_TASK_ID.full_out.txt ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_-100/Alleles_$SGE_TASK_ID.txt 0 24834

File="../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_-100/Output."$SGE_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns-100HighPop_B.txt $SGE_TASK_ID



## Old stuff
# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z2 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RPopulationBottleneckModel.txt -S0 TestData/

# time perl ../../../ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.0099 0.0101 TestData/run.2/full_out.run.2.num.$SGE_TASK_ID.N.10000.h.0.500000.F.0.000000.txt TestData/run.2/Alleles$SGE_TASK_ID.txt 0 122220

# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z2 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RPopulationBottleneckModel.txt -S0 -TTestData/run.2/Alleles$SGE_TASK_ID.txt TestData/run.2/Traj_0.01_$SGE_TASK_ID.txt TestData/

# FileToDelete="TestData/run.2/dog_out.run.2.num."$SGE_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

# FileToDelete="TestData/run.2/full_out.run.2.num."$SGE_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

# FileToDelete="TestData/run.2/sfs_out.run.2.num."$SGE_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete
