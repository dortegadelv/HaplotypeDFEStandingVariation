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
cd ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims
bash RunMsselCalculateDistance10000NoSingleton.sh

Run using values of SGE_TASK_ID that go from 1-999

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

Repeat for values of SGE_TASK_ID going from 1-50, 101-151 and 301-351.

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

Run for SGE_TASK_ID values going from 1 to 5.

7) Get the maximum likelihood estimator for each dataset

cd ScriptsOctober22_2017/Sims/ConstantPopSize/ForwardSims/
bash GetMax4NsValueFromTable.sh
cd ScriptsOctober22_2017/Sims/AncientBottleneck/ForwardSims/
bash GetMax4NsValueFromTable.sh
cd ScriptsOctober22_2017/Sims/PopExpansion/ForwardSims/
bash GetMax4NsValueFromTable.sh
 