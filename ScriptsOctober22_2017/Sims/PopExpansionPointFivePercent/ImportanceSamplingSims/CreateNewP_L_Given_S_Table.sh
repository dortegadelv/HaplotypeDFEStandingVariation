cat ExpansionDenserGrid/DistancesFile_{1..100}.txt > ExpansionDenserGrid/DistancesFile.txt
cat ExpansionDenserGrid/Exit_DemHistAfricanTennessen.txt_0.01_0_{1001..1100}.txtWeightYears.txt > ExpansionDenserGrid/Exit_0.01_0.txtWeightYears.txt

perl ../EstimateHapLengthWeight.pl ExpansionDenserGrid/Exit_0.01_0.txtWeightYears.txt ExpansionDenserGrid/DistancesFile.txt NewMiniExp.txt NewMiniSD.txt

awk '{print $1}' NewMiniExp.txt > ListOfAges.txt

paste -d "\t" ListOfAges.txt NewMiniExp.txt > TableToTest.txt
