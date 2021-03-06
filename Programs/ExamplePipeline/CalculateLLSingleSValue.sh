NumberOfIdentifiers=$1
SelectionValues=$2

### Check if you have all the variables

if [ -z "$NumberOfIdentifiers" ]
then
      echo "The variable NumberOfIdentifiers given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$SelectionValues" ]
then
      echo "The variable SelectionValues given in the command line was not given a value in the command line"
      exit 1
fi


cd LLCalculations

ResultsFile="../Results/LLResults.txt"
rm $ResultsFile
DataSummarized="../Results/MaxLLEstimateForS.txt"
rm $DataSummarized

for (( i=1; i<=NumberOfIdentifiers; i++ ))
do
HapFile="../Results/HapLengths"$i".txt"
perl CalculatePLengthGivenS.pl $HapFile 250000 ../Results/TableToTest.txt TestT2Bounds.txt $ResultsFile

perl GetMax4NsValueFromTable.pl $ResultsFile $SelectionValues

done



