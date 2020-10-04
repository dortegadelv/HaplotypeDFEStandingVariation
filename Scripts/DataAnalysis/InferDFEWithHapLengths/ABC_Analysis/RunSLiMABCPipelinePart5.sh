i=$1

# cp ../../../../Results/PopExpansionZero/ImportanceSamplingSims/TableToTest$i.txt ../../../../Results/PopExpansionZero/ImportanceSamplingSims/TableToTest.txt
# cp ../../../../Results/PopExpansionFifty/ImportanceSamplingSims/TableToTest$i.txt ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/TableToTest.txt
# cp ../../../../Results/PopExpansionHundred/ImportanceSamplingSims/TableToTest$i.txt ../../../../Results/PopExpansionFifty/ImportanceSamplingSims/TableToTest.txt

cd ../../../Sims/PopExpansion/ForwardSims/
sbatch --array=1-100 CreateSimTestTableWithLLResultsDenseGridSlim.sh


