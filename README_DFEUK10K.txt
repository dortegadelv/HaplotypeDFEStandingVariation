### Get L values on missense variants

First, to create the plink files used to calculate the frequencies, use:

cd Scripts/DataAnalysis
bash CreatePlinkFiles.sh

# Run the past script using SGE_TASK_ID values from 1-22

Obtain the frequency per each site in the UK10K individuals that are clearly European according to the UK10K paper:

cd Scripts/DataAnalysis/InferDFEWithHapLengths
bash CalculateFrequencyPlinkFiles.sh

# Run the past script using SGE_TASK_ID values from 1-22

Add the annotations for each site:

perl AssignAnnotations.pl

Then add the ancestral state:

perl AssignAncestralState.pl

####### CpG Sites
#This compares the reference allele of the reference genome hg19 with what
# the reference allele I got from the 1000 genomes VCF. Things match!

perl RefAlleleMapCheck.pl

# We clasified CpG sites using

for i in {1..22}
do
perl RefAlleleCpgAllSites.pl $i
done

## Merge Annotations with CpG information

perl MergeAncCpgAnnotation.pl

# Get 1% frequency sites that are not CpGs

qsub -t 1-22 GetListOfMissenseAllelesAtACertainFrequencyCpG.sh
qsub -t 1-22 GetListOfSynonymousAllelesAtACertainFrequencyCpG.sh

cat ../../../Data/Plink/SynonymousOnePercentCpG{1..22}.frq > ../../../Data/Plink/SynonymousOnePercentCpG.frq
cat ../../../Data/Plink/MissenseOnePercentCpG{1..22}.frq > ../../../Data/Plink/MissenseOnePercentCpG.frq

# Create Plink file without CpGs

perl CreatePlinkFileWithoutCpGs.pl

## Positions of not CpGs sites files

for i in {1..22}
do
echo $i
awk '{print $4}' ../../../Data/Plink/PlinkNotCpG$i.tped > ../../../Data/Plink/PositionsNotCpG$i.txt
done

perl PrintCpGPositionsOnePercentFrequency.pl

### Calculate Haplotype lengths not CpG regions

qsub -t 1-183 CalculateHaplotypeLengthsSynonymousOnlyCpG.sh
qsub -t 1-325 CalculateHaplotypeLengthsOnlyCpG.sh

### GetListOfExonsAwayFromCentromeresTelomeres

perl GetExonsAwayFromCentromereTelomere.pl

#### Count total number of NOT CpG sites

for i in {1..22}
do
perl CountCpGSites.pl $i
done


############## Check Recombination maps

perl GetGeneticMapLeftRightPrintMap.pl
perl GetGeneticMapLeftRightSynonymousPrintMap.pl
perl GetGeneticMapLeftRightNotCpGPrintMap.pl
perl GetGeneticMapLeftRightSynonymousNotCpGPrintMap.pl


######### Run ABC algorithm

## Get L Data that will be used in the ABC algorithm

Get the list of synonymous variants at a particular frequency:

SGE_TASK_ID=1
bash GetListOfSynonymousAllelesAtACertainFrequency.sh
# Run the past script using SGE_TASK_ID values from 1-22

Then do:

cat ../../../Data/Plink/SynonymousOnePercentCpG{1..22}.frq > ../../../Data/Plink/AllSynonymousOnePercentCpG.frq

Then execute this for every variant at a one percent frequency to get the L values for synonymous variants:

bash CalculateHaplotypeLengthsSynonymousOnlyCpG.sh
# Run the past script using SGE_TASK_ID values from 1-183

cd Scripts/DataAnalysis/InferDFEWithHapLengths/ABC_Analysis
bash CalculateFrequencyByWindowsSynMissense.sh

#### Run ABC pipeline

cd Scripts/DataAnalysis/InferDFEWithHapLengths/ABC_Analysis
bash ABCDemographyAnalysis.sh
# Run the past script using SGE_TASK_ID values from 1-500

## Calculate the difference in L values between the simulated data and the UK10K data
perl CalculateMismatchStatistic.pl

## Concatenate results and get posterior distribution
bash ConcatenateMismatchStatisticAndLDistances.sh

## Do simulations using the point estimates from the posterior distribution of the demographic parameters
bash ReplicationOfBestABCParameters.sh
# Run the past script using SGE_TASK_ID values from 1-100

## Get an average estimate of the difference in L values between the replicates of simulated data and the UK10K data
perl CalculateMismatchStatisticSimsReplicates.pl

#### Forward in time simulations

Check README_ForwardSims.txt and README_FoIS.txt for information on how we did the forward-in-time allele frequency simulations shown in Figure 8

#### Get DFEs that will be used in analysis

cd Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims/
Run CreationOfDiscreteDistribution50.R to get the probabilities for each 2Ns value in each distribution of fitness effects.
bash GetDFETable.sh

#### Get max likelihood value from data

cd Scripts/Sims/UK10K_OnePercenters/ForwardSims
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFE.sh
sort -nrk2,2 ../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFE.txt | head

#### DFE bootstrap analysis

Get Bootstrap replicates and calculate L
cd Scripts/Sims/UK10K_OnePercenters/ForwardSims/
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEBootstrap.sh
# Run the past command with SGE_TASK_ID values going from 1-100.

### Get the maximum likelihood estimator

perl GetMax4NsValueDFEBootstrap.pl

#### Print s values at a particular frequency

cd Scripts/Scripts/Sims/ConcatenateManyStatisticsScripts
bash PrintSValuesAtParticularFrequency.sh

############################################################################################################################################################


### Simulations tests

cd Sims/UK10K_OnePercenters/ForwardSims
bash Expansion_DFEHighPop.sh
### Run the past command with SGE_TASK_ID values going from 1-100.

bash Expansion_DFE.sh
### Run the past command with SGE_TASK_ID values going from 1-100.

### Create the reduced trajectories file
bash CreateReducedTrajectories.sh

### Create mssel files
bash RunMssel_DFEHighPop.sh
bash RunMssel_DFE.sh
### Run the past commands with SGE_TASK_ID values going from 1-100.

### Run the next scripts
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEHighPopAnotherSims.sh
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEHighPopSims.sh
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFESims.sh
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEAnotherSims.sh
### Run the past commands with SGE_TASK_ID values going from 1-100.

### Run the following commands
perl GetMax4NsValueSimsLargerSpaceDFE.pl
perl GetMax4NsValueSimsLargerSpaceHighPopDFE.pl
