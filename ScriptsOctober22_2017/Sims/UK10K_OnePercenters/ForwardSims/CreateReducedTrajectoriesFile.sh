#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

AlleleCount=$( wc -l ../../../../Results/UK10K/ForwardSims/4Ns_0/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10K/ForwardSims/4Ns_0/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_0/Traj_ 220758 ../../../../Results/UK10K/ForwardSims/4Ns_0/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_0/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_0/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/UK10K/ForwardSims/4Ns_-50/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10K/ForwardSims/4Ns_-50/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_-50/Traj_ 220758 ../../../../Results/UK10K/ForwardSims/4Ns_-50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_-50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_-50/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/UK10K/ForwardSims/4Ns_-25/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10K/ForwardSims/4Ns_-25/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_-25/Traj_ 220758 ../../../../Results/UK10K/ForwardSims/4Ns_-25/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_-25/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_-25/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/UK10K/ForwardSims/4Ns_50/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10K/ForwardSims/4Ns_50/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_50/Traj_ 220758 ../../../../Results/UK10K/ForwardSims/4Ns_50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_50/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/UK10K/ForwardSims/4Ns_25/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10K/ForwardSims/4Ns_25/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_25/Traj_ 220758 ../../../../Results/UK10K/ForwardSims/4Ns_25/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_25/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_25/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/UK10K/ForwardSims/4Ns_1/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10K/ForwardSims/4Ns_1/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_1/Traj_ 220758 ../../../../Results/UK10K/ForwardSims/4Ns_1/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_1/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_1/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/UK10K/ForwardSims/DFETest/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10K/ForwardSims/DFETest/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/DFETest/Traj_ 220758 ../../../../Results/UK10K/ForwardSims/DFETest/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/DFETest/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/DFETest/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/Traj_ 1103788 ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/ReducedTrajectories.txt

