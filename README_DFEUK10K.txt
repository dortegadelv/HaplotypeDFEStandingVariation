### Get L values on missense variants (You will need to have the UK10K files UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.legend.gz and UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.hap.gz. Then substitute the variables $SitesFile and $HapFile to the location on those files on the script HaplotypeDFEStandingVariation/Scripts/DataAnalysis/CreatePlinkFiles.pl)

First, to create the plink files used to calculate the frequencies, use:

mkdir Data/Plink/
cd Scripts/DataAnalysis
qsub -t 1-22 CreatePlinkFiles.sh

# Run the past script using SGE_TASK_ID values from 1-22

Obtain the frequency per each site in the UK10K individuals that are clearly European according to the UK10K paper:

cd Scripts/DataAnalysis/InferDFEWithHapLengths
qsub -t 1-22 CalculateFrequencyPlinkFiles.sh

# Run the past script using SGE_TASK_ID values from 1-22

Add the annotations for each site. The file ../../Data/UK10K_COHORT.20160215.sites.vcf.gz must be present. It can be found in ftp://ngs.sanger.ac.uk/production/uk10k/UK10K_COHORT/REL-2012-06-02/UK10K_COHORT.20160215.sites.vcf.gz . ( You will need to have the UK10K files UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.legend.gz and UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.hap.gz. Then substitute the locations of those files in the variable $File from the script AssignAnnotations.pl ):

cd Scripts/DataAnalysis/
perl GetAnnotationsPerSNP.pl
cd Scripts/DataAnalysis/InferDFEWithHapLengths
perl AssignAnnotations.pl

Then add the ancestral state. You must get the vcf file from the 1,000 genomes project with the identification of the ancestral state ( ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf.gz ). Then you must substitute the location of that file in the variable $LineToSearch from the script AssignAncestralState.pl :

perl AssignAncestralState.pl

# Get 1% frequency sites that are not CpGs

qsub -t 1-22 GetListOfMissenseAllelesAtACertainFrequencyCpG.sh
qsub -t 1-22 GetListOfSynonymousAllelesAtACertainFrequencyCpG.sh

cat ../../../Data/Plink/SynonymousOnePercentCpG{1..22}.frq > ../../../Data/Plink/SynonymousOnePercentCpG.frq
cat ../../../Data/Plink/MissenseOnePercentCpG{1..22}.frq > ../../../Data/Plink/MissenseOnePercentCpG.frq

####### CpG Sites
#This compares the reference allele of the reference genome hg19 with what
# the reference allele I got from the 1000 genomes VCF. Things match! You will need to place the reference genome on the directory: ../../../Data/ReferenceGenomehg19/human_g1k_v37.fasta.gz.1

perl RefAlleleMapCheck.pl

# We clasified CpG sites using

for i in {1..22}
do
perl RefAlleleCpgAllSites.pl $i
done

## Merge Annotations with CpG information

perl MergeAncCpgAnnotation.pl

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

### The haplotypic lengths can be found on: Data/Plink/HapLengths . The number of the hap lengths files surrounding non synonymous variants is found on Data/VariantNumberToInclude.txt . The number of the hap lengths files surrounding synonymous variants is found on Data/VariantNumberToIncludeSynonymous.txt 

### GetListOfExonsAwayFromCentromeresTelomeres

cd Scripts/DataAnalysis/InferDFEWithHapLengths
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

qsub -t 1-22 GetListOfSynonymousAllelesAtACertainFrequency.sh
# Run the past script using SGE_TASK_ID values from 1-22

Then do:

cat ../../../Data/Plink/SynonymousOnePercentCpG{1..22}.frq > ../../../Data/Plink/AllSynonymousOnePercentCpG.frq

Then execute this for every variant at a one percent frequency to get the L values for synonymous variants:

qsub -t 1-183 CalculateHaplotypeLengthsSynonymousOnlyCpG.sh
# Run the past script using SGE_TASK_ID values from 1-183

cd Scripts/DataAnalysis/InferDFEWithHapLengths/ABC_Analysis
bash CalculateFrequencyByWindowsSynMissense.sh

#### Run ABC pipeline

cd Scripts/DataAnalysis/InferDFEWithHapLengths/ABC_Analysis
qsub -t 1-500 ABCDemographyAnalysisNotCpG.sh
# Run the past script using SGE_TASK_ID values from 1-500

## Calculate the difference in L values between the simulated data and the UK10K data
perl CalculateMismatchStatistic_NotCpG.pl

#### Forward in time simulations

Check README_ForwardSims.txt and README_FoIS.txt for information on how we did the forward-in-time allele frequency simulations shown in Figure 8

#### Get DFEs that will be used in analysis

cd Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims/
Run CreationOfDiscreteDistribution50.R to get the probabilities for each 2Ns value in each distribution of fitness effects.
bash GetDFETable.sh

#### Run the following R scripts to get the expected L values for different point 4Ns values and DFE's using the recombination rates around synonymous and non synonymous variants. Run this after running the pipelines from README_ForwardSims.txt and README_FoIS.txt.

cd Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims/
bash GetFullTable.sh
GetQuadraticParametersSingle4Ns.R
GetQuadraticParametersSingle4NsSyn.R
GetQuadraticParametersDFE.R
GetQuadraticParametersAnotherDFE.R

#### Get max likelihood value from data

cd Scripts/Sims/UK10K_OnePercenters/ForwardSims
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFE.sh
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEAnother.sh
sort -nrk2,2 ../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFE.txt | head
sort -nrk2,2 ../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFEAnother.txt | head

## LLDataDFE.txt contains the MLE since the likelihood is bigger than that of ../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFEAnother.txt . This MLE has a scale value of 0.9 and a shape value of 75,000 .

#### DFE bootstrap analysis

Get Bootstrap replicates and calculate L
cd Scripts/Sims/UK10K_OnePercenters/ForwardSims/
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEBootstrap.sh
# Run the past command with SGE_TASK_ID values going from 1-100.

### Get the maximum likelihood estimator on the bootstrap data

perl GetMax4NsValueBootstrapLargerSpaceDFE.pl

### Do forward simulations under the UK10K scenario 

mkdir ../../../../Results/UK10K/ForwardSims/DFETestHighPop/
sbatch --array=1-3000 Expansion_DFEHighPop.sh

#### Print s values at a particular frequency (Print the line that gives back ExitOnePercentSValuesUK10KHighPop.txt to get the file needed for Figure 9).

cd Scripts/Scripts/Sims/ConcatenateManyStatisticsScripts
bash PrintSValuesAtParticularFrequency.sh

############################################################################################################################################################

