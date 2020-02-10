#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=02:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

for i in {1..100}
do

echo $i
Sum=$(( $i + 1000 ))
FileOne="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0_"$Sum".txtTrajectory.txt"
ExitFileOne="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMsselPrev_0.01_0_"$i".txtTrajectory.txt"
ExitFileTwo="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMssel_0.01_0_"$i".txtTrajectory.txt"
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormatReverse.pl $FileOne $ExitFileOne 1000 113126
cat $ExitFileOne | ../../../../Programs/Mssel/stepftn > $ExitFileTwo

# echo $i
# Sum=$(( $i + 1000 ))
# FileOne="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0_"$Sum".txtTrajectory.txt"
# ExitFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMssel_0.01_0_"$i".txtTrajectory.txt"
# perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormat.pl $FileOne $ExitFile 1000 113126
done

# for i in {1..100}
# do
# echo $i
# Sum=$(( $i + 1000 ))
# FileOne="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_0_"$Sum".txtTrajectory.txt"
# ExitFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMsselHighPop_0.01_0_"$i".txtTrajectory.txt"
# perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormat.pl $FileOne $ExitFile 1000 551894
# done


# for i in {1..100}
# do
# echo $i
# Sum=$(( $i + 1000 ))
# FileOne="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txtHighPop_0.01_100_"$Sum".txtTrajectory.txt"
# ExitFile="../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/ExitMsselHighPop_0.01_100_"$i".txtTrajectory.txt"
# perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormat.pl $FileOne $ExitFile 1000 551894
# done

