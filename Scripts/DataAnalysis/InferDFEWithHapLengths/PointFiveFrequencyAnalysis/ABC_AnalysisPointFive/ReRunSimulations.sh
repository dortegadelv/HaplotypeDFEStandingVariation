for i in {1..500}
do
Month="None"
LineNumber="None"
File="../../../../../Results/ABCAnalysisPointFive/Output/WindowDistanceOut"$i".txt"
Month=$( ls -l $File | awk '{print $6}' )
LineNumber=$( wc -l $File | awk '{print $1}' )
echo "$i $Month $LineNumber"
if [ "$Month" != "Feb" ]
then
echo "Here"
qsub -q blades.q -t $i ABCDemographyAnalysis.sh
elif [ "$LineNumber" != "100" ]
then
echo "And here"
qsub -q blades.q -t $i ABCDemographyAnalysis.sh
fi

done


