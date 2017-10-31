### Get L values on missense variants

First, to create the plink files used to calculate the frequencies, use:

cd ScriptsOctober22_2017/DataAnalysis
SGE_TASK_ID=1
bash CreatePlinkFiles.sh
# Run the past script using SGE_TASK_ID values from 1-22

Obtain the frequency per each site in the UK10K individuals that are clearly European according to the UK10K paper:

cd ScriptsOctober22_2017/DataAnalysis/InferDFEWithHapLengths
SGE_TASK_ID=1
bash CalculateFrequencyPlinkFiles.sh
# Run the past script using SGE_TASK_ID values from 1-22

Add the annotations for each site:

perl AssignAnnotations.pl

Then add the ancestral state:

perl AssignAncestralState.pl

Then get the list of missense variants at a particular frequency:

SGE_TASK_ID=1
bash GetListOfMissenseAllelesAtACertainFrequency.sh
# Run the past script using SGE_TASK_ID values from 1-22

Then do:

cat ../../../Data/Plink/MissenseOnePercent{1..22}.frq > ../../../Data/Plink/AllMissenseOnePercent.frq

Then execute this for every variant at a one percent frequency to get the L values:

SGE_TASK_ID=1
CalculateHaplotypeLengths.sh
# Run the past script using SGE_TASK_ID values from 1-741

######### Run ABC algorithm

## Get L Data that will be used in the ABC algorithm

Get the list of synonymous variants at a particular frequency:

SGE_TASK_ID=1
bash GetListOfSynonymousAllelesAtACertainFrequency.sh
# Run the past script using SGE_TASK_ID values from 1-22

Then do:

cat ../../../Data/Plink/SynonymousOnePercent{1..22}.frq > ../../../Data/Plink/AllSynonymousOnePercent.frq

Then execute this for every variant at a one percent frequency to get the L values for synonymous variants:

SGE_TASK_ID=1
bash CalculateHaplotypeLengthsSynonymous.sh
# Run the past script using SGE_TASK_ID values from 1-531

bash CalculateFrequencyByWindowsSynMissense.sh

#### Run ABC pipeline

cd ScriptsOctober22_2017/DataAnalysis/InferDFEWithHapLengths/ABC_Analysis
SGE_TASK_ID=1
bash ABCDemographyAnalysis.sh
# Run the past script using SGE_TASK_ID values from 1-500

## Calculate the difference in L values between the simulated data and the UK10K data
perl CalculateMismatchStatistic.pl

## Concatenate results and get posterior distribution
bash ConcatenateMismatchStatisticAndLDistances.sh

#### Forward in time simulations

Check README_ForwardSims.txt and README_FoIS.txt for information on how we did the forward-in-time allele frequency simulations shown in Figure 10

#### Get DFEs that will be used in analysis

cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims/
Run CreationOfDiscreteDistribution.R to get the probabilities for each 2Ns value in each distribution of fitness effects.
perl GetDFETable.pl

#### DFE bootstrap analysis

Get Bootstrap replicates and calculate L
cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ForwardSims/
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEBootstrap.sh
# Run the past command with SGE_TASK_ID values going from 1-100.

### Get the maximum likelihood estimator
perl GetMax4NsValueDFEBootstrap.pl

