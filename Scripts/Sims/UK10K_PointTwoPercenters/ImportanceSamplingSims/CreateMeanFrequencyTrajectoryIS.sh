#$ -l h_rt=24:00:00,h_data=4G
#$ -cwd
#$ -A diegoort
#$ -N IS
#$ -o /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/AfricanTennessen_June27_2015/Trash/
#$ -e /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/AfricanTennessen_June27_2015/Trash/

perl CreateMeanFrequencyTrajectoryIS.pl ExpansionDenserGrid/Exit_DemHistAfricanTennessen.txt_0.01_0_ ExpansionDenserGrid/Exit_DemHistAfricanTennessen.txt_0.01_0_ 50000 1001 1100 201 ExitMeanExpansionTraj.txt
