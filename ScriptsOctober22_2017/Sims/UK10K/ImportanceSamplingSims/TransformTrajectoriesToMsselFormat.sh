for i in {1..100}
do
echo $i
Sum=$(( $i + 1000 ))
FileOne="../../../../Results/UK10K/ImportanceSamplingSims/Exit__0.01_0_"$Sum".txtTrajectory.txt"
ExitFile="../../../../Results/UK10K/ImportanceSamplingSims/ExitMssel_0.01_0_"$i".txtTrajectory.txt"
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormat.pl $FileOne $ExitFile 1000 173442
done
