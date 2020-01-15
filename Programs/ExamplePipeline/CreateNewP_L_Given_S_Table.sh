NumberOfIdentifiers=$1

if [ -z "$NumberOfIdentifiers" ]
then
      echo "The variable NumberOfIdentifiers given in the command line was not given a value in the command line"
      exit 1
fi

cd ISProgram

WeightYearsBigTable="../Results/Exit.txtWeightYears.txt"
SumDistancesTable="../Results/DistancesFile.txt"

for (( c=1; c<=NumberOfIdentifiers; c++ ))
do

cat ../Results/ImportanceSamplingSims_$c.txtWeightYears.txt > $WeightYearsBigTable
cat ../Results/DistancesFile_$c.txt > $SumDistancesTable
done


time perl EstimateHapLengthWeight.pl $WeightYearsBigTable $SumDistancesTable ../Results/NewMiniExp10000.txt ../Results/NewMiniSD10000.txt

awk '{print $1}' ../Results/NewMiniExp10000.txt > ../Results/FirstColumn.txt

paste -d "\t" ../Results/FirstColumn.txt ../Results/NewMiniExp10000.txt > ../Results/TableToTest.txt
# paste -d "\t" ListOfAges.txt NewMiniExp10000.txt > TableToTest10000.txt


