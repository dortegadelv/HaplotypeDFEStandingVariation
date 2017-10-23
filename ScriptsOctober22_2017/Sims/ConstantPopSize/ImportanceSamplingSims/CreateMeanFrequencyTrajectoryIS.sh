#$ -l h_rt=24:00:00,h_data=2G,highp
#$ -cwd
#$ -A diegoort
#$ -N IS
#$ -pe shared 4
#$ -o /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/AfricanTennessen_June27_2015/Trash/
#$ -e /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/AfricanTennessen_June27_2015/Trash/

perl PopulationExpansionTest_August2_2015/CreateMeanFrequencyTrajectoryIS.pl ConstantSizeDenserGrid/Exit_0.01_0_ ConstantSizeDenserGrid/Exit_0.01_0_ 10000 1001 1100 301 ExitMeanExpansionTraj.txt
