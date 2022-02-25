cd TableDFE

Rscript CreationOfDiscreteDistribution.R

LowNSRow=2
UpNSRow=202

perl GetDFETable.pl ../Results/TableToTest.txt ../Results/DFETableToTest.txt $LowNSRow $UpNSRow

head -n1 ../Results/DFETableToTest.txt > ../Results/FirstLine.txt

cat ../Results/FirstLine.txt ../Results/FirstLine.txt ../Results/DFETableToTest.txt > ../Results/TempDFETableToTest.txt

cp ../Results/TempDFETableToTest.txt ../Results/DFETableToTest.txt
