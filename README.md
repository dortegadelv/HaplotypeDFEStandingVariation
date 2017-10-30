This repository contains all the scripts and programs used in our paper:

Haplotype-based inference of the distribution of fitness effects of segregating variants

Diego Ortega-Del Vecchyo, Kirk Lohmueller and John Novembre

## Programs included

We included these programs in the Programs/ folder:

1. PReFerSim.- We conducted forward simulations using PReFerSim. We include the version of PReFerSim we used in our paper with this repository (but see https://github.com/LohmuellerLab/PReFerSim for the latest version).
2. FoIS.- This program implements an importance sampling method based on a paper by Monty Slatkin (2001, Genetics Research) with some modifications explained in our paper to: 1) Model the uncertainty in our estimate of the population allele frequency and 2) Evaluate multiple values of selection using the same set of simulated allele frequency trajectories. We use this program to calculate the expected value of statistics from alleles that have a particular sample allele frequency in the present. The program can model any arbitrary demographic scenario.

## Plotting scripts

The folder PlottingScripts/ includes the R scripts we used to create each figure from the paper. To run, just change the setwd() command on top of each script to point to the location of PlottingScripts in your local computer.

## Running forward simulations with PReFerSim

Check README_ForwardSims.txt

Figures associated: 2, 4, 8

Supplementary figures associated: 3.

## Running FoIS. Inferring the distribution of fitness effects of variants at a particular frequency

Check README_FoIS.txt

Figures associated: 3, 5, 6

Supplementary figures associated: 1, 2, 3, 4, 5, 7, 8, 9

## Calculating the relationship between the distribution of fitness effects of new variants vs. the distribution of fitness effects of variants at a particular frequency

Check the R scripts associated with the figures shown below.

Figures associated: 7, 9

Supplementary figures associated: 10

## Inferring the distribution of fitness effects of new variants in the UK10K dataset.

Check README_DFEUK10K.txt

Figures associated: 9

Supplementary figures associated: 6