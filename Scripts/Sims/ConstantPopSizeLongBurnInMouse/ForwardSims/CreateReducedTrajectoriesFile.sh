#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

AlleleCount=$( wc -l ../../../../Results/ConstantPopSizeMouse/ForwardSims/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/ConstantPopSizeMouse/ForwardSims/Alleles_*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/ConstantPopSizeMouse/ForwardSims/Traj_ 20000 ../../../../Results/ConstantPopSizeMouse/ForwardSims/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/ConstantPopSizeMouse/ForwardSims/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/ConstantPopSizeMouse/ForwardSims/ReducedTrajectories.txt


