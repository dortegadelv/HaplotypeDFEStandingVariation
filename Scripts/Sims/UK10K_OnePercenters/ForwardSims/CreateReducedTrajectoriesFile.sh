#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash
#$ -e ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Trash

for i in {69..76}
do
AlleleFile="../../../../Results/UK10K/ForwardSims/4Ns_0/Alleles_"$i"_"
AlleleCount=$( wc -l "$AlleleFile"{1..1700}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls "$AlleleFile"{1..1700}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_0/Traj_$i"_" 164462 ../../../../Results/UK10K/ForwardSims/4Ns_0/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_0/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_0/ReducedTrajectories_$i.txt
done

## Files Traj_ have the same name for 1% and 99% derived alleles. You should run RunMssel_4Ns0New.sh or RunMssel_4Ns0NewMisspecifiedAncestralState.sh before running this set of commands.
for i in {69..76}
do
AlleleFile="../../../../Results/UK10K/ForwardSims/4Ns_0/Alleles_"$i"_"
AlleleCount=$( wc -l "$AlleleFile"{1..1700}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls "$AlleleFile"{1..1700}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_0/Traj_$i"_" 164462 ../../../../Results/UK10K/ForwardSims/4Ns_0/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_0/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_0/ReducedTrajectories99Percent_$i.txt
done

for i in {69..76}
do
AlleleFile="../../../../Results/UK10K/ForwardSims/4Ns_-50/Alleles_"$i"_"
AlleleCount=$( wc -l "$AlleleFile"{1..1700}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls "$AlleleFile"{1..1700}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_-50/Traj_$i"_" 164462 ../../../../Results/UK10K/ForwardSims/4Ns_-50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_-50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_-50/ReducedTrajectories_$i.txt
done

for i in {69..76}
do
AlleleFile="../../../../Results/UK10K/ForwardSims/4Ns_-25/Alleles_"$i"_"
AlleleCount=$( wc -l "$AlleleFile"{1..1700}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls "$AlleleFile"{1..1700}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_-25/Traj_$i"_" 164462 ../../../../Results/UK10K/ForwardSims/4Ns_-25/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_-25/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_-25/ReducedTrajectories_$i.txt
done

for i in {69..76}
do
AlleleFile="../../../../Results/UK10K/ForwardSims/4Ns_50/Alleles_"$i"_"
AlleleCount=$( wc -l "$AlleleFile"{1..1700}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls "$AlleleFile"{1..1700}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_50/Traj_$i"_" 164462 ../../../../Results/UK10K/ForwardSims/4Ns_50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_50/ReducedTrajectories_$i.txt
done

for i in {69..76}
do
AlleleFile="../../../../Results/UK10K/ForwardSims/4Ns_25/Alleles_"$i"_"
AlleleCount=$( wc -l "$AlleleFile"{1..1700}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls "$AlleleFile"{1..1700}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_25/Traj_$i"_" 164462 ../../../../Results/UK10K/ForwardSims/4Ns_25/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_25/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_25/ReducedTrajectories99Percent_$i.txt
done

for i in {69..76}
do
AlleleFile="../../../../Results/UK10K/ForwardSims/4Ns_50/Alleles_"$i"_"
AlleleCount=$( wc -l "$AlleleFile"{1..1700}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls "$AlleleFile"{1..1700}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_50/Traj_$i"_" 164462 ../../../../Results/UK10K/ForwardSims/4Ns_50/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_50/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_50/ReducedTrajectories99Percent_$i.txt
done

for i in {69..76}
do
AlleleFile="../../../../Results/UK10K/ForwardSims/4Ns_25/Alleles_"$i"_"
AlleleCount=$( wc -l "$AlleleFile"{1..1700}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls "$AlleleFile"{1..1700}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_25/Traj_$i"_" 164462 ../../../../Results/UK10K/ForwardSims/4Ns_25/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/4Ns_25/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_25/ReducedTrajectories_$i.txt
done

for i in {69..76}
do
AlleleFile="../../../../Results/UK10K/ForwardSims/DFETest/Alleles_"$i"_"
AlleleCount=$( wc -l "$AlleleFile"{1..3000}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls "$AlleleFile"{1..3000}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/DFETestTraj_$i"_" 164462 ../../../../Results/UK10K/ForwardSims/DFETest/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/DFETest/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/DFETest/ReducedTrajectories_$i.txt
done

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
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/DFETestHighPopTraj_$i"_" 164462 ../../../../Results/UK10K/ForwardSims/DFETestHighPop/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/DFETestHighPop/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/DFETestHighPop/ReducedTrajectories_$i.txt
done


AlleleCount=$( wc -l ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/Alleles*.txt | tail -n1 | awk '{print $1}' HighPop)
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/Traj_ 1103788 ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10KHighPopSize/ForwardSims/4Ns_0/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/UK10K/ForwardSims/DFETestMouse/Alleles_{1..11600}.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10K/ForwardSims/DFETestMouse/Alleles_{1..11600}.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/DFETestMouse/Traj_ 226252 ../../../../Results/UK10K/ForwardSims/DFETestMouse/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/DFETestMouse/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/DFETestMouse/ReducedTrajectories.txt


AlleleCount=$( wc -l ../../../../Results/UK10K/ForwardSims/DFETestHighPop/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10K/ForwardSims/DFETestHighPop/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/DFETestHighPop/Traj_ 1103788 ../../../../Results/UK10K/ForwardSims/DFETestHighPop/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/DFETestHighPop/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/DFETestHighPop/ReducedTrajectories.txt

AlleleCount=$( wc -l ../../../../Results/UK10K/ForwardSims/DFETestMouseHighPop/Alleles*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../../../../Results/UK10K/ForwardSims/DFETestMouseHighPop/Alleles*.txt | wc -l )
perl ../../ConstantPopSize/ForwardSims/TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/DFETestMouseHighPop/Traj_ 1103788 ../../../../Results/UK10K/ForwardSims/DFETestMouseHighPop/TrajMsselLike.txt $AlleleCount 0 $Reps
cat ../../../../Results/UK10K/ForwardSims/DFETestMouseHighPop/TrajMsselLike.txt | ../../../../Programs/Mssel/stepftn > ../../../../Results/UK10K/ForwardSims/DFETestMouseHighPop/ReducedTrajectories.txt


