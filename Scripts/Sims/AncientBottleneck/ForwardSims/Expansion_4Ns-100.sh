#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=02:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns-100.txt $SLURM_ARRAY_TASK_ID

time perl ../../ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 ../../../../Results/AncientBottleneck/ForwardSims/4Ns_-100/Output.$SLURM_ARRAY_TASK_ID.full_out.txt ../../../../Results/AncientBottleneck/ForwardSims/4Ns_-100/Alleles_$SLURM_ARRAY_TASK_ID.txt 0 80100

File="../../../../Results/AncientBottleneck/ForwardSims/4Ns_-100/Output."$SLURM_ARRAY_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns-100_B.txt $SLURM_ARRAY_TASK_ID



### Old stuff
# time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SLURM_ARRAY_TASK_ID -z5 -gpoint 0.0025 -f1.0 -h0.5 -F0.0 -n20 -RPopulationBottleneckModel.txt -S0 TestData/

# time perl ../../../ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.0099 0.0101 TestData/run.5/full_out.run.5.num.$SLURM_ARRAY_TASK_ID.N.10000.h.0.500000.F.0.000000.txt TestData/run.5/Alleles$SLURM_ARRAY_TASK_ID.txt 0 80100

# time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SLURM_ARRAY_TASK_ID -z5 -gpoint 0.0025 -f1.0 -h0.5 -F0.0 -n20 -RPopulationBottleneckModel.txt -S0 -TTestData/run.5/Alleles$SLURM_ARRAY_TASK_ID.txt TestData/run.5/Traj_0.01_$SLURM_ARRAY_TASK_ID.txt TestData/

# FileToDelete="TestData/run.5/dog_out.run.5.num."$SLURM_ARRAY_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

# FileToDelete="TestData/run.5/full_out.run.5.num."$SLURM_ARRAY_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

# FileToDelete="TestData/run.5/sfs_out.run.5.num."$SLURM_ARRAY_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

