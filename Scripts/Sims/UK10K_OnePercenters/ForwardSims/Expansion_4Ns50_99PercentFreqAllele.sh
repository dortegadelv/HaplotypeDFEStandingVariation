#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=02:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug ParameterFile_4Ns50.txt $SLURM_ARRAY_TASK_ID

LowFreq[69]="0.9904"
LowFreq[70]="0.9902"
LowFreq[71]="0.9901"
LowFreq[72]="0.99"
LowFreq[73]="0.9899"
LowFreq[74]="0.9897"
LowFreq[75]="0.9896"
LowFreq[76]="0.9895"

UpFreq[69]="0.9905"
UpFreq[70]="0.9904"
UpFreq[71]="0.9902"
UpFreq[72]="0.9901"
UpFreq[73]="0.99"
UpFreq[74]="0.9899"
UpFreq[75]="0.9897"
UpFreq[76]="0.9896"

for i in {69..76}
do

AlleleFile="Alleles_"$i"_"$SLURM_ARRAY_TASK_ID".txt"
ParameterFile="ParameterFile_4Ns50_"$i"_B.txt"

time perl ../../ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl ${LowFreq[$i]} ${UpFreq[$i]} ../../../../Results/UK10K/ForwardSims/4Ns_50/Output.$SLURM_ARRAY_TASK_ID.full_out.txt ../../../../Results/UK10K/ForwardSims/4Ns_50/$AlleleFile 0 24834

File="../../../../Results/UK10K/ForwardSims/4Ns_50/Output."$SLURM_ARRAY_TASK_ID".full_out.txt"

# rm $File

time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../../../../Programs/PReFeRSim/fwd_seldist_gsl_2012_4epoch.debug $ParameterFile $SLURM_ARRAY_TASK_ID

done

## Old stuff
# time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SLURM_ARRAY_TASK_ID -z2 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RPopulationBottleneckModel.txt -S0 TestData/

# time perl ../../../ConstantPopSize/ForwardSims/GetListOfRunsWhereFrequencyMatches.pl 0.0099 0.0101 TestData/run.2/full_out.run.2.num.$SLURM_ARRAY_TASK_ID.N.10000.h.0.500000.F.0.000000.txt TestData/run.2/Alleles$SLURM_ARRAY_TASK_ID.txt 0 122220

# time GSL_RNG_SEED=$SLURM_ARRAY_TASK_ID GSL_RNG_TYPE=mrg ../fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SLURM_ARRAY_TASK_ID -z2 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RPopulationBottleneckModel.txt -S0 -TTestData/run.2/Alleles$SLURM_ARRAY_TASK_ID.txt TestData/run.2/Traj_0.01_$SLURM_ARRAY_TASK_ID.txt TestData/

# FileToDelete="TestData/run.2/dog_out.run.2.num."$SLURM_ARRAY_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

# FileToDelete="TestData/run.2/full_out.run.2.num."$SLURM_ARRAY_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

# FileToDelete="TestData/run.2/sfs_out.run.2.num."$SLURM_ARRAY_TASK_ID".N.10000.h.0.500000.F.0.000000.txt"
# rm $FileToDelete

