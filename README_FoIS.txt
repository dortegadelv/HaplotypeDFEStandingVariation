1) Run FoIS.

Go to these directories and run FoIS on each of the four demographic scenarios.

mkdir Results/ConstantPopSize/ImportanceSamplingSims/
mkdir Results/AncientBottleneck/ImportanceSamplingSims/
mkdir Results/PopExpansion/ImportanceSamplingSims/
mkdir Results/UK10K_OnePercenters/ImportanceSamplingSims/
mkdir Results/UK10K/ImportanceSamplingSims
cd ScriptsOctober22_2017/Sims/ConstantPopSize/ImportanceSamplingSims
SGE_TASK_ID=601
bash RunImportanceSamplingConstantSizeDenserGrid.sh
cd ScriptsOctober22_2017/Sims/AncientBottleneck/ImportanceSamplingSims
bash RunImportanceSamplingPopulationExpansion.sh
cd ScriptsOctober22_2017/Sims/PopExpansion/ImportanceSamplingSims
bash RunImportanceSamplingPopulationExpansion.sh
cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims
bash RunImportanceSamplingPopulationExpansion.sh

Run using values of SGE_TASK_ID that go from 601-700

The output of the program are the simulated allele frequency trajectories that end with a certain frequency in the present. Each trajectory has an associated weight.

Options of the FoIS program as stated in the bash scripts:
A and a are the fitnesses of the derived homozygote and heterozygote genotypes used when going backwards in time.
f frequency of the sampled allele frequency in the present
r number of repetitions
N number of chromosomes in the present
s random seed
b Give a bounds file that defines allele frequency trajectories. The program will only report allele frequency changes that go across the bounds.
D Demographic scenario used.
X Selection values that will be evaluated when going forwards in time
p Number of chromosomes used
t M E C and U are useless parameters, but leave them as they are.
Q gives a F values for using the Balding-Nicholls model. Leave as zero.

2) Run mssel (kindly provided by Richard Hudson) and compute L on the simulated trajectories.

cd ScriptsOctober22_2017/Sims/ConstantPopSize/ImportanceSamplingSims
SGE_TASK_ID=1
bash RunMsselCalculateDistance10000.sh
cd ScriptsOctober22_2017/Sims/AncientBottleneck/ImportanceSamplingSims
bash RunMsselCalculateDistance10000.sh
cd ScriptsOctober22_2017/Sims/PopExpansion/ImportanceSamplingSims
bash RunMsselCalculateDistance10000.sh

#Run using values of SGE_TASK_ID that go from 1-999

SGE_TASK_ID=1
cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims
bash RunMsselCalculateDistanceWithRecombination10000NoSingleton.sh

#Run using values of SGE_TASK_ID that go from 1, 11, 21, 31, …, 9991

3) Concatenate the L results.

cd ScriptsOctober22_2017/Sims/ConstantPopSize/ImportanceSamplingSims
perl SumDistances10000.pl
cd ScriptsOctober22_2017/Sims/AncientBottleneck/ImportanceSamplingSims
perl SumDistances10000.pl
cd ScriptsOctober22_2017/Sims/PopExpansion/ImportanceSamplingSims
perl SumDistances10000.pl
cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims
perl SumDistances10000.pl

4) Compute P(L|s)

cd ScriptsOctober22_2017/Sims/ConstantPopSize/ImportanceSamplingSims
bash CreateNewP_L_Given_S_Table.sh
cd ScriptsOctober22_2017/Sims/AncientBottleneck/ImportanceSamplingSims
bash CreateNewP_L_Given_S_Table.sh
cd ScriptsOctober22_2017/Sims/PopExpansion/ImportanceSamplingSims
bash CreateNewP_L_Given_S_Table.sh
cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims
bash CreateNewP_L_Given_S_Table.sh

The file from ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims/CreateNewP_L_Given_S_Table.sh must be ran from 1-21.

5) Simulate L values using the forward-in-time allele frequency trajectories. You must have already followed the instructions from README_ForwardSims.txt to simulate the trajectories. You must have a ‘ReducedTrajectories10000.txt’ for the demographic scenario and the selection value you want to explore.

cd ScriptsOctober22_2017/Sims/ConcatenateManyStatisticsScripts/
SGE_TASK_ID=1
bash SimulateLDatasetsWithMssel.sh

# Repeat for values of SGE_TASK_ID going from 1-50, 101-151 and 301-351.

cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ForwardSims
SGE_TASK_ID=1
bash RunMssel_4Ns0.sh
SGE_TASK_ID=1
bash RunMssel_4Ns25.sh
SGE_TASK_ID=1
bash RunMssel_4Ns50.sh
SGE_TASK_ID=1
bash RunMssel_4Ns-25.sh
SGE_TASK_ID=1
bash RunMssel_4Ns-50.sh

# Repeat the past commands for values of SGE_TASK_ID going from 1-100

6) Calculate the Log-likelihoods for different values of selection

cd ScriptsOctober22_2017/Sims/ConstantPopSize/ForwardSims
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec.sh
cd ScriptsOctober22_2017/Sims/AncientBottleneck/ForwardSims
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTable.sh
cd ScriptsOctober22_2017/Sims/PopExpansion/ForwardSims
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTable.sh
cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ForwardSims
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableFromSims.sh

Run for SGE_TASK_ID values going from 1 to 5.

7) Get the maximum likelihood estimator for each dataset

cd ScriptsOctober22_2017/Sims/ConstantPopSize/ForwardSims/
bash GetMax4NsValueFromTable.sh
cd ScriptsOctober22_2017/Sims/AncientBottleneck/ForwardSims/
bash GetMax4NsValueFromTable.sh
cd ScriptsOctober22_2017/Sims/PopExpansion/ForwardSims/
bash GetMax4NsValueFromTable.sh
cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ForwardSims
perl GetMax4NsValueSims.pl

8) Calculate effective sample sizes.

cd ScriptsOctober22_2017/Sims/ConstantPopSize/ImportanceSamplingSims/
perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../../Results/ConstantPopSize/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
cd ScriptsOctober22_2017/Sims/PopExpansion/ImportanceSamplingSims/
perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../../Results/PopExpansion/ImportanceSamplingSims/Exit_0.01_0.txtWeightYears.txt
cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims/
perl ../../ConstantPopSize/ImportanceSamplingSims/EstimateAge.pl ../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Exit_DemHistAfricanTennessen.txt_0.01_0.txtWeightYears.txt

## The output ESS is in the FinalStats.txt output file.

### Estimation of parameters of a distribution of fitness effects that has a gamma distribution

1) Run forward-in-time simulations of allele frequency trajectories

mkdir ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/
mkdir ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/PositivePart/
mkdir ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/MousePart/
mkdir ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/PositivePart/
cd ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ForwardSims/
SGE_TASK_ID=1
bash ConstantSizeBoyko.sh
# Run the past script with SGE_TASK_ID values going from 1-2500
cd ScriptsOctober22_2017/Sims/ConstantPopSizeMouse/ForwardSims/
SGE_TASK_ID=1
bash ConstantSizeMouse.sh
# Run the past script with SGE_TASK_ID values going from 1-2500
cd ScriptsOctober22_2017/Sims/PopExpansionBoykoPlusPositive/ForwardSims/
SGE_TASK_ID=1
bash PopExpansionBoyko.sh
# Run the past script with SGE_TASK_ID values going from 1-2500
SGE_TASK_ID=1
bash PopExpansionPositive.sh
# Run the past script with SGE_TASK_ID values going from 1-1500
cd ScriptsOctober22_2017/Sims/PopExpansionMousePlusPositive/ForwardSims/
SGE_TASK_ID=1
bash PopExpansionMouse.sh
# Run the past script with SGE_TASK_ID values going from 1-5000
SGE_TASK_ID=1
bash PopExpansionPositive.sh
# Run the past script with SGE_TASK_ID values going from 1-1500

2) Reduce the trajectories file size and put them into a readable format for mssel:

cd ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ForwardSims
bash CreateReducedTrajectoriesFile.sh
cd ScriptsOctober22_2017/Sims/ConstantPopSizeMouse/ForwardSims
bash CreateReducedTrajectoriesFile.sh
cd ScriptsOctober22_2017/Sims/PopExpansionBoykoPlusPositive/ForwardSims
bash CreateReducedTrajectoriesFile.sh
cd ScriptsOctober22_2017/Sims/PopExpansionMousePlusPositive/ForwardSims
bash CreateReducedTrajectoriesFile.sh

3) Run this script to create a file with 50,000 allele frequency trajectories:

cd ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ForwardSims
bash PrintThisTrajectoryNumber.sh
cd ScriptsOctober22_2017/Sims/ConstantPopSizeMouse/ForwardSims
bash PrintThisTrajectoryNumber.sh
cd ScriptsOctober22_2017/Sims/PopExpansionBoykoPlusPositive/ForwardSims
bash PrintThisTrajectoryNumber.sh
cd ScriptsOctober22_2017/Sims/PopExpansionMousePlusPositive/ForwardSims
bash PrintThisTrajectoryNumber.sh

4) Simulate Data 

cd ScriptsOctober22_2017/Sims/ConcatenateManyStatisticsScripts/
SGE_TASK_ID=1
bash SimulateLDatasetsWithMsselDFEThousands.sh
# Run the past script with SGE_TASK_ID values going from 1-6000
cd ScriptsOctober22_2017/Sims/PopExpansionBoykoPlusPositive/ForwardSims
bash MixBoykoPositiveHapLengths.sh

5) Run FoIS on each of the four demographic scenarios.

mkdir Results/ConstantPopSizeBoyko/ImportanceSampling/
mkdir Results/PopExpansionBoykoPlusPositive/ImportanceSampling/
cd Results/ConstantPopSizeBoyko/ImportanceSampling
SGE_TASK_ID=601
bash RunImportanceSamplingConstantSizeDenserGrid.sh
# Run the past script with SGE_TASK_ID values going from 601-700
cd Results/PopExpansionBoykoPlusPositive/ImportanceSampling
SGE_TASK_ID=601
bash RunImportanceSamplingPopulationExpansion.sh
# Run the past script with SGE_TASK_ID values going from 601-700

6) Run mssel and compute L on the simulated trajectories

cd ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims
SGE_TASK_ID=1
bash RunMsselCalculateDistance10000.sh
cd ScriptsOctober22_2017/Sims/PopExpansionBoykoPlusPositive/ImportanceSamplingSims
SGE_TASK_ID=1
bash RunMsselCalculateDistance10000.sh

Run using values of SGE_TASK_ID that go from 1-999 for both bash scripts

6) Concatenate the L results.

cd ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims
perl SumDistances10000.pl
cd ScriptsOctober22_2017/Sims/PopExpansionBoykoPlusPositive/ImportanceSamplingSims
perl SumDistances10000.pl

7) Compute P(L| distribution of fitness effects of 1% frequency variants) where that distribution follows a gamma distribution and a grid of parameter values for the gamma distribution is explored.

cd ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims
Run R script CreationOfDiscreteDistribution.R to get the file AnotherExtraTableOfProbabilities.txt
bash GetDFETable.sh
cd ScriptsOctober22_2017/Sims/PopExpansionBoykoPlusPositive/ImportanceSamplingSims
Run R script CreationOfDiscreteDistribution.R to get the file AnotherExtraTableOfProbabilities.txt
bash GetDFETable.sh

8) Calculate the log-likelihoods

cd ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ForwardSims/
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec.sh
# Run the past script with values going from 1-100 
cd ScriptsOctober22_2017/Sims/ConstantPopSizeMouse/ForwardSims/
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec.sh
# Run the past script with values going from 1-100 
cd ScriptsOctober22_2017/Sims/PopExpansionBoykoPlusPositive/ForwardSims
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec.sh
# Run the past script with values going from 1-100 
cd ScriptsOctober22_2017/Sims/PopExpansionMousePlusPositive/ForwardSims
SGE_TASK_ID=1
bash CreateSimTestTableWithLLResultsDenseGridNoRec.sh
# Run the past script with values going from 1-100 

9) Get the MLE

cd ScriptsOctober22_2017/Sims/ConcatenateManyStatisticsScripts/GetMLEDFEs
SGE_TASK_ID=1
bash GetMLEDFEs.sh

Run the past script getting the script take values from 1-17.