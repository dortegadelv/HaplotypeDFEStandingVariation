#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns0_99PercentFreqAllele.txt $SLURM_ARRAY_TASK_ID

time perl GetListOfRunsWhereFrequencyMatches.pl 0.99 0.99 ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Output.$SLURM_ARRAY_TASK_ID.full_out.txt ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Alleles_$SLURM_ARRAY_TASK_ID.txt 0 160000

File="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Output."$SLURM_ARRAY_TASK_ID".full_out.txt"

rm $File

time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns0_B99PercentFreqAllele.txt $SLURM_ARRAY_TASK_ID

# time perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.2/full_out.run.2.num.$SLURM_ARRAY_TASK_ID.N.20000.h.0.500000.F.0.000000.txt TestData/run.2/Alleles$SLURM_ARRAY_TASK_ID.txt 0 160000

# time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SLURM_ARRAY_TASK_ID -z2 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 -TTestData/run.2/Alleles$SLURM_ARRAY_TASK_ID.txt TestData/run.2/Traj_0.01_$SLURM_ARRAY_TASK_ID.txt /u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/TestData/
