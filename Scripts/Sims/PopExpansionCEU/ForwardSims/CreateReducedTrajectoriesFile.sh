#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

AlleleCount=$( wc -l ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_0/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_0/Alleles_*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_0/Traj_ 834302 ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_0/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_0/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_0/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-50/Alleles_{1..200}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-50/Alleles_{1..200}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-50/Traj_ 834302 ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-50/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-100/Alleles_{1..250}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-100/Alleles_{1..250}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-100/Traj_ 834302 ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-100/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-100/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-100/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_50/Alleles_{1..150}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_50/Alleles_{1..150}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_50/Traj_ 834302 ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_50/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_100/Alleles_{1..120}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_100/Alleles_{1..120}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_100/Traj_ 834302 ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_100/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_100/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_100/ReducedTrajectories.txt


AlleleCount=$( wc -l ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-25/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-25/Alleles_*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-25/Traj_ 834302 ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-25/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-25/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_-25/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_25/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_25/Alleles_*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_25/Traj_ 834302 ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_25/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_25/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionCEU/ForwardSims/4Ns_25/ReducedTrajectories.txt

