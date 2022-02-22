## Example pipeline

The following steps can be used to compute the DFE from a set of simulated L values:

0) Prerequisites
1) Simulate a set of pairwise identity by state lengths L that have a certain distribution of selection coefficients (can be a probability distribution or a point estimate) from alleles that have a certain sample allele frequency f in the present.
2) Generate the table that computes the likelihoods Likelihood(4Ns, allele frequency, Demographic scenario | L) for a single selection coefficient 4Ns (see equation 2 from our paper).
3) Generate a table that computes the likelihoods Likelihood(alpha, beta, allele frequency, Demographic scenario | L) for two parameters alpha and beta of a partially collapsed gamma distribution (see equation 3 from our paper).
4) Use the L values to compute the maximum likelihood estimate of either a) the single selection coefficient 4Ns or b) the two parameters alpha and beta.
5) Estimate the DFE from DFEf.
6) Estimate the value of selection when there are variable recombination rates.

We also provide scripts to calculate L from genomic data. If you compute the L values, we recommend that you do step 7) and then estimate the demographic history using step 8). Then go over steps 2) to 5) to infer the DFE from the collection of L values

7) Calculate L, P(L is inside a window wi) and mean recombination rate from genomic data
8) ABC algorithm to estimate the demographic history

If you only want to run the inference on a set of precomputed L values, follow steps 2-5.

## Step 0) Prerequisites

You need to compile the following programs to run any of the steps. Some programs require the gsl library. More information on how to install it can be found in the PReFerSim manual at https://github.com/LohmuellerLab/PReFerSim

`cd PReFerSim`

`gcc -g -o PReFerSim PReFerSim.c -lm -lgsl -lgslcblas -O3`

`cd ..`

`cd Mssel`

`gcc -O3 -o stepftn stepftn.c -lm`

`gcc -O2 -o mssel3  mssel3.c  rand1.c streecsel.c -lm`

`cd ..`

`cd ISProgram`

`g++ -o FoIS FoIS.cpp prob.cpp -lm`

## 1) Simulation of pairwise identity by state lengths, L, values

The first step is to simulate many allele frequency trajectories under the Poisson Random Field model going forward in time with PReFerSim. To do that, you can run the following bash script by providing the following parameters:

`bash CreateManyFrequencyTrajectories.sh PReFerSimParameterFile1 PReFerSimParameterFile2 Identifier NumberOfHaplotypesWithTheDerivedAllele NumberOfIndependentVariants ThetaHaplotype RhoHaplotype NumberOfSites`

where:

* PReFerSimParameterFile1.- Contains the parameters to run the forward-in-time simulator PReFerSim to get a list of alleles that end inside a certain frequency interval where the distribution of selective coefficients of the simulated alleles is a point value or follows a different probability distribution. This file should be present in the PReFerSim folder.

* PReFerSimParameterFile2.- It is almost the same file as PReFerSimParameterFile1, but it contains two extra options at the bottom that specify the list of alleles whose frequency trajectory you will print, and the output file with the frequency trajectory of those alleles.  This file should be present in the PReFerSim folder. More information on the options of the parameter files can be found in the PReFerSim manual at https://github.com/LohmuellerLab/PReFerSim

* Identifier - A number to give to the script. Can be changed in case the user wants to run the same parameter files PReFerSimParameterFile1 and PReFerSimParameterFile2 many times and get a different output with a different identifier every time. Also a random seed.

* NumberOfHaplotypesWithTheDerivedAllele - For every variant, there will be this number of haplotypes with the derived allele.

* NumberOfIndependentVariants - How many independent variants will be simulated. The number of L values will be equal to 2* NumberOfIndependentVariants * factorial (NumberOfHaplotypesWithTheDerivedAllele)/(factorial (NumberOfHaplotypesWithTheDerivedAllele - 2) * factorial (2))

* ThetaHaplotype - Theta (4Nub = 4 * Population size in the present * mutation rate per base pair * number of bases) of the whole haplotype simulated. Note that the variant of interest sits on one end of the haplotype and the L values are the distances from the variant of interest to the first difference between a pair of haplotypes.

* RhoHaplotype - Rho (4Nrb = 4 * Population size in the present * recombination rate per base pair * number of bases) of the whole haplotype simulated.

* NumberOfSites - Number of sites in the haplotype.

Example of how to run the script:

`bash CreateManyFrequencyTrajectories.sh ParameterFile_4Ns10.txt ParameterFile_4Ns10_B.txt 1 40 10 600 500 250000`

The output of that script will be two files located in the results folder. One file is Results/Traj_Identifier.txt  (substitute Identifier with the value of Identifier given to the script). That file contains the allele frequency trajectories. The other file is Results/Alleles_Identifier.txt which contains the IDs of the alleles that fell inside the frequency interval specified in the script.

I recommend running the past script with many 'Identifier' numbers many times. You need to start from the number 1 and then go up in consecutive order until you get a big number of allele frequency trajectories. A number close to 10,000 is recommended for point 4Ns selection coefficients and  simulations from a DFE. Those trajectories will be sampled with replacement to generate the haplotypic data under the stuctured coalescent model. To check the number of allele frequency trajectories you have created run these two commands:

`AlleleCount=$( wc -l Results/Alleles_*.txt | tail -n1 | awk '{print $1}' )`

`echo $AlleleCount`

The variable $AlleleCount will show the number of allele frequency trajectories created.

Then, run the script ConcatenateAlleleFrequencyTrajectories.sh to concatenate the allele frequency trajectories:

`bash ConcatenateAlleleFrequencyTrajectories.sh ParameterFile_4Ns10.txt ParameterFile_4Ns10_B.txt 1 40 10 600 500 250000`

Script structure: 

`bash ConcatenateAlleleFrequencyTrajectories.sh PReFerSimParameterFile1 PReFerSimParameterFile2 Identifier NumberOfHaplotypesWithTheDerivedAllele NumberOfIndependentVariants ThetaHaplotype RhoHaplotype NumberOfSites`

The options are identical to the ones given to the script CreateManyFrequencyTrajectories.sh to keep consistency. The variable Identifier is not used since the script will read all the trajectories in the Results/ folder without taking into account the differences in the Identifier number.
This will create a file with all the trajectories generated with CreateManyFrequencyTrajectories.sh. The output is a large file called "Results/ReducedTrajectories.txt". The allele frequency trajectories from "Results/ReducedTrajectories.txt" do not track the allele frequency every SINGLE generation. To reduce computing time and disk space, only changes in allele frequency across a set of pre-specified boundaries are tracked, those boundaries can be found in ExamplePipeline/Mssel/freqints.h . If you want to change the boundaries, modify that file and recompile using:

`cd Mssel`

`gcc -O3 -o stepftn stepftn.c -lm`

Finally run the following script to simulate haplotypes under a structured coalescent framework with the program mssel and compute the L values from the collection of simulated haplotypes that contain the derived allele. The allele frequency trajectories will be sampled with replacement from the file Results/ReducedTrajectories.txt :

`bash SimulateL.sh ParameterFile_4Ns10.txt ParameterFile_4Ns10_B.txt 1 40 10 600 500 250000`

Script structure:

`bash SimulateL.sh PReFerSimParameterFile1 PReFerSimParameterFile2 Identifier NumberOfHaplotypesWithTheDerivedAllele NumberOfIndependentVariants ThetaHaplotype RhoHaplotype NumberOfSites`

With that command line the output will be printed in the folder Results/HapLengths1.txt . The output file will contain the L values. Some L values printed will be equal to 2.0. That happens when there is no difference between a pair of haplotypes sampled. Other L values will have values between 0 and 1, where the values of L in number of bases is equal to the printed value times the value assigned to the variable NumberOfSites.

The past three scripts contain comments with further instructions on the commands used to run the scripts.

Note that you can modify the files PReFerSimParameterFile1 and PReFerSimParameterFile2 to simulate alleles evolving under a different point selection coefficient or a particular distribution of fitness effects. There are more instructions on how to do this in the PReFerSim manual.

## 2) Generate the table that computes the likelihoods of Likelihood(4Ns, allele frequency, Demographic scenario | L) for a single selection coefficient 4Ns (see equation 2 from our paper)

The likelihood table will be generated using an importance sampling approach. To run step 2, start by using the script SimulateUsingISRoutine.sh

`bash SimulateUsingISRoutine.sh HomozygoteFitness HeterozygoteFitness PresentDayAlleleFrequency Replicates Identifier DemScenario SelValuesForwardFile SampleSize`

Where:

* HomozygoteFitness and HeterozygoteFitness are the fitnesses of the derived homozygote and heterozygote genotypes used when going backwards in time (see our paper for a description of the importance sampling approach to generate allele frequency trajectories). We used 0 for both values in all our simulations in the paper.

* PresentDayAlleleFrequency - Frequency of the derived allele in the present. If you want to analyze the simulations generated on step 1 make sure that this number is equal to the division of  (NumberOfHaplotypesWithTheDerivedAllele from the script CreateManyFrequencyTrajectories.sh ) )  / ( value of the variable n: from the file PReFerSimParameterFile1 inside CreateManyFrequencyTrajectories.sh  ).

* Replicates - Number of allele frequency trajectories simulated under the importance sampling framework.

* Identifier - A number to give to the script. Can be changed in case the user wants to run the same parameter many times and get a different output with a different identifier every time. Also a random seed.

* DemScenario - Demographic history. This follows the syntax from PReFerSim to get demographic histories.  This should match the variable DemographicHistory: from the file DemographicScenarioFile provided on the script CreateManyFrequencyTrajectories.sh  .

* SelValuesForwardFile - File with the selection coefficient values that will be evaluated when going forwards in time. There should be one selection coefficient per row.

* SampleSize - Number of chromosomes sampled from the present. This should match the number used after the variable 'n: ' inside the files PReFerSimParameterFile1 and PReFerSimParameterFile2 used on the script CreateManyFrequencyTrajectories.sh  .

Example of how to run the script:

`bash SimulateUsingISRoutine.sh 0.0 0.0 0.01 1000 1 PopulationExpansionModel.txt NewSelectionValues.txt 4000`

That scripts runs an importance sampling method based on a paper by Monty Slatkin (2001, Genetics Research) to simulate a set of allele frequency trajectories from genetic variants evolving under a particular strength of natural selection. More details can be found in our paper. I recommend running the past script with many 'Identifier' numbers many times until you get 100,000 trajectories going backwards in time. You need to start from the 'Identifier' number 1 and then go up in consecutive order until a certain integer value NumberOfSims. Two output files will be created: Results/ImportanceSamplingSims_Identifier.txtTrajectory.txt and Results/ImportanceSamplingSims_Identifier.txtWeightYears.txt . The first file contains the simulated trajectories starting from the present and going backwards in time. The second file has the weights associated with each trajectory depending on the selection coefficient used when going forwards in time  (see section 'Integration over the space of allele frequency trajectories using importance sampling' from our paper ). To check the number of allele frequency trajectories you have created run these two commands:

`Traj=$( wc -l Results/ImportanceSamplingSims_*.txtWeightYears.txt | tail -n1 | awk '{print $1}' )`

`echo $Traj`

To reduce computing time and disk space, only changes in allele frequency across a set of pre-specified boundaries are tracked, those boundaries can be found in the file ExamplePipeline/Mssel/freqints.h . Then, we run the following script to transform the trajectories into a format usable by mssel:

`bash TransformTrajectoriesToMsselFormat.sh NumberOfSims DemographicScenario Replicates`

Where:
* NumberOfSims - This specifies the number of files where we will transform the trajectories to a mssel format. The identifier number starts with 1 and ends at NumberOfSims. 

* DemographicScenario - This follows the syntax from PReFerSim to get demographic histories.  This should match the variable DemographicHistory: from the file DemographicScenarioFile provided on the script CreateManyFrequencyTrajectories.sh 

* Replicates - Number of allele frequency trajectories simulated under the importance sampling framework in each file produced from each IS run.

Example of how to run the script:

`bash TransformTrajectoriesToMsselFormat.sh 1 PopulationExpansionModel.txt 1000`

Then run coalescent simulations using mssel on the trajectories simulated with the IS routine. Those simulations will be used to calculate the L values for each simulated trajectory given a set of haplotypes with the derived allele.

Script structure:

`bash RunMsselCalculateDistance.sh ThetaHaplotype RhoHaplotype Identifier DemographicHistory NumberOfSites Replicates SimsPerTrajectory NumberOfHaplotypesWithTheDerivedAllele`

Where:
* ThetaHaplotype - Theta of the whole haplotype simulated. Note that the variant of interest sits on one end of the haplotype and the L values are the distances from the variant of interest to the first difference between a pair of haplotypes. This should match what you simulated on the script CreateManyFrequencyTrajectories.sh .

* RhoHaplotype - Rho of the whole haplotype simulated. This should match what you simulated on the script CreateManyFrequencyTrajectories.sh .

* Identifier - A number to give to the script. Can be changed in case the user wants to run the same parameter file many times and get a different output with a different identifier every time. Also a random seed. This number should match the number used in the script SimulateUsingISRoutine.sh .

* DemographicHistory - This follows the syntax from PReFerSim to get demographic histories.  This should match the variable DemographicHistory: from the file DemographicScenarioFile provided on the script CreateManyFrequencyTrajectories.sh  .

* Replicates - Number of allele frequency trajectories simulated under the importance sampling framework.

* NumberOfSites - Number of sites in the haplotype.

* SimsPerTrajectory - Number of coalescent simulations that will be done for each trajectory generated under the importance sampling framework. An increase of this number generates a bigger precision on the results, since using a greater number of coalescent simulations means a larger collection of L values will be used to calculate P(L|s). We recommend using a value of 100 as done in our paper.

* NumberOfHaplotypesWithTheDerivedAllele - For every coalescent simulation, this will be this number of haplotypes with the derived allele.  This should match what you the variable NumberOfHaplotypesWithTheDerivedAllele used on the script CreateManyFrequencyTrajectories.sh .

You can, as an example, run the following command:

`bash RunMsselCalculateDistance.sh 600 500 1 PopulationExpansionModel.txt 250000 1000 10 40`

The output will be found in the file Results/DistancesFile_Identifier.txt . Each row contains the L values estimated for a given allele frequency trajectory given a set of coalescent simulations with a set of haplotypes that contain the derived allele.

Then, we create the L(4Ns, allele frequency, Demographic scenario | L) table using the following script:

`bash CreateNewP_L_Given_S_Table.sh NumberOfIdentifiers`

If you did simulations using a single identifier number this should be:

`bash CreateNewP_L_Given_S_Table.sh 1`

Where NumberOfIdentifiers must match the number of times you ran SimulateUsingISRoutine.sh and RunMsselCalculateDistance.sh starting from 1 with different consecutive identifier numbers. Three files will be created: Results/Exit.txtWeightYears.txt has the weights (see section 'Integration over the space of allele frequency trajectories using importance sampling'). Results/NewMiniExp10000.txt has the values of L(4Ns, allele frequency, Demographic scenario | L) starting from the third row, where the selection coefficients are listed following the order from in the file SelValuesForwardFile given to the script SimulateUsingISRoutine.sh . The first column gives the likelihood L(4Ns, allele frequency, Demographic scenario | L = w1) for the window w1, the second column gives the likelihood L(4Ns, allele frequency, Demographic scenario | L = w2) for the window w2, etc . The file Results/TableToTest.txt is identical to Results/NewMiniExp10000.txt but with an extra column, which is the first column from Results/NewMiniExp10000.txt duplicated. Results/TableToTest.txt is the file that will be used to calculate the maximum likelihood estimates from a single selection coefficients in step 4).

You can estimate the effective sample size (ESS) for each value of selection given in the table provided by the variable SelValuesForwardFile from the script SimulateUsingISRoutine.sh . To do that, run:

`cd ISProgram`

`perl EstimateESS.pl ../Results/Exit.txtWeightYears.txt`

This will create a file called FinalStats.txt . If this script is ran many times, the results from every run will be printed in a new line after the last line of the file. In this file, you will see the ESS's printed in the first columns for each value of selection in the order given in the table provided by the variable SelectionValuesToEvaluate. Then you will see the expected allele ages followed by the standard deviation of the allele ages. See the section 'Importance sampling' for a description of what the ESS's are. We recommend only trusting estimates of L(4Ns, allele frequency, Demographic scenario | L) on the values of selection s where you have a high ESS number, at least a number bigger than 100.


## 3) Generate a table that computes the likelihoods of L(alpha, beta, allele frequency, Demographic scenario | L) for two parameters alpha and gamma of a partially collapsed gamma distribution

Run the script CreateDiscreteDFE.sh after going through step 2):

`bash CreateDiscreteDFE.sh`

If you want to change the space of alpha and gamma parameters explored you need to modify the R script CreationOfDiscreteDistribution.R. Specifically modify these two lines:

AlphaGrid <- 0.01*1:30

GammaGrid <- 5*1:70

And put the values you wish to explore. Also, currently the threshold 4Ns is equal to 300 (check equation 3 from the paper). If you want to change that, modify the variable UpperThreshold appearing at the top of the script. The integration over the 4Ns values is currently done over the integer values of 4Ns (0, 1, 2, ... etc up to the value of the UpperThreshold). The likelihoods L(alpha, gamma, allele frequency, Demographic scenario | L) will be given on the file Results/DFETableToTest.txt starting from the third row and follow the same format as Results/TableToTest.txt . The order of the alpha and beta parameters from that file is given in the file TableDFE/AnotherExtraTableOfProbabilities.txt . You need to do step 1) and 2) before doing this step.

## 4) Compute the maximum likelihood estimate of either a) the single selection coefficient 4Ns or b) the two parameters alpha and beta.

Structure of the script to calculate the maximum likelihood estimate from one single selection coefficient value:

`bash CalculateLLSingleSValue.sh NumberOfIdentifiers SelectionValuesToEvaluate`

Where:

* NumberOfIdentifiers must match the number of number of haplotype files starting with the prefix HapLengths that you have on the Results folder

* SelectionValues File with the selection values that will be evaluated.

Example:

`bash CalculateLLSingleSValue.sh 1 ../ISProgram/NewSelectionValues.txt`

The maximum likelihood estimate will be found in the file Results/MaxLLEstimates.txt

You can also do the find the maximum likelihood estimate for the alpha and beta parameters of a partially collapsed gamma distribution of fitness effects:

`bash CalculateLLDFE.sh NumberOfIdentifiers SelectionValuesToEvaluate`

`bash CalculateLLDFE.sh 1 ../TableDFE/AnotherExtraTableOfProbabilities.txt`

The maximum likelihood estimate will be in the file Results/MaxLLEstimatesDFE.txt 

## 5) Estimate the DFE from DFEf.

If you have an estimate of the DFEf based on the parameters alpha and beta estimated in 4), you can obtain an estimate of the DFE. To do that, you need to have an estimate of the proportion of alelles at a certain frequency given a certain demographic history including allele fixations and extinctions over a certain time-span determined by the analyzed demographic history (see equation 4 from our main text). This would be equal to the variable P_F_Given_D. In simulations and in real data this would be equal to the number of variants observed at a certain frequency divided by the total number of variants observed in the demographic history under study. To make things more concrete, let's say you observe 100 variants at a frequency of 0.01 in the present. Then, let's say that you are looking at an scenario of a population expansion, where the number of chromosomes is equal to 10,000 for 80,000 generations and then it is equal to 100,000 chromosomes for 100 generations. If the average number of new mutations in the first epoch is equal to 200, then an estimate of the average new number of mutations is equal to 200*80,000 + 200 * (100000/10000) * 100 = 16200000 and, therefore the estimate of P_F_Given_D = 100/16200000 = 6.17e-06 . Note that both P_F_Given_D and P_F_given_sj_and_D are equally dependent on the same demographic history. The ratio of P_F_Given_D / P_F_given_sj_and_D will remain the same if the demographic history goes further back in the time in the most ancestral epoch (our paper contains an example where we ran the ancestral epoch for a longer amount of time). 

The other probability P_F_given_sj_and_D is equal to the proportion of variants at a certain frequency given that the selection coefficient is inside a certain interval s_j and we have a specified demographic history D. This quantity can be estimated by running forward-in-time simulations using PReFerSim under an arbitrary DFE that simulates a sufficient number of variants across the s_j intervals under study. Then, for each interval s_j, the probability P_F_given_sj_and_D is the proportion of variants at a certain frequency given an interval of selection values sj and a certain demographic history D. As an example, you could run the following command line in PReFerSim with many different 'IdentifierNumber' integer values starting from 1:

`cd DFEfToDFE`

`bash RunSimsPReFerSim.sh IdentifierNumber ParameterFilePReFerSim`

One example run is:

`cd DFEfToDFE`

`bash RunSimsPReFerSim.sh 1 ParameterFileBoyko.txt`

And then, you could get the selection coefficient values of alleles that have a certain frequency in the present from running the past script many times with a different IdentifierNumber:

`cd DFEfToDFE`

`perl PrintSValuesAtParticularFrequency.pl FileOfFrequenciesToRetain ExitFile FilesAlleleFreq NumberIdentifierFiles`

Where:

* FileOfFrequenciesToRetain - A file with one number that indicates the frequency of the variants to retain.

* ExitFile - Exit file with the alleles at the frequency specified in FileOfFrequenciesToRetain.

* FilesAlleleFreq - A file with two columns. The first one indicates the allele frequency and the second one indicates the selection coefficient.

* NumberIdentifierFiles - How many files where run with a different IdentifierNumber.

As an example, you can run:

`cd DFEfToDFE`

`perl PrintSValuesAtParticularFrequency.pl OnePercentVariants.txt ../Results/ExitOnePercentSValuesConstantBoyko.txt ../Results/Output. 1`


After obtaining that file, you can run the following script:

`bash EstimateDFEfromDFEf.sh MaxLLestimatesDFE P_allele_at_f AllelesWithSelectionCoefficientFile NumberOfChromosomesInMostAncestralEpoch NumberAllelesSimulatedInDemHistory FourNsIntervalLength FourNsIntervalNumber`

In this particular example it is possible to run:

`bash EstimateDFEfromDFEf.sh ../Results/MaxLLEstimatesDFE.txt 3.08e-07 ExitOnePercentSValuesPopExpansionBoyko.txt 10000 2.025e+11 5 30`

Where:

* MaxLLestimatesDFE - Is a file with one row and two columns that you get after running step 4. This lists the maximum likelihood estimate of the shape and scale parameters of the compound DFEf distribution.

* P_allele_at_f - This is the proportion of variants at a certain frequency f given a demographic history and that the variants evolve according to a certain distribution of fitness effects.

* AllelesWithSelectionCoefficientFile - This is a file that contains a list of selection coefficients of variants at a frequency f in the population. This file was created by simulating many variants evolving under a PRF model under an arbitrary DFE using PReFerSim. Then, we can use those simulations to count the proportion of variants that have a frequency f in the present and have a selection coefficient inside a certain interval sj in a demographic scenario D (P_F_given_sj_and_D). That proportion would be equal to 1) the number of variants that have a selection coefficient inside a certain interval sj with a frequency f in the present divided by 2) All the variants that have a selection coefficient inside a certain interval sj.

* NumberOfChromosomesInMostAncestralEpoch - This is equal to the number of chromosomes in the most old epoch of the demographic scenario studied.

* NumberAllelesSimulatedInDemHistory - This is the total number of alleles that were simulated to obtain the results from the AllelesWithSelectionCoefficientFile.

* FourNsIntervalLength - This is the length of each of the sj 4Ns intervals inspected.

* FourNsIntervalNumber - How many sj 4Ns intervals were inspected. The first interval inspected goes from 4Ns = 0 to 4Ns = FourNsIntervalLength, the second interval goes from 4Ns = FourNsIntervalLength to 4Ns = 2*FourNsIntervalLength

This script will produce two files: Results/DFEf_toDFE.pdf contains a plot with the inferred values of P(sj) and P(sj|f ,D); we will also create a file called 'Probabilities.txt' which contains the probabilities of P(sj) and P(sj|f ,D) across a set of pre-specified sj intervals of 4Ns.

## 6) Estimate the value of selection when there are variable recombination rates.

Run 'GetQuadraticParametersSingle4NsManyCoefficients.R' on R to estimate Likelihood(4Ns, allele frequency, Demographic scenario | L) given different recombination rates. The R script requires 3 files: a) The concatenated Likelihood(4Ns, allele frequency, Demographic scenario | L) table generated for the percentile 0, 5, ..., 95, 100 of the recombination rates in the data ("DifRecRate/FullTable.txt"). This table can be created by following step 2) from this manual for the 21 percentiles indicated, and then concatenating the table starting from the lower to the upper Likelihood(4Ns, allele frequency, Demographic scenario | L) table; b) The percentile 0, 5, ..., 95, 100 of the recombination rates; c) The recombination rates of the analyzed regions at both the upstream and downstream direction of the focal allele ("DifRecRate/ResampledBpRecRatePerVariantNoCpGLeft.txt" and "DifRecRate/ResampledBpRecRatePerVariantNoCpGRight.txt"). The output of this script are the tables Likelihood(4Ns, allele frequency, Demographic scenario | L) given different recombination rates after using our polynomial regression approach. The output of this script are a set of tables "DifRecRate/PLGivenSTableWithRecs*.txt" Where * is replaced by the number of regression coefficients used. Here the recombination rates are the same at both sides of the focal allele.

Then run 'GetQuadraticParametersSingle4NsManyCoefficientsErrorPrint.R' to estimate our error metric after fitting a different number of regression coefficients (see Table S11 from our paper for an example of the error metric values and how we select the number of regression coefficients under our approach).

Then run 'GetQuadraticParametersDFE.R' to get the likelihoods Likelihood(alpha, beta, allele frequency, Demographic scenario | L) for two parameters alpha and beta of a partially collapsed gamma distribution (see equation 3 from our paper) when we have variable recombination rates. In this example, we use the table "DifRecRate/PLGivenSTableWithRecs4.txt", along with a table that lists the probability of having different discrete 4Ns values under a particular DFE ("DifRecRate/DFETableOfProbabilities.txt", see step 3) ) .

Run "bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDifRecRateDifCoef.sh" to estimate the likelihood of selection for the inspected 4Ns values of selection (in this case they go from -200 to 200). Inside the file, $HapFilePrefix specifies the prefix of the L values for 300 different variants. $ResultsFile gives back the likelihood results. "DifRecRate/PLGivenSTableWithRecs4.txt" is the likelihood table Likelihood(4Ns, allele frequency, Demographic scenario | L) given different recombination rates after using our polynomial regression approach with 4 regression coefficients. "300" is the number of inspected variants and "DifRecRate/VariantNumber.txt" are the suffixes of the variant numbers inspected (see "DifRecRate/HapLengthsDifRecRate/HapLengthsLessDifRecRateNS1_{1..300}.txt" to see the L values. the suffixes go from 1 up to 300). The file "CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDifRecRateBoyko.sh" estimates the value of selection for two parameters alpha and beta of a partially collapsed gamma distribution. This file has the same syntax as "CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDifRecRateDifCoef.sh", the only difference is that a file "DifRecRate/PLGivenSTableWithRecsFirstDFE.txt" with the likelihoods of two parameters alpha and beta of a partially collapsed gamma distribution  when we have variable recombination rates is given.

## 7) Calculate L, P(L is inside a window wi) and mean recombination rate from genomic data

The start point are three files: A Plink tped and a Plink tfam file where the information has been phased. We also assume that you have a file with the frequency of the low-frequency derived alleles.

`bash CalculateLData.sh PositionsFilePrefix FrequencySNPFile SNPNumberToTake PlinkTpedFilePrefix PlinkTfamFilePrefix IndividualsToTake HapLengthToTake`

* PositionsFilePrefix - Prefix of the files that contain the positions that will be used to compute L. The positions defined in the files should match the positions from the plink file.

* FrequencySNPFile - A list of the SNPs at a certain frequency in the population. In this file each row contains a SNP. The rows in each file contain: 1) Chromosome Number; 2) Chromosome Number (DOT) SNP Position ; 3) Minor Allele; 4) Major Allele; 5) Minor allele frequency; 6) Chromosome sample size; 7) Type of mutation (can be anything defined by the user); 8) Allele defined as 0 in plink file; 9) Allele defined as 1 in plink file; 10) Ancestral Allele; 11) and 12) An arbitrary nucleotide and an arbitrary number.

* SNPNumberToTake - The row number defining the SNPs that will be taken from the FrequencySNPFile file to calculate L.

* PlinkTpedFilePrefix - Prefix of the plink tped file. This contains the dataset where we will calculate L.

* PlinkTfamFilePrefix - Prefix of the plink tfam file. This contains the dataset where we will calculate L.

* IndividualsToTake - List of individuals from the Plink files that will be used to calculate L.

* HapLengthToTake - The L values calculated will start from the focal variant analyzed up to the value of HapLengthToTake . If there are no differences in the haplotype pairs from the focal variant up to HapLengthToTake, this will be noted in the output. As an example, if the HapLengthToTake value is equal to 250000, then a number of 250001 will indicate that there are no differences between the haplotype pair.

As an example, you can run:

`bash CalculateLData.sh Positions SNPsAtOnePercentFrequency.frq 325 Plink Plink ListUnrelatedSamples.txt 250000`

You can calculate the probability P(L is inside a window wi) using the following script:

`bash CalculateLProportion.sh SNPNumberToTake LBreaksFile`

* SNPNumberToTake - The row number defining the SNPs that will be taken from the FrequencySNPFile file to calculate L.

* LBreaksFile - A file showing the boundaries of the windows wi. Based on this file, the windows wi are (0, 50000], (50000, 100000], (100000, 150000], (150000, 200000], (200000, 250000], (250000, ∞).

As an example, you can run one of the following two commands:

`bash CalculateLProportion.sh 10 LBreaks.txt`

`bash CalculateLProportion.sh 325 LBreaks.txt`

The output file with the prefix "Results/LProportion" has the proportion of L values falling into each of the defined windows. In the case of the example file, we define the proportion of L values falling in the windows (0, 50000], (50000, 100000], (100000, 150000], (150000, 200000], (200000, 250000], (250000, ∞). You can use this file, as an example, to see if more than 5% of the L values fall in each of the windows wi. In our manuscript we recommend to have more than 5% of the L values fall in each of the windows wi if only 6 windows are defined.

Then, you can also run the following command to get the recombination map:

`perl GetGeneticMapLeftRightPrintMap.pl HapLengthToTake FrequencyFilePrefix MapFilePrefix Chromosome`

Where:

* HapLengthToTake - The recombination rate will be estimated from focal variant analyzed up to the value of HapLengthToTake .

* FrequencyFilePrefix - Prefix of the SNPs at a one percent frequency. We will print the mean recombination rate for these variants.

* MapFilePrefix - Recombination map prefix.

* Chromosome - Number of the chromosome that contains the variants that will be analyzed.

Example run:

`cd CalculateLData`

`perl GetGeneticMapLeftRightPrintMap.pl 250000 MissenseOnePercent maps_chr. 1`

## 8) ABC algorithm to estimate the demographic history

A demographic model must be specified when analyzing genomic data to infer DFEf or the point strength of selection acting on the nonsynonymous variants at a certain frequency in the population (steps 2-4). We used an ABC algorithm to infer the demographic model based on the L values found on the synonymous variants. Although the scenario simulated is very specific, we hope that this gives an intuition into how our proposed ABC works. The L values of the synonymous variants are summarized by their frequency in different windows w1, ... , wn. In this example we will use the file located in ExamplePipeline/ABC/LDistributionOnePercentSynSites.txt .

Then, to run the ABC algorithm we run the following scripts in consecutive order:

`bash ABCDemographyAnalysisNotCpGs.sh Identifier`

Identifier is an integer number. You should run the past script with integer numbers starting from 1 and going up in a consecutive order. As an example, you can run:

`cd ABC`

`bash ABCDemographyAnalysisNotCpGs.sh 1`

Then you can run the following script:

`cd ABC`

`perl CalculateMismatchStatistic.pl LDistributionFile NumberIdentifiers`

As an example, here you can run:

`cd ABC`

`perl CalculateMismatchStatistic.pl LDistributionOnePercentSynSites.txt 1`

And finally, you can run:

`bash ConcatenateMismatchStatisticAndLDistances.sh`

And the posterior distribution of the parameters will be given in the file Results/Best100NotCpG.txt . Those are the 100 simulations where the proportion of L values in the windows w1, ... , wn is more similar to what is seen in the synonymous variants. The three parameters analyzed in this demographic model are given in columns 2-4. In this example those parameters are the Ne in the present, the Ne in the epoch that comes before the present epoch and the time where the population size changes to the current day Ne.
