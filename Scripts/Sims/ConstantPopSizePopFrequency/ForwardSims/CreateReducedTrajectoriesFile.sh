#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_0/Trash

AlleleCount=$( wc -l ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_0/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_0/Alleles_*.txt | wc -l )
perl TrajToMsselFormat.pl ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_0/Traj_ 20000 ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_0/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_0/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_0/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-50/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-50/Alleles_*.txt | wc -l )
perl TrajToMsselFormat.pl ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-50/Traj_ 20000 ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-50/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/Alleles_*.txt | wc -l )
perl TrajToMsselFormat.pl ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/Traj_ 20000 ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_-100/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_50/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_50/Alleles_*.txt | wc -l )
perl TrajToMsselFormat.pl ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_50/Traj_ 20000 ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_50/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_100/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_100/Alleles_*.txt | wc -l )
perl TrajToMsselFormat.pl ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_100/Traj_ 20000 ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_100/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_100/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/ConstantPopSizePopFrequency/ForwardSims/4Ns_100/ReducedTrajectories.txt

