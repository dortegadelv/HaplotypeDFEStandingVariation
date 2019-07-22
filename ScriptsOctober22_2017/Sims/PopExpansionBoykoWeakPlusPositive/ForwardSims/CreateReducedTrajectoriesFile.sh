#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

AlleleCount=$( wc -l ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/Traj_ 100000 ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/PositivePart/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/PositivePart/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/PositivePart/Traj_ 100000 ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/PositivePart/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/PositivePart/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/PositivePart/ReducedTrajectories.txt


