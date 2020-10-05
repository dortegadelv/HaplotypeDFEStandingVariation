This repository contains the scripts and programs to reproduce all the results from our paper:

Haplotype-based inference of the distribution of fitness effects

Diego Ortega-Del Vecchyo, Kirk E. Lohmueller and John Novembre

## Programs and example pipeline

We included the programs PReFerSim and FoIS in the Programs/ folder along with an example pipeline in the folder Programs/ExamplePipeline . There is a README document in the Programs/ExamplePipeline folder with more instructions on how to run our method to estimate the DFE using the pairwise haplotypic identity by state lengths L:

a) PReFerSim.- We conducted forward simulations using PReFerSim. We include the version of PReFerSim we used in our paper with this repository. Check https://github.com/LohmuellerLab/PReFerSim for the latest version of PReFerSim and the instructions to run PReFerSim. <br>


b) FoIS.- This program implements an importance sampling method based on a paper by Monty Slatkin (2001, Genetics Research) to simulate a set of allele frequency trajectories from genetic variants evolving under a particular strength of natural selection.  We performed some modifications to the original method by Monty Slatkin to:
>  1) Model the uncertainty in our estimate of the population allele frequency.
>  2) Evaluate multiple values of selection using the same set of simulated allele frequency trajectories. <br>


We use this program to calculate the expected value of statistics from alleles that have a particular sample allele frequency in the present, such as the pairwise identity-by state lengths surrounding variants that have a particular strength of natural selection acting on them. The program can model any arbitrary demographic scenario. The options of FoIS can be found in README_FoIS.txt. The files Programs/ExamplePipeline/README.md and Programs/ExamplePipeline/SimulateUsingISRoutine.sh include an example of how to run FoIS. <br>


c) ExamplePipeline.- This pipeline includes scripts that can be used to
>  1) Generate the pairwise identity by state lengths L.
>  2) Generate the table that computes the likelihoods of L(4Ns, allele frequency, Demographic scenario | L) for a single selection coefficient 4Ns (see equation 2 from our paper).
>  3) Generate a table that computes the likelihoods of L(alpha, beta, allele frequency, Demographic scenario | L) for two parameters alpha and beta of a partially collapsed gamma distribution of DFEf, the distribution of fitness effects of variants at a certain frequency (also see equation 3 from our paper).
>  4) Compute the maximum likelihood estimate of either a) the single selection coefficient 4Ns or b) the two parameters alpha and beta of the DFEf.
>  5) Estimate the distribution of fitness effects of new variants, DFE, from the DFEf.
>  6) Calculate L from data.
>  7) An ABC algorithm to estimate demographic history based on the L values at neutral sites.

## Plotting scripts

The folder PlottingScripts/ includes the R scripts we used to create each figure from the paper.

## Commands to reproduce the analysis associated to the main figures from our paper

Check README_ForwardSims.txt for instructions to run forward simulations with PReFerSim that lead to the results shown in figures 2, 4 and 8.

Check README_FoIS.txt for instructions to infer the distribution of fitness effects of variants at a particular frequency. This leads to the results shown in figures 3, 5 and 6.

Check README_DFEUK10K.txt for instructions to infer the distribution of fitness effects of new variants in the UK10K dataset. These analysis lead to the results shown in Figure 9.
