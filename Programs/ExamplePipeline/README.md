## Example pipeline

The following steps can be used to compute the DFE from a set of L values:

0) Prerequisites
1) Simulate many forward in time allele frequency trajectories of a derived allele evolving under the Wright-Fisher model with selection (CreateManyFrequencyTrajectories.sh), concatenate those trajectories (ConcatenateAlleleFrequencyTrajectories.sh) and use that collection of allele frequency trajectories to simulate haplotypic data that will be used to estimate the pairwise identity by state lengths L (SimulateL.sh).
2) Generate the table that computes the likelihoods of L(4Ns, allele frequency, Demographic scenario | L) for a single selection coefficient 4Ns (see equation 2 from our paper)
3) Generate a table that computes the likelihoods of L(alpha, beta, allele frequency, Demographic scenario | L) for two parameters alpha and beta of a partially collapsed gamma distribution (see equation 3 from our paper).
4) Compute the maximum likelihood estimate of either a) the single selection coefficient 4Ns or b) the two parameters alpha and beta.
5) Estimate the DFE from DFEf

We also provide the following scripts to calculate L:

6) Calculate L from data

And an example of our ABC algorithm to estimate demographic history:

7) ABC algorithm to estimate the demographic history


## Step 0) Prerequisites

You need to compile the following programs. Some programs require the gsl library. More information on how to install it can be found in the PReFerSim manual at https://github.com/LohmuellerLab/PReFerSim

cd PReFerSim

gcc -g -o PReFerSim PReFerSim.c -lm -lgsl -lgslcblas -O3

cd ..

cd Mssel

gcc -O3 -o stepftn stepftn.c -lm

gcc -O2 -o mssel3  mssel3.c  rand1.c streecsel.c -lm

cd ..

cd ISProgram

g++ -o FoIS FoIS.cpp prob.cpp -lm

1) To run the step 1, you can run the following bash script by providing the following parameters.

bash CreateManyFrequencyTrajectories.sh <PReFerSimParameterFile1> <PReFerSimParameterFile2> <Identifier> <AlleleFrequencyDown> <AlleleFrequencyUp> <NumberOfHaplotypesWithTheDerivedAllele> <NumberOfIndependentVariants> <DemographicScenarioFile> <ThetaHaplotype> <RhoHaplotype> <NumberOfSites>

where:
PReFerSimParameterFile1.- Contains the parameters to run the forward-in-time simulator PReFerSim to get a list of alleles that end at a certain frequency interval where their distribution of selective coefficients is a point value or follows a different probability distribution.
PReFerSimParameterFile2.- It is almost the same file as PReFerSimParameterFile1, but it contains two extra options at the bottom that specify the list of alleles whose frequency trajectory you will print, and the output file with the frequency trajectory of those alleles. More information on the options of the parameter files can be found in the PReFerSim manual at https://github.com/LohmuellerLab/PReFerSim
Identifier - A number to give to the script. Can be changed in case the user wants to run the same parameter many times and get a different output with a different identifier every time. Also a random seed.
AlleleFrequencyDown - The program will print the L values for alleles that have a frequency in the present that is bounded by two numbers. This is the lower bound.
AlleleFrequencyUp - The program will print the L values for alleles that have a frequency in the present that is bounded by two numbers. This is the upper bound.
NumberOfHaplotypesWithTheDerivedAllele - For every variant, there will be this number of haplotypes with the derived allele.
NumberOfIndependentVariants - How many independent variants will be printed. The number of L values will be equal to 2* NumberOfIndependentVariants * factorial (NumberOfHaplotypesWithTheDerivedAllele)/(factorial (NumberOfHaplotypesWithTheDerivedAllele - 2) * factorial (2))
DemographicScenario - A file containing the demographic scenario simulated. This follows the structure of the demographic scenario specified in the PReFerSim manual. Make sure that this file is also read by PReFerSimParameterFile1 and PReFerSimParameterFile2.
ThetaHaplotype - Theta of the whole haplotype simulated. Note that the variant of interest sits on one end of the haplotype and the L values are the distances from the variant of interest to the first difference between a pair of haplotypes.
RhoHaplotype - Rho of the whole haplotype simulated.
NumberOfSites - Number of sites in the haplotype.

Example of how to run the script:

bash CreateManyFrequencyTrajectories.sh ParameterFile_4Ns10.txt ParameterFile_4Ns10_B.txt 1 0.009999999 0.010000001 40 10 PopulationExpansionModel.txt 600 500 250000

I recommend running the past script with many 'Identifier' numbers many times. You need to start from the number 1 and then go up in consecutive order until you get a big number of allele frequency trajectories, probably a number close to 10,000. Those trajectories will be sampled with replacement to generate the haplotypic data under the stuctured coalescent model. To check the number of allele frequency trajectories you have created run these two commands:

AlleleCount=$( wc -l Results/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount

Then, run the script ConcatenateAlleleFrequencyTrajectories.sh to concatenate the allele frequency trajectories:

bash ConcatenateAlleleFrequencyTrajectories.sh ParameterFile_4Ns10.txt ParameterFile_4Ns10_B.txt 1 0.009999999 0.010000001 40 10 PopulationExpansionModel.txt 600 500 250000

Script structure: 
bash ConcatenateAlleleFrequencyTrajectories.sh <PReFerSimParameterFile1> <PReFerSimParameterFile2> <Identifier> <AlleleFrequencyDown> <AlleleFrequencyUp> <NumberOfHaplotypesWithTheDerivedAllele> <NumberOfIndependentVariants> <DemographicScenario> <ThetaHaplotype> <RhoHaplotype> <NumberOfSites>

The options are identical to the ones given to the script CreateManyFrequencyTrajectories.sh to keep consistency. The variable Identifier is not used since the script will read all the trajectories in the Results/ folder without taking into account the differences in the Identifier number.
This will create a file with all the trajectories generated with CreateManyFrequencyTrajectories.sh. The output is a large file called "../Results/ReducedTrajectories.txt". The allele frequency trajectories from "../Results/ReducedTrajectories.txt" do not track the allele frequency every SINGLE generation. To reduce computing time and disk space, only changes in allele frequency across a set of pre-specified boundaries are tracked, those boundaries can be found in ExamplePipeline/Mssel/freqints.h . If you want to change the boundaries, modify that file and recompile using:

cd Mssel
gcc -O3 -o stepftn stepftn.c -lm

Finally run the following script to simulate haplotypes and compute the L values from the collection of allele frequency trajectories. The allele frequency trajectories will be sampled with replacement from the file ../Results/ReducedTrajectories.txt :

bash SimulateL.sh ParameterFile_4Ns10.txt ParameterFile_4Ns10_B.txt 1 0.009999999 0.010000001 40 10 PopulationExpansionModel.txt 600 500 250000

Script structure:
bash SimulateL.sh <PReFerSimParameterFile1> <PReFerSimParameterFile2> <Identifier> <AlleleFrequencyDown> <AlleleFrequencyUp> <NumberOfHaplotypesWithTheDerivedAllele> <NumberOfIndependentVariants> <DemographicScenario> <ThetaHaplotype> <RhoHaplotype> <NumberOfSites>

With that command line the output will be printed in the folder Results/HapLengths1.txt . The output file will contain the L values. Some L values printed will be equal to 2.0. That happens when there is no difference between a pair of haplotypes sampled. Other L values will have values between 0 and 1, where the values of L in number of bases is equal to the printed value times the value assigned to the variable NumberOfSites.

The past three scripts contain comments with further instructions on the commands used to run the scripts.

Note that you can modify the files <PReFerSimParameterFile1> and <PReFerSimParameterFile1> to simulate alleles evolving under a different selection coefficient or a particular distribution of fitness effects.

2) To run step 2, use the script SimulateUsingISRoutine.sh

bash SimulateUsingISRoutine.sh <HomozygoteFitness> <HeterozygoteFitness> <PresentDayAlleleFrequency> <Replicates> <PresentDayChromosomes> <Identifier> <DemScenario> <SelValuesForwardFile> <SampleSize>

Where:
HomozygoteFitness and HeterozygoteFitness are the fitnesses of the derived homozygote and heterozygote genotypes used when going backwards in time. We used 0 for both values in all our simulations in the paper.
PresentDayAlleleFrequency - Frequency of the derived allele in the present.  This should match what you simulated on step 1.
Replicates - Number of allele frequency trajectories simulated under the importance sampling framework
PresentDayChromosomes - Number of chromosomes in the present.  This should match what you simulated on step 1.
Identifier - A number to give to the script. Can be changed in case the user wants to run the same parameter many times and get a different output with a different identifier every time. Also a random seed.
DemScenario - This follows the syntax from PReFerSim to get demographic histories.  This should match what you simulated on step 1.
SelValuesForwardFile - File with the selection values that will be evaluated when going forwards in time
SampleSize - Number of chromosomes sampled from the present. This should match what you simulated on step 1.

Example of how to run the script:

bash SimulateUsingISRoutine.sh 0.0 0.0 0.01 1000 100000 1 PopulationExpansionModel.txt NewSelectionValues.txt 4000

That scripts runs an importance sampling method based on a paper by Monty Slatkin (2001, Genetics Research) to simulate a set of allele frequency trajectories from genetic variants evolving under a particular strength of natural selection. More details can be found in our paper. I recommend running the past script with many 'Identifier' numbers many times until you get 100,000 trajectories going backwards in time. You need to start from the 'Identifier' number 1 and then go up in consecutive order  To check the number of allele frequency trajectories you have created run these two commands:

Traj=$( wc -l ../Results/ImportanceSamplingSims_*.txtWeightYears.txt | tail -n1 | awk '{print $1}' )
echo $Traj

To reduce computing time and disk space, only changes in allele frequency across a set of pre-specified boundaries are tracked, those boundaries can be found in the file ExamplePipeline/ISProgram/Bounds.txt . The boundaries in that file should match the boundaries in ExamplePipeline/Mssel/freqints.h

Then, run the following script to transform the trajectories into a format usable by mssel:

bash TransformTrajectoriesToMsselFormat.sh <NumberOfSims> <DemographicScenario> <RepsPerSim>

Where:
NumberOfSims - This specifies the number of files where we will transform the trajectories to a mssel format. The identifier number starts with 1 and ends at NumberOfSims. 
DemographicScenario - This follows the syntax from PReFerSim  to get demographic histories.  This should match what you simulated on step 1.
Replicates - Number of allele frequency trajectories simulated under the importance sampling framework in each file produced from each IS run.

Example of how to run the script:

bash TransformTrajectoriesToMsselFormat.sh 1 PopulationExpansionModel.txt 1000

Then run mssel on the trajectories simulated with the IS routine.

Script structure:

bash RunMsselCalculateDistance.sh <ThetaHaplotype> <RhoHaplotype> <Identifier> <DemographicHistory> <NumberOfSites> <Replicates> <SimsPerTrajectory> <NumberOfHaplotypesWithTheDerivedAllele>

Where:
ThetaHaplotype - Theta of the whole haplotype simulated. Note that the variant of interest sits on one end of the haplotype and the L values are the distances from the variant of interest to the first difference between a pair of haplotypes. This should match what you simulated on step 1.
RhoHaplotype - Rho of the whole haplotype simulated. This should match what you simulated on step 1.
Identifier - A number to give to the script. Can be changed in case the user wants to run the same parameter many times and get a different output with a different identifier every time. Also a random seed. This number should match the number used in the script SimulateUsingISRoutine.sh .
DemographicHistory - This follows the syntax from PReFerSim to get demographic histories.  This should match what you simulated on step 1.
Replicates - Number of allele frequency trajectories simulated under the importance sampling framework
NumberOfSites - Number of sites in the haplotype.
SimsPerTrajectory - Number of coalescent simulations that will be done for each trajectory generated under the importance sampling framework.
NumberOfHaplotypesWithTheDerivedAllele - For every coalescent simulation, this will be this number of haplotypes with the derived allele.  This should match what you simulated on step 1.

bash RunMsselCalculateDistance.sh 600 500 1 PopulationExpansionModel.txt 1000 250000 10 40

Then, we create the P(L|s) table using the following script:

bash CreateNewP_L_Given_S_Table.sh <NumberOfIdentifiers>

Where <NumberOfIdentifiers> must match the number of times you ran SimulateUsingISRoutine.sh and RunMsselCalculateDistance.sh starting from 1.

You can estimate the effective sample size (ESS) for each value of selection given in the table provided by the variable SelValuesForwardFile from the script SimulateUsingISRoutine.sh . To do that, run:

perl EstimateESS.pl ../Results/Exit.txtWeightYears.txt

This will create a file called FinalStats.txt . In this file, you will see the ESS's printed in the first columns for each value of selection as given in the table provided by the variable SelectionValuesToEvaluate. Then you will see the expected allele ages followed by the standard deviation of the allele ages.

3) Generate a table that computes the likelihoods of L(alpha, gamma, allele frequency, Demographic scenario | L) for two parameters alpha and gamma of a partially collapsed gamma distribution

Run the script CreateDiscreteDFE.sh after going through step 2):

bash CreateDiscreteDFE.sh

If you want to change the space of alpha and gamma parameters explored you need to modify the R script CreationOfDiscreteDistribution.R. Specifically modify these two lines:

AlphaGrid <- 0.01*1:30
GammaGrid <- 5*1:70

And put the values you wish to explore. Also, currently the threshold 4Ns is equal to 300 (check equation 3 from the paper). If you want to change that, modify the variable UpperThreshold appearing at the top of the script. The integration over the the 4Ns values is done over the integer values of 4Ns (0, 1, 2, ... etc up to the value of the UpperThreshold).

4) Compute the maximum likelihood estimate of either a) the single selection coefficient 4Ns or b) the two parameters alpha and beta.

bash CalculateLLSingleSValue.sh <NumberOfIdentifiers> <SelectionValuesToEvaluate>

Where <NumberOfIdentifiers> must match the number of number of haplotype files starting with the prefix HapLengths that you have on the Results file
<SelectionValues> File with the selection values that will be evaluated.

Example:

bash CalculateLLSingleSValue.sh 1 ../ISProgram/NewSelectionValues.txt

The maximum likelihood estimate will be found in the file ../Results/MaxLLEstimates.txt

You can also do the find the maximum likelihood estimate for the alpha and gamma parameters of a partially collapsed gamma distribution of fitness effects:

bash CalculateLLDFE.sh <NumberOfIdentifiers> <SelectionValuesToEvaluate>

bash CalculateLLDFE.sh 1 ../TableDFE/AnotherExtraTableOfProbabilities.txt

5) Estimate the DFE from DFEf.

If you have an estimate of the DFEf based on the parameters alpha and gamma estimated in 3), you can obtain an estimate of the DFE. To do that, you need to have an estimate of the proportion of alelles at a certain frequency given a certain demographic history including fixations and extinctions over a certain time-span determined by the analyzed demographic history (see equation 4 from our main text). This would be equal to the variable P_F_Given_D. In simulations and in real data this would be equal to the number of variants observed at a certain frequency divided by the total number of variants observed in the demographic history under study. To make things more concrete, let's say you observe 100 variants at a frequency of 0.01 in the present. Then, let's say that you are looking at an scenario of a population expansion, where the number of chromosomes is equal to 10,000 for 80,000 generations and then it is equal to 100,000 chromosomes for 100 generations. If the average number of new mutations in the first epoch is equal to 200, then an estimate of the average new number of mutations is equal to 200*80,000 + (100000/10000)*100 = 16001000 and, therefore the estimate of P_F_Given_D = 100/16001000 = 6.25e-06 . Note that both P_F_Given_D and P_F_given_sj_and_D are equally dependent on the same demographic history, and the ratio of P_F_Given_D / P_F_given_sj_and_D will remain the same if the demographic history goes further back in the time in the most ancestral epoch.

The other probability P_F_given_sj_and_D is equal to the proportion of variants at a certain frequency given that the selection coefficient is inside a certain interval s_j and we have a specified demographic history D. This quantity can be estimated by running forward-in-time simulations using PReFerSim under an arbitrary DFE that simulates a sufficient number of variants across the s_j intervals under study. Then, for each interval s_j, the probability  P_F_given_sj_and_D is the proportion of variants at a certain frequency given an interval of selection values sj and a certain demographic history D. As an example, you could run the following command line in PReFerSim with many different 'IdentifierNumber' integer values starting from 1:

cd DFEfToDFE
bash RunSimsPReFerSim.sh <IdentifierNumber> <ParameterFilePReFerSim>

One example run is:

cd DFEfToDFE
bash RunSimsPReFerSim.sh 1 ParameterFileBoyko.txt

And then, you could get the S values of alleles that have a certain frequency in the present from running the past script many times:

cd DFEfToDFE
perl PrintSValuesAtParticularFrequency.pl <FileOfFrequenciesToRetain> <ExitFile> <PrefixFilesAlleleFreq> <NumberIdentifierFiles>

As an example, you can run:

cd DFEfToDFE
perl PrintSValuesAtParticularFrequency.pl OnePercentVariants.txt ../Results/ExitOnePercentSValuesConstantBoyko.txt ../Results/Output. 2500

After obtaining that file, you can run the following script
bash EstimateDFEfromDFEf.sh <MaxLLestimatesDFE> <P_allele_at_f> <AllelesWithSelectionCoefficientFile> <NumberOfChromosomesInMostAncestralEpoch> <NumberAllelesSimulatedInDemHistory> <FourNsIntervalLength> <FourNsIntervalNumber>

In this particular example it is possible to run:

bash EstimateDFEfromDFEf.sh ../Results/MaxLLEstimatesDFE.txt 3.08e-07 ExitOnePercentSValuesPopExpansionBoyko.txt 10000 2.025e+11 5 30

Where:

MaxLLestimatesDFE - Is a file with one row and two columns that you get after running step 3. This list the maximum likelihood estimate of the shape and scaled parameters of the compound DFEf distribution.
P_allele_at_f - This is the proportion of variants at a certain frequency f given a demographic history and that the variants evolve according to a certain distribution of fitness effects.
AllelesWithSelectionCoefficientFile - This is a file that contains a list of selection coefficients of variants at a frequency f in the population. This file was created by simulating many variants evolving under a PRF model under an arbitrary DFE using PReFerSim. Then, we can use those simulations to count the proportion of variants that have a frequency f in the present and have a selection coefficient inside a certain interval sj in a demographic scenario D (P_F_given_sj_and_D). That proportion would be equal to 1) the number of variants that have a selection coefficient inside a certain interval sj with a frequency f in the present divided by 2) All the variants that have a selection coefficient inside a certain interval sj.
NumberOfChromosomesInMostAncestralEpoch - This is equal to the number of chromosomes in the most old epoch of the demographic scenario studied.
NumberAllelesSimulatedInDemHistory - This is the total number of alleles that were simulated to obtain the results from the AllelesWithSelectionCoefficientFile.
FourNsIntervalLength - This is the length of each of the 4Ns intervals inspected.
FourNsIntervalNumber - How many 4Ns were inspected. The first interval inspected goes from 4Ns = 0 to 4Ns = FourNsIntervalLength, the second interval goes from 4Ns = FourNsIntervalLength to 4Ns = 2*FourNsIntervalLength

6) Calculate L and mean recombination rate from genomic data

The start point are three files: Plink tped and a Plink tfam file where the information has been phased. We also assume that you have a file with the frequency of the low-frequency derived alleles.

bash CalculateLData.sh <PositionsFilePrefix> <SNPNumberToTake> <FrequencyFile> <PlinkTpedFilePrefix> <PlinkTfamFilePrefix> <IndividualsToTake> <HapLengthToTake>

PositionsFilePrefix - This file is produced after running

As an example, you can run:

bash CalculateLData.sh Positions SNPsAtOnePercentFrequency.frq 325 Plink Plink ListUnrelatedSamples.txt 250000

Then, you can also run the following command to get the recombination map:

perl GetGeneticMapLeftRightPrintMap.pl <Bound> <FrequencyFilePrefix> <MapFilePrefix> <Chromosome>

perl GetGeneticMapLeftRightPrintMap.pl 250000 MissenseOnePercent maps_chr. 1

7) ABC algorithm to estimate the demographic history

A demographic model must be specified when analyzing genomic data to infer DFEf or the strength of selection acting on the nonsynonymous variants at a certain frequency in the population (steps 2-4). We used an ABC algorithm to infer the demographic model based on the L values found on the synonymous variants. To do that, we run the following scripts in consecutive order:

bash ABCDemographyAnalysisNotCpGs.sh <Identifier>

Identifier is an integer number. You should run the past script with integer numbers starting from 1 and going up in a consecutive order. As an example, you can run:

bash ABCDemographyAnalysisNotCpGs.sh 1

Then you can run the following script:

perl CalculateMismatchStatistic.pl <LDistributionOnePercent> <NumberIdentifiers>

As an example, here you can run:

perl CalculateMismatchStatistic.pl LDistributionOnePercentSynSites.txt 1

And finally, you can run:

bash ConcatenateMismatchStatisticAndLDistances.sh

You should run CalculateLData.sh on all the synonymous variants at a certain frequency f that you have in your data. Then, you should run
