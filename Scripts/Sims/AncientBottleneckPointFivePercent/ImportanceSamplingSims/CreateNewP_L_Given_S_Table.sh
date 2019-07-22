#$ -l h_rt=24:00:00
#$ -cwd
#$ -A diegoort
#$ -N IS
#$ -o /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/AfricanTennessen_June27_2015/Trash/
#$ -e /u/home/d/diegoort/klohmueldata/diego_data/OldGeneralDirectory/project/PurifyingSelectionProject/SISR_January6_2013/TemporalCode/SingleTrajectoryPij_23July2014/AfricanTennessen_June27_2015/Trash/


# cat BottleneckDenserGrid/DistancesFile_{1..100}.txt > BottleneckDenserGrid/DistancesFile.txt
# cat BottleneckDenserGrid/Exit_DemHistAfricanTennessen.txt_0.01_0_{1001..1100}.txtWeightYears.txt > BottleneckDenserGrid/Exit_0.01_0.txtWeightYears.txt

perl ../EstimateHapLengthWeight.pl BottleneckDenserGrid/Exit_0.01_0.txtWeightYears.txt BottleneckDenserGrid/DistancesFile.txt NewMiniExp.txt NewMiniSD.txt

awk '{print $1}' NewMiniExp.txt > ListOfAges.txt

paste -d "\t" ListOfAges.txt NewMiniExp.txt > TableToTest.txt
