#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

AlleleCount=$( wc -l ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/Traj_ 100000 ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/PositivePart/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/PositivePart/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/PositivePart/Traj_ 100000 ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/PositivePart/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/PositivePart/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/PositivePart/ReducedTrajectories.txt


