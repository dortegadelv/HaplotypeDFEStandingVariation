for i in {1..100}
do
echo $i
Sum=$(( $i + 1000 ))
FileOne="../../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0_"$Sum".txtTrajectory.txt"
ExitFile="../../../../Results/ConstantPopSize/ImportanceSamplingSims/ExitMssel_0.01_0_"$i".txtTrajectory.txt"
perl TrajToMsselFormat.pl $FileOne $ExitFile 1000 10000
done