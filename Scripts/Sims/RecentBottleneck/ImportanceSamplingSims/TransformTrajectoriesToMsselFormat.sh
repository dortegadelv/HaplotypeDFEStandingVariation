for i in {1..100}
do
echo $i
Sum=$(( $i + 1000 ))
FileOne="../../../../Results/RecentBottleneck/ImportanceSamplingSims/Exit__0.01_0_"$Sum".txtTrajectory.txt"
ExitFile="../../../../Results/RecentBottleneck/ImportanceSamplingSims/ExitMssel_0.01_0_"$i".txtTrajectory.txt"
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormat.pl $FileOne $ExitFile 1000 5000
done