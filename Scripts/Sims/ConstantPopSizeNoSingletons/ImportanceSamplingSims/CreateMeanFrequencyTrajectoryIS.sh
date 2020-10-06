#$ -l h_vmem=2g
#$ -cwd

#$ -N ForWF
#$ -e ../../../../Results/Trash/
#$ -o ../../../../Results/Trash/

perl ../../UK10K/ImportanceSamplingSims/CreateMeanFrequencyTrajectoryIS.pl ../../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0_ ../../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0_ 10000 1001 1100 301 ExitMeanExpansionTraj.txt
