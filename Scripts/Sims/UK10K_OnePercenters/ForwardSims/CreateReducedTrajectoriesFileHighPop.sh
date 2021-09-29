#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

for i in {69..76}
do
AlleleFile="../../../../Results/UK10K/ForwardSims/DFETestHighPop/Alleles_"$i"_"
AlleleCountOne=$( wc -l "$AlleleFile"{1..10000}.txt | tail -n1 | awk '{print $1}' )
AlleleCountTwo=$( wc -l "$AlleleFile"{10001..26000}.txt | tail -n1 | awk '{print $1}' )
AlleleCount=$(( $AlleleCountOne + $AlleleCountTwo ))
echo $AlleleCount
RepsOne=$( ls "$AlleleFile"{1..10000}.txt | wc -l )
RepsTwo=$( ls "$AlleleFile"{10001..26000}.txt | wc -l )
Reps=$(( $RepsOne + $RepsTwo ))
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/DFETestHighPopTraj_$i"_" 822310 ../../../../Results/UK10K/ForwardSims/DFETestHighPop/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/DFETestHighPop/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/DFETestHighPop/ReducedTrajectories_$i.txt
done


