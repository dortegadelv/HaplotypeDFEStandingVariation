#$ -l h_vmem=2g
#$ -cwd


#$ -N ForWF
#$ -o ../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/Trash
#$ -e ../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/Trash

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns50.txt $SGE_TASK_ID

time perl ../../ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 ../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/Output.$SGE_TASK_ID.full_out.txt ../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/Alleles_$SGE_TASK_ID.txt 0 80100

File="../../../../Results/RecentBottleneck/ForwardSims/4Ns_50/Output."$SGE_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns50_B.txt $SGE_TASK_ID



### Old stuff

# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z8 -gpoint -0.0025 -f1.0 -h0.5 -F0.0 -n20 -RPopulationBottleneckModel.txt -S0 TestData/

# time perl ../../../ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.0099 0.0101 TestData/run.8/full_out.run.8.num.$SGE_TASK_ID.N.10000.h.0.500000.F.0.000000.txt TestData/run.8/Alleles$SGE_TASK_ID.txt 0 80100

# time GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ../fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z8 -gpoint -0.0025 -f1.0 -h0.5 -F0.0 -n20 -RPopulationBottleneckModel.txt -S0 -TTestData/run.8/Alleles$SGE_TASK_ID.txt TestData/run.8/Traj_0.01_$SGE_TASK_ID.txt TestData/

# FileToDelete="TestData/run.8/dog_out.run.8.num."$SGE_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

# FileToDelete="TestData/run.8/full_out.run.8.num."$SGE_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

# FileToDelete="TestData/run.8/sfs_out.run.8.num."$SGE_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

