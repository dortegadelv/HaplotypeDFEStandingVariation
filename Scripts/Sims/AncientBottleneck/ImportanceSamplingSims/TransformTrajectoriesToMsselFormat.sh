#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=06:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000


for i in {1..100}
do
echo $i
Sum=$(( $i + 1000 ))
FileOne="../../../../Results/AncientBottleneck/ImportanceSamplingSims/Exit__0.01_0_"$Sum".txtTrajectory.txt"
ExitFileOne="../../../../Results/AncientBottleneck/ImportanceSamplingSims/ExitMsselPrev_0.01_0_"$i".txtTrajectory.txt"
ExitFileTwo="../../../../Results/AncientBottleneck/ImportanceSamplingSims/ExitMssel_0.01_0_"$i".txtTrajectory.txt"
perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormatReverse.pl $FileOne $ExitFileOne 1000 5000
cat $ExitFileOne | ../../../../Programs/Mssel/stepftn > $ExitFileTwo

# FileOne="../../../../Results/AncientBottleneck/ImportanceSamplingSims/Exit__0.01_0_"$Sum".txtTrajectory.txt"
# ExitFile="../../../../Results/AncientBottleneck/ImportanceSamplingSims/ExitMssel_0.01_0_"$i".txtTrajectory.txt"
# perl ../../ConstantPopSize/ImportanceSamplingSims/TrajToMsselFormat.pl $FileOne $ExitFile 1000 5000
done
