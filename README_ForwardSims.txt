1) Simulating forward-in-time allele frequency trajectories

The first step of the analysis performed is to run forward-in-time simulations where we specify that the allele has a sample allele frequency equal to X in the present.

We used the program PReFerSim to perform the forward-in-time simulations. The program can be found in the Programs/ folder.
To compile the version of PReFerSim we used, go to Programs/ and type:

gcc -g -o fwd_seldist_gsl_2012_4epoch.debug fwd_seldist_gsl_2012_4epoch.gutted.dom_inbreedParameterFile.c -lm -lgsl -lgslcblas -O3

You will need the GSL library to compile this program. You can find more instructions to compile the program from our github site https://github.com/LohmuellerLab/PReFerSim/blob/master/PReFerSim_Manual_v2.pdf . You can also find the latest version of our program there.
 
##############################################################################################################################################
########## Below I explain the code I used to run the simulations
##############################################################################################################################################


We ran the forward-in-time simulations by running the following scripts after going into the appropriate directories.
All scripts were run in a computing cluster (either SGE or SLURM cluster) and can be easily run in parallel by changing the value of 
the variable $SGE_TASK_ID (or $SLURM_ARRAY_TASK_ID in the case of the simulations contained in the UK10K_OnePercenters and ConstantPopSize folder) to a different number inside each of the *.sh files. The options given at the top of the *.sh scripts may vary depending on how your computing cluster is set up:

### Generating allele frequency trajectories under a constant population size scenario
cd Scripts/Sims/ConstantPopSize/ForwardSims
mkdir ../../../../Results/ConstantPopSize/
mkdir ../../../../Results/ConstantPopSize/ForwardSims/
mkdir ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0
mkdir ../../../../Results/ConstantPopSize/ForwardSims/4Ns_50
mkdir ../../../../Results/ConstantPopSize/ForwardSims/4Ns_100
mkdir ../../../../Results/ConstantPopSize/ForwardSims/4Ns_-50
mkdir ../../../../Results/ConstantPopSize/ForwardSims/4Ns_-100
qsub -t 1 ConstantSize_4Ns0.sh
qsub -t 1 ConstantSize_4Ns50.sh
qsub -t 1 ConstantSize_4Ns100.sh
qsub -t 1 ConstantSize_4Ns-50.sh
qsub -t 1 ConstantSize_4Ns-100.sh

### Generating allele frequency trajectories under a population expansion scenario
cd Scripts/Sims/PopExpansion/ForwardSims
mkdir ../../../../Results/PopExpansion/
mkdir ../../../../Results/PopExpansion/ForwardSims/
mkdir ../../../../Results/PopExpansion/ForwardSims/4Ns_0
mkdir ../../../../Results/PopExpansion/ForwardSims/4Ns_50
mkdir ../../../../Results/PopExpansion/ForwardSims/4Ns_100
mkdir ../../../../Results/PopExpansion/ForwardSims/4Ns_-50
mkdir ../../../../Results/PopExpansion/ForwardSims/4Ns_-100
qsub -t 1 Expansion_4Ns0.sh
qsub -t 1 Expansion_4Ns50.sh
qsub -t 1 Expansion_4Ns100.sh
qsub -t 1 Expansion_4Ns-50.sh
qsub -t 1 Expansion_4Ns-100.sh

### Generating allele frequency trajectories under an ancient bottleneck scenario
cd Scripts/Sims/AncientBottleneck/ForwardSims
mkdir ../../../../Results/AncientBottleneck/
mkdir ../../../../Results/AncientBottleneck/ForwardSims/
mkdir ../../../../Results/AncientBottleneck/ForwardSims/4Ns_0
mkdir ../../../../Results/AncientBottleneck/ForwardSims/4Ns_50
mkdir ../../../../Results/AncientBottleneck/ForwardSims/4Ns_100
mkdir ../../../../Results/AncientBottleneck/ForwardSims/4Ns_-50
mkdir ../../../../Results/AncientBottleneck/ForwardSims/4Ns_-100
qsub -t 1 Expansion_4Ns0.sh
qsub -t 1 Expansion_4Ns50.sh
qsub -t 1 Expansion_4Ns100.sh
qsub -t 1 Expansion_4Ns-50.sh
qsub -t 1 Expansion_4Ns-100.sh

### Generating allele frequency trajectories under the UK10K inferred demographic model
cd Scripts/Sims/UK10K_OnePercenters/ForwardSims
mkdir ../../../../Results/UK10K_OnePercenters/
mkdir ../../../../Results/UK10K_OnePercenters/ForwardSims/
mkdir ../../../../Results/UK10K_OnePercenters/ForwardSims/4Ns_0
mkdir ../../../../Results/UK10K_OnePercenters/ForwardSims/4Ns_25
mkdir ../../../../Results/UK10K_OnePercenters/ForwardSims/4Ns_50
mkdir ../../../../Results/UK10K_OnePercenters/ForwardSims/4Ns_-25
mkdir ../../../../Results/UK10K_OnePercenters/ForwardSims/4Ns_-50
sbatch --array=1 Expansion_4Ns0.sh
sbatch --array=1 Expansion_4Ns25.sh
sbatch --array=1 Expansion_4Ns50.sh
sbatch --array=1 Expansion_4Ns-25.sh
sbatch --array=1 Expansion_4Ns-50.sh

Run the past scripts with many values of $SGE_TASK_ID (or $SLURM_ARRAY_TASK_ID in the case of the simulations contained in the UK10K_OnePercenters folder) until you obtain 10,000 trajectories or more. The number of trajectories obtained can be found by checking the number of alleles printed after running the past scripts. As an example, to check the number of trajectories in a constant population size scenario with a 4Ns value equal to 0 you can type the following command 'wc -l ../../../../Results/ConstantPopSize/ForwardSims/4Ns_0/Alleles*'
Then run the following scripts after going into the appropriate directories. To run these scripts, you will need the program mssel (kindly provided to us from Richard Hudson).
These scripts will change the trajectories into a readable format for mssel and also will reduce the disk space taken by the file containing the allele frequency trajectories.
The allele frequency trajectories are reduced using a set of allele frequency boundaries, where we will only record changes across allele frequency boundaries. The boundaries are defined in Programs/Mssel/freqints.h .
If the user wishes to change those boundaries, modify the vector 'bounds' inside Programs/Mssel/freqints.h to define the new boundaries and recompile the program stepftn using 'gcc -O3 -o stepftn stepftn.c -lm':

cd Scripts/Sims/ConstantPopSize/ForwardSims
bash CreateReducedTrajectoriesFile.sh
cd Scripts/Sims/PopExpansion/ForwardSims
bash CreateReducedTrajectoriesFile.sh
cd Scripts/Sims/AncientBottleneck/ForwardSims
bash CreateReducedTrajectoriesFile.sh
cd Scripts/Sims/UK10K_OnePercenters/ForwardSims
bash CreateReducedTrajectoriesFile.sh

Then, to obtain the mean allele frequency trajectories, run:

mkdir Results/FrequencyTrajectories/
cd Scripts/Sims/ConstantPopSize/ForwardSims
bash CalculateMeanTrajectory.sh
cd Scripts/Sims/PopExpansion/ForwardSims
bash CalculateMeanTrajectory.sh
cd Scripts/Sims/AncientBottleneck/ForwardSims
bash CalculateMeanTrajectory.sh
cd Scripts/Sims/UK10K_OnePercenters/ForwardSims
bash CalculateMeanTrajectory.sh

2) Calculate allele age distributions

First run this script to create a file with 10,000 allele frequency trajectories:

cd Scripts/Sims/ConstantPopSize/ForwardSims
mkdir ../../../../Results/FrequencyTrajectories/
bash PrintThisTrajectoryNumber.sh
cd Scripts/Sims/PopExpansion/ForwardSims
bash PrintThisTrajectoryNumber.sh
cd Scripts/Sims/AncientBottleneck/ForwardSims
bash PrintThisTrajectoryNumber.sh
cd Scripts/Sims/UK10K_OnePercenters/ForwardSims
bash PrintThisTrajectoryNumber.sh

Then, to get the distribution of allele ages, run:

mkdir Results/AlleleAges
cd ConcatenateManyStatisticsScripts
bash GetAgesDistribution.sh

3) Get TTwoDistribution

Run the following script:

mkdir Results/TTwos/
cd ConcatenateManyStatisticsScripts
bash GetTTwosDistribution.sh

4) Get distribution of L values

mkdir Results/DistributionOfL/
cd ConcatenateManyStatisticsScripts
bash CalculatePLGivenSDistribution.sh

