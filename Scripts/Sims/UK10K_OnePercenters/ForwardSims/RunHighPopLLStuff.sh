for i in {1..100}
do
# echo $i
File="../../../../Results/UK10K/ForwardSims/DFETestHighPop/LLSimsMssel273_"$i".txt"

if [ -f "$File" ]
then
	echo "Good $i"
else
	echo "Submit qsub -t $i CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEHighPopSims.sh"
	qsub -t $i CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEHighPopSims.sh 
fi

done

