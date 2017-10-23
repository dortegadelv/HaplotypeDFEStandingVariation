for i in {1..500}
do
Month="None"
LineNumber="None"
File="../../../../Results/ABCAnalysis/Output/WindowDistanceOut"$i".txt"
Month=$( ls -l $File | awk '{print $6}' )
LineNumber=$( wc -l $File | awk '{print $1}' )
echo "$i $Month $LineNumber"
if [ "$Month" != "Jan" ]
then
echo "Here"
qsub -t $i ABCDemographyAnalysis.sh
elif [ "$LineNumber" != "100" ]
then
echo "And here"
qsub -t $i ABCDemographyAnalysis.sh
fi

done

