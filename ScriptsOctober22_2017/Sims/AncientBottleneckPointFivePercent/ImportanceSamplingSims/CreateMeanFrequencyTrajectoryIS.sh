#$ -l h_rt=24:00:00,h_data=4G
#$ -cwd
#$ -A diegoort
#$ -N IS
#$ -o /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/AfricanTennessen_June27_2015/Trash/
#$ -e /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/AfricanTennessen_June27_2015/Trash/

perl ../PopulationExpansionTest_August2_2015/CreateMeanFrequencyTrajectoryIS.pl BottleneckDenserGrid/Exit_DemHistAfricanTennessen.txt_0.01_0_ BottleneckDenserGrid/Exit_DemHistAfricanTennessen.txt_0.01_0_ 5000 1001 1100 201 ExitMeanExpansionTraj.txt
