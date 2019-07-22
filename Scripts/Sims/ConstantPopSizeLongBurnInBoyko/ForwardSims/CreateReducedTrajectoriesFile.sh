#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

AlleleCount=$( wc -l ../../../../Results/ConstantPopSizeBoyko/ForwardSims/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/ConstantPopSizeBoyko/ForwardSims/Alleles_*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/ConstantPopSizeBoyko/ForwardSims/Traj_ 20000 ../../../../Results/ConstantPopSizeBoyko/ForwardSims/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/ConstantPopSizeBoyko/ForwardSims/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/ConstantPopSizeBoyko/ForwardSims/ReducedTrajectories.txt


