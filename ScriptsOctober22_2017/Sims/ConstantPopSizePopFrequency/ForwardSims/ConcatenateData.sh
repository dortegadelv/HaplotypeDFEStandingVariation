cat TestData/run.2/full_*.N.1000.h.0.500000.F.0.000000.txt > TestData/run.2/AllFull.txt
cat TestData/run.3/full_*.N.1000.h.0.500000.F.0.000000.txt > TestData/run.3/AllFull.txt
cat TestData/run.4/full_* > TestData/run.4/AllFull.txt
cat TestData/run.5/full_* > TestData/run.5/AllFull.txt
cat TestData/run.8/full_* > TestData/run.8/AllFull.txt
cat TestData/run.9/full_* > TestData/run.9/AllFull.txt


perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.2/AllFull.txt TestData/run.2/Freq0_01.txt 1 25000
perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.3/AllFull.txt TestData/run.3/Freq0_01.txt 1 25000
perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.4/AllFull.txt TestData/run.4/Freq0_01.txt 1 25100
perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.5/AllFull.txt TestData/run.5/Freq0_01.txt 1 25100
perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.8/AllFull.txt TestData/run.8/Freq0_01.txt 1 25000
perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 TestData/run.9/AllFull.txt TestData/run.9/Freq0_01.txt 1 25000



