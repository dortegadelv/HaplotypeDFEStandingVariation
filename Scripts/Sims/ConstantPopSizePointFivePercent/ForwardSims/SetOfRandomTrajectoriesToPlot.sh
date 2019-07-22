for k in {1..10}
do
ExitFile="SampleOfTrajectories/SampleOfTrajectories4Ns0_"$k".txt"
Value=$(( ( RANDOM % 1000 )  + 1 ))
File="TestData/run.2/Traj_0.01_"$Value".txt"
# echo $File

Alleles=$( cat $File | awk '{print $1}' | sort -n | uniq | wc -l | awk '{print $1}' )
AlleleID=$(( ( RANDOM % $Alleles )  + 1 ))

AlleleIDNum=$( cat $File | awk '{print $1}' | sort -n | uniq | head -n$AlleleID | tail -n1  )

grep $AlleleIDNum $File | awk '{print $2}' > $ExitFile
done

for k in {1..10}
do
ExitFile="SampleOfTrajectories/SampleOfTrajectories4Ns-10_"$k".txt"
Value=$(( ( RANDOM % 1000 )  + 1 ))
File="TestData/run.4/Traj_0.01_"$Value".txt"
# echo $File

Alleles=$( cat $File | awk '{print $1}' | sort -n | uniq | wc -l | awk '{print $1}' )
AlleleID=$(( ( RANDOM % $Alleles )  + 1 ))

AlleleIDNum=$( cat $File | awk '{print $1}' | sort -n | uniq | head -n$AlleleID | tail -n1  )

grep $AlleleIDNum $File | awk '{print $2}' > $ExitFile
done

for k in {1..10}
do
ExitFile="SampleOfTrajectories/SampleOfTrajectories4Ns-100_"$k".txt"
Value=$(( ( RANDOM % 1000 )  + 1 ))
File="TestData/run.6/Traj_0.01_"$Value".txt"
# echo $File

Alleles=$( cat $File | awk '{print $1}' | sort -n | uniq | wc -l | awk '{print $1}' )
AlleleID=$(( ( RANDOM % $Alleles )  + 1 ))

AlleleIDNum=$( cat $File | awk '{print $1}' | sort -n | uniq | head -n$AlleleID | tail -n1  )

grep $AlleleIDNum $File | awk '{print $2}' > $ExitFile
done

