i=$1

# cp ../../../../Results/PopExpansionZero/ImportanceSamplingSims/TableToTest$i.txt ../../../../Results/PopExpansionZero/ImportanceSamplingSims/TableToTest.txt
# cp ../../../../Results/PopExpansionFifty/ImportanceSamplingSims/TableToTest$i.txt ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/TableToTest.txt
# cp ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/TableToTest$i.txt ../../../../Results/PopExpansionFifty/ImportanceSamplingSims/TableToTest.txt

cd ../../../Sims/PopExpansion/ImportanceSamplingSimsBoyko/

perl GetDFETable.pl ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/TableToTest.txt ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableToTest.txt
perl GetDFETableSmall.pl ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/TableToTest.txt ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableToTestSmall.txt

head -n2 ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableToTest.txt > Header.txt
cp ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableToTest.txt ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableTempToTest.txt
cat Header.txt ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableTempToTest.txt > ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableToTest.txt

cp ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableToTestSmall.txt ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableTempToTest.txt
cat Header.txt ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableTempToTest.txt > ../../../../Results/PopExpansionBoyko/ImportanceSamplingSims/DFETableToTestSmall.txt


cd ../../../Sims/PopExpansion/ForwardSims/
sbatch --array=1-100 CreateSimTestTableWithLLResultsDenseGridSlimBoykoDFE.sh


