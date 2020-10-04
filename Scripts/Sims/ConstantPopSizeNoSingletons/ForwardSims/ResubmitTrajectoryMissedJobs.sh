for i in {1..300}
do
File="../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Traj_"$i".txt"
LsFile=$( ls $File | wc -l )
if [ $LsFile -ne "1" ]
then
echo "Problem $i 4Ns 0"
qsub -t $i ConstantSize_4Ns0.sh
fi
done


for i in {1..300}
do
File="../../../../Results/ConstantPopSize/ForwardSims/4Ns_50/Traj_"$i".txt"
LsFile=$( ls $File | wc -l )
if [ $LsFile -ne "1" ]
then
echo "Problem $i 4Ns 50"
qsub -t $i ConstantSize_4Ns50.sh
fi
done

for i in {1..300}
do
File="../../../../Results/ConstantPopSize/ForwardSims/4Ns_100/Traj_"$i".txt"
LsFile=$( ls $File | wc -l )
if [ $LsFile -ne "1" ]
then
echo "Problem $i 4Ns 100"
qsub -t $i ConstantSize_4Ns100.sh
fi
done

for i in {1..400}
do
File="../../../../Results/ConstantPopSize/ForwardSims/4Ns_-50/Traj_"$i".txt"
LsFile=$( ls $File | wc -l )
if [ $LsFile -ne "1" ]
then
echo "Problem $i 4Ns -50"
qsub -t $i ConstantSize_4Ns-50.sh
fi
done

for i in {1..600}
do
File="../../../../Results/ConstantPopSize/ForwardSims/4Ns_-100/Traj_"$i".txt"
LsFile=$( ls $File | wc -l )
if [ $LsFile -ne "1" ]
then
echo "Problem $i 4Ns -100"
qsub -t $i ConstantSize_4Ns-100.sh
fi
done

