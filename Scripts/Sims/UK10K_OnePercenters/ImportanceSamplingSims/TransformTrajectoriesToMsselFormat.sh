for i in {1..100}
do
echo $i
Sum=$(( $i + 1000 ))
FileOne="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0_"$Sum".txtTrajectory.txt"
ExitFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMssel_0.01_0_"$i".txtTrajectory.txt"
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormat.pl $FileOne $ExitFile 1000 113126
done

for i in {1..100}
do
echo $i
Sum=$(( $i + 1000 ))
FileOne="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_0_"$Sum".txtTrajectory.txt"
ExitFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMsselHighPop_0.01_0_"$i".txtTrajectory.txt"
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormat.pl $FileOne $ExitFile 1000 551894
done


for i in {1..100}
do
echo $i
Sum=$(( $i + 1000 ))
FileOne="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_100_"$Sum".txtTrajectory.txt"
ExitFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMsselHighPop_0.01_100_"$i".txtTrajectory.txt"
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormat.pl $FileOne $ExitFile 1000 551894
done

