#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

AlleleCount=$( wc -l ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_0/Alleles_{1..25}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_0/Alleles_{1..25}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_0/Traj_ 100000 ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_0/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_0/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_0/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-50/Alleles_{1..75}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-50/Alleles_{1..75}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-50/Traj_ 100000 ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-50/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-100/Alleles_{1..150}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-100/Alleles_{1..150}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-100/Traj_ 100000 ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-100/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-100/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_-100/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_50/Alleles_{1..25}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_50/Alleles_{1..25}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_50/Traj_ 100000 ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_50/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_100/Alleles_{1..25}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_100/Alleles_{1..25}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_100/Traj_ 100000 ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_100/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_100/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/PopExpansion10000GensAgo/ForwardSims/4Ns_100/ReducedTrajectories.txt


