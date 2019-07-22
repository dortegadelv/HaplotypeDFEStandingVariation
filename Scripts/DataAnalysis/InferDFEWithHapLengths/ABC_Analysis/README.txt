## Calculate Genetic map with CpGs

cd ..
perl GetGeneticMapLeftRightSynonymous.pl
perl GetGeneticMapLeftRight.pl

## Calculate genetic map without CpGs

perl GetGeneticMapLeftRightSynonymousNotCpG.pl
perl GetGeneticMapLeftRightNotCpG.pl

### This is used to get the L Distribution including CpGs

bash CalculateFrequencyByWindowsSynMissense.sh

### Now, this is what we will use to get the L distribution without CpGs

bash CalculateFrequencyByWindowsSynMissenseNotCpGs.sh
