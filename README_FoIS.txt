################ Broad overview of how FoIS works

1) Run FoIS to use the importance sampling approach that simulates a set of allele frequency trajectories that end at a frequency f in the present. Those trajectories are simulated started from a frequency f in the present and going backwards in time. A set of selection values is given as an input to the program (option X). We will give a weight wi for each trajectory and value of selection given to the program (see section “Integration over the space of allele frequency trajectories using importance sampling” from our manuscript).
2) Run mssel to simulate many values of the pairwise identity by state L for each allele frequency trajectory Hi. We simulate many values of L for each allele frequency trajectory.
3) Compute P(L|Hi) for each allele frequency trajectory Hi.
4) Calculate P(L|s) using P(L|Hi) and the weights wi.

### Using the values of P(L|s) to estimate the values of selection given a set of L values.

1) Simulate a set of forward-in-time allele frequency trajectories that end at a frequency f and have a selection value s.
2) Simulate L values given from the set of forward-in-time allele frequency trajectories using mssel.
3) Calculate the log-likelihood of having the set of L values given different values of selection s from the P(L|s) table.
4) Find the maximum likelihood estimate of s.

################# End of broad overview

0) Compile FoIS, the program that does the importance sampling routine.

cd /Programs/ISProgram
g++ -o FoIS FoIS.cpp prob.cpp -lm

1) Run FoIS.

After compiling FoIS, go to these directories and run FoIS on each of the four demographic scenarios.

mkdir Results/ConstantPopSize/ImportanceSamplingSims/
mkdir Results/AncientBottleneck/ImportanceSamplingSims/
mkdir Results/PopExpansion/ImportanceSamplingSims/
mkdir Results/UK10K_OnePercenters/ImportanceSamplingSims/
mkdir Results/UK10K/ImportanceSamplingSims
cd Scripts/Sims/ConstantPopSize/ImportanceSamplingSims
bash RunImportanceSamplingConstantSizeDenserGrid.sh
cd Scripts/Sims/AncientBottleneck/ImportanceSamplingSims
bash RunImportanceSamplingPopulationExpansion.sh
cd Scripts/Sims/PopExpansion/ImportanceSamplingSims
bash RunImportanceSamplingPopulationExpansion.sh
cd Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims
bash RunImportanceSamplingPopulationExpansion.sh

Run using values of SLURM_ARRAY_TASK_ID that go from 601-700

The output of the program are the simulated allele frequency trajectories that end with a certain frequency in the present. Each trajectory has an associated weight.

Options of the FoIS program as stated in the bash scripts:
A and a are the fitnesses of the derived homozygote and heterozygote genotypes used when going backwards in time. I used 0 for both values in all our simulations
f frequency of the sampled allele frequency in the present
r number of allele frequency trajectories simulated under the importance sampling framework
N number of chromosomes in the present
s random seed
b The allele frequency trajectories are reduced using a set of allele frequency boundaries, where we will only record changes across allele frequency boundaries. This will be done in the next step of the pipeline using the script 'TransformTrajectoriesToMsselFormat.sh'. The file given to the program (Bounds.txt) is used for the user to keep as a reference and not actually used in the program. The boundaries defined in 'Bounds.txt' are equal to the boundaries defined in Programs/Mssel/freqints.h .
D Demographic scenario used. This follows the syntax from ms. Check Scripts/Sims/PopExpansion/ImportanceSamplingSims/DemHistExpansion.txt for an example. We report the following each line:
- eN refers to a change in population size (only option available at the moment). The next number refers to the time in a scale of 4N0 generations from the present to the past. The next number is a factor that states the change in population size with respect to the present day population. The next number should be set to zero.
X Selection values that will be evaluated when going forwards in time
p Number of chromosomes sampled from the present
t, M, U, Q, E and C are unused options and any change to their values do not change the output of the program.

1.5) Transform the trajectories to the Mssel format

cd Scripts/Sims/ConstantPopSize/ImportanceSamplingSims
bash TransformTrajectoriesToMsselFormat.sh 
cd Scripts/Sims/AncientBottleneck/ImportanceSamplingSims
bash TransformTrajectoriesToMsselFormat.sh 
cd Scripts/Sims/PopExpansion/ImportanceSamplingSims
bash TransformTrajectoriesToMsselFormat.sh 


2) Run mssel (kindly provided by Richard Hudson) and compute L on the simulated trajectories.

cd Scripts/Sims/ConstantPopSize/ImportanceSamplingSims
bash RunMsselCalculateDistance10000.sh
cd Scripts/Sims/AncientBottleneck/ImportanceSamplingSims
bash RunMsselCalculateDistance10000.sh
cd Scripts/Sims/PopExpansion/ImportanceSamplingSims
bash RunMsselCalculateDistance10000.sh

#Run using values of SLURM_ARRAY_TASK_ID that go from 1-100

cd Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims
bash RunMsselCalculateDistanceWithRecombination10000NoSingleton.sh

#Run using values of SLURM_ARRAY_TASK_ID that go from 1-100

3) Concatenate the L results.

cd Scripts/Sims/ConstantPopSize/ImportanceSamplingSims
perl SumDistances10000.pl
cd Scripts/Sims/AncientBottleneck/ImportanceSamplingSims
perl SumDistances10000.pl
cd Scripts/Sims/PopExpansion/ImportanceSamplingSims
perl SumDistances10000.pl
cd Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims
perl SumDistances10000.pl

4) Compute P(L|s)

cd Scripts/Sims/ConstantPopSize/ImportanceSamplingSims
bash CreateNewP_L_Given_S_Table.sh
cd Scripts/Sims/AncientBottleneck/ImportanceSamplingSims
bash CreateNewP_L_Given_S_Table.sh
cd Scripts/Sims/PopExpansion/ImportanceSamplingSims
bash CreateNewP_L_Given_S_Table.sh
cd Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims
bash CreateNewP_L_Given_S_Table.sh

The file from Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims/CreateNewP_L_Given_S_Table.sh must be ran from 1-21.

### Continue checking here
5) Simulate L values using the forward-in-time allele frequency trajectories. You must have already followed the instructions from README_ForwardSims.txt to simulate the trajectories. You must have a ‘ReducedTrajectories10000.txt’ for the demographic scenario and the selection value you want to explore.

cd Scripts/Sims/ConcatenateManyStatisticsScripts/
bash SimulateLDatasetsWithMsselMultiLessBothSides.sh

# Repeat for values of SLURM_ARRAY_TASK_ID going from 1-50, 101-151 and 301-351.

cd Scripts/Sims/UK10K_OnePercenters/ForwardSims
SLURM_ARRAY_TASK_ID=1
bash RunMssel_4Ns0.sh
SLURM_ARRAY_TASK_ID=1
bash RunMssel_4Ns25.sh
SLURM_ARRAY_TASK_ID=1
bash RunMssel_4Ns50.sh
SLURM_ARRAY_TASK_ID=1
bash RunMssel_4Ns-25.sh
SLURM_ARRAY_TASK_ID=1
bash RunMssel_4Ns-50.sh

# Repeat the past commands for values of SLURM_ARRAY_TASK_ID going from 1-100

6) Calculate the Log-likelihoods for different values of selection

cd Scripts/Sims/ConstantPopSize/ForwardSims
SLURM_ARRAY_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRecLess.sh
cd Scripts/Sims/AncientBottleneck/ForwardSims
SLURM_ARRAY_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRecLess.sh
cd Scripts/Sims/PopExpansion/ForwardSims
SLURM_ARRAY_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRecLess.sh

# Run the past commands for SLURM_ARRAY_TASK_ID values going from 1 to 100.

cd Scripts/Sims/UK10K_OnePercenters/ForwardSims
SLURM_ARRAY_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableFromSims.sh

# Run the past commands for SLURM_ARRAY_TASK_ID values going from 1 to 100.


7) Get the maximum likelihood estimator for each dataset

cd Scripts/Sims/ConstantPopSize/ForwardSims/
bash GetMax4NsValueFromTable.sh
cd Scripts/Sims/AncientBottleneck/ForwardSims/
bash GetMax4NsValueFromTable.sh
cd Scripts/Sims/PopExpansion/ForwardSims/
bash GetMax4NsValueFromTable.sh
cd Scripts/Sims/UK10K_OnePercenters/ForwardSims
perl GetMax4NsValueSims.pl

8) Calculate effective sample sizes.

cd Scripts/Sims/ConstantPopSize/ImportanceSamplingSims/
perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
cd Scripts/Sims/PopExpansion/ImportanceSamplingSims/
perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../../Results/PopExpansion/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
cd Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims/
perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0.txtWeightYears.txt

## The output ESS is in the FinalStats.txt output file.

### Estimation of parameters of a distribution of fitness effects that has a gamma distribution

1) Run forward-in-time simulations of allele frequency trajectories

mkdir ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/
mkdir ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/PositivePart/
mkdir ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/MousePart/
mkdir ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/PositivePart/
cd Scripts/Sims/ConstantPopSizeBoyko/ForwardSims/
SGE_TASK_ID=1
bash ConstantSizeBoyko.sh
# Run the past script with SGE_TASK_ID values going from 1-2500
cd Scripts/Sims/ConstantPopSizeMouse/ForwardSims/
SGE_TASK_ID=1
bash ConstantSizeMouse.sh
# Run the past script with SGE_TASK_ID values going from 1-2500
cd Scripts/Sims/PopExpansionBoykoPlusPositive/ForwardSims/
SGE_TASK_ID=1
bash PopExpansionBoyko.sh
# Run the past script with SGE_TASK_ID values going from 1-2500
SGE_TASK_ID=1
bash PopExpansionPositive.sh
# Run the past script with SGE_TASK_ID values going from 1-1500
cd Scripts/Sims/PopExpansionMousePlusPositive/ForwardSims/
SGE_TASK_ID=1
bash PopExpansionMouse.sh
# Run the past script with SGE_TASK_ID values going from 1-5000
SGE_TASK_ID=1
bash PopExpansionPositive.sh
# Run the past script with SGE_TASK_ID values going from 1-1500

2) Reduce the trajectories file size and put them into a readable format for mssel:

cd Scripts/Sims/ConstantPopSizeBoyko/ForwardSims
bash CreateReducedTrajectoriesFile.sh
cd Scripts/Sims/ConstantPopSizeMouse/ForwardSims
bash CreateReducedTrajectoriesFile.sh
cd Scripts/Sims/PopExpansionBoykoPlusPositive/ForwardSims
bash CreateReducedTrajectoriesFile.sh
cd Scripts/Sims/PopExpansionMousePlusPositive/ForwardSims
bash CreateReducedTrajectoriesFile.sh

3) Run this script to create a file with 50,000 allele frequency trajectories:

cd Scripts/Sims/ConstantPopSizeBoyko/ForwardSims
bash PrintThisTrajectoryNumber.sh
cd Scripts/Sims/ConstantPopSizeMouse/ForwardSims
bash PrintThisTrajectoryNumber.sh
cd Scripts/Sims/PopExpansionBoykoPlusPositive/ForwardSims
bash PrintThisTrajectoryNumber.sh
cd Scripts/Sims/PopExpansionMousePlusPositive/ForwardSims
bash PrintThisTrajectoryNumber.sh

4) Simulate Data 

cd Scripts/Sims/ConcatenateManyStatisticsScripts/
SGE_TASK_ID=1
bash SimulateLDatasetsWithMsselDFE.sh
# Run the past script with SGE_TASK_ID values going from 1-600
cd Scripts/Sims/PopExpansionBoykoPlusPositive/ForwardSims
bash MixBoykoPositiveHapLengths.sh

5) Run FoIS on each of the four demographic scenarios.

mkdir Results/ConstantPopSizeBoyko/ImportanceSampling/
mkdir Results/PopExpansionBoykoPlusPositive/ImportanceSampling/
cd Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims
SGE_TASK_ID=601
bash RunImportanceSamplingConstantSizeDenserGrid.sh
# Run the past script with SGE_TASK_ID values going from 601-700
cd Scripts/Sims/PopExpansionBoykoPlusPositive/ImportanceSamplingSims
SGE_TASK_ID=601
bash RunImportanceSamplingPopulationExpansion.sh
# Run the past script with SGE_TASK_ID values going from 601-700

6) Run mssel and compute L on the simulated trajectories

cd Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims
SGE_TASK_ID=1
bash RunMsselCalculateDistance10000.sh
cd Scripts/Sims/PopExpansionBoykoPlusPositive/ImportanceSamplingSims
SGE_TASK_ID=1
bash RunMsselCalculateDistance10000.sh

Run using values of SGE_TASK_ID that go from 1-100 for both bash scripts

6) Concatenate the L results.

cd Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims
perl SumDistances10000.pl
cd Scripts/Sims/PopExpansionBoykoPlusPositive/ImportanceSamplingSims
perl SumDistances10000.pl

7) Compute P(L| distribution of fitness effects of 1% frequency variants) where that distribution follows a gamma distribution and a grid of parameter values for the gamma distribution is explored.

cd Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims
Run R script CreationOfDiscreteDistribution.R to get the file AnotherExtraTableOfProbabilities.txt
bash GetDFETable.sh
cd Scripts/Sims/PopExpansionBoykoPlusPositive/ImportanceSamplingSims
Run R script CreationOfDiscreteDistribution.R to get the file AnotherExtraTableOfProbabilities.txt
bash GetDFETable.sh

8) Calculate the log-likelihoods

cd Scripts/Sims/ConstantPopSizeBoyko/ForwardSims/
bash CreateSimTestTableWithLLResultsDenseGridNoRec.sh
bash CreateSimTestTableWithLLResultsDenseGridNoRecSmall.sh
# Run the past script with values of SLURM_ARRAY_TASK_ID going from 1-500 
cd Scripts/Sims/ConstantPopSizeMouse/ForwardSims/
bash CreateSimTestTableWithLLResultsDenseGridNoRec.sh
bash CreateSimTestTableWithLLResultsDenseGridNoRecSmall.sh
# Run the past script with values of SLURM_ARRAY_TASK_ID going from 1-500 
cd Scripts/Sims/PopExpansionBoykoPlusPositive/ForwardSims
bash CreateSimTestTableWithLLResultsDenseGridNoRec.sh
bash CreateSimTestTableWithLLResultsDenseGridNoRecSmall.sh
# Run the past script with values of SLURM_ARRAY_TASK_ID going from 1-500 
cd Scripts/Sims/PopExpansionMousePlusPositive/ForwardSims
bash CreateSimTestTableWithLLResultsDenseGridNoRec.sh
bash CreateSimTestTableWithLLResultsDenseGridNoRecSmall.sh
# Run the past script with values of SLURM_ARRAY_TASK_ID going from 1-500 

9) Get the MLE

cd Scripts/Sims/ConcatenateManyStatisticsScripts/GetMLEDFEs
bash GetMLEDFEs.sh

Run the past script getting the script to take values from 1-8.

