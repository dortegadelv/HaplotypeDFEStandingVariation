### SI 1

Follow the instructions from README_FoIS.txt and README_ForwardSims.txt to get the data for the ancient bottleneck results.

### SI 2

Follow README_FoIS.txt to get MLE estimates of the DFE, and just run the SuppFigure2_New_MeanDFEMouseHuman2DemScenarios R script in the PlottingScripts to get the results.

### SI 3

Run HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansionMousePlusPositive/ForwardSims/PopExpansionMouse.sh with many $SGE_TASK_ID values until you get at least 5,000 variants ending at a 1% frequency. Run the scripts HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansionBoykoWeakPlusPositive/ForwardSims/PopExpansionBoyko.sh with many $SGE_TASK_ID values to get 5,000 variants. If needed, create the results directories to direct the output files from those two bash scripts.

Then run the two lines from HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/PrintSValuesAtParticularFrequency.sh that help you obtain the files ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionBoykoWeak.txt 
and ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouse5000.txt

### SI 4

Run HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansionBoykoPlusPositiveLongBurnIn/ForwardSims/PopExpansionBoyko.sh with many $SGE_TASK_ID values until you get at least 5,000 variants ending at a 1% frequency. Run the scripts HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansionBoykoPlusPositiveLongerBurnIn/ForwardSims/PopExpansionBoyko.sh with many $SGE_TASK_ID values to get 5,000 variants. Run HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansionMousePlusPositiveLongBurnIn/ForwardSims/PopExpansionBoyko.sh with many $SGE_TASK_ID values until you get at least 5,000 variants ending at a 1% frequency. Run the scripts HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansionMousePlusPositiveLongerBurnIn/ForwardSims/PopExpansionBoyko.sh with many $SGE_TASK_ID values to get 5,000 variants. If needed, create the results directories to direct the output files from those two bash scripts.

Then run the lines from HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/PrintSValuesAtParticularFrequency.sh that help you obtain the files ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionBoykoLongBurnIn.txt ,
 ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouseLongBurnIn.txt , ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionBoykoLongerBurnIn.txt ,
 ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouseLongerBurnIn.txt

### SI 5


Run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSizeBoyko/ForwardSims/ConstantSizeBoyko.sh with many $SGE_TASK_ID values until you get at least 5,000 variants ending at a 1% frequency. Run the scripts HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSizeLongBurnInBoyko/ForwardSims/ConstantSizeBoyko.sh with many $SGE_TASK_ID values to get 5,000 variants. Run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSizeLongerBurnInBoyko/ForwardSims/ConstantSizeBoyko.sh with many $SGE_TASK_ID values until you get at least 5,000 variants ending at a 1% frequency.
Run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSizeMouse/ForwardSims/ConstantSizeMouse.sh with many $SGE_TASK_ID values until you get at least 5,000 variants ending at a 1% frequency. Run the scripts HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSizeLongBurnInMouse/ForwardSims/ConstantSizeMouse.sh with many $SGE_TASK_ID values to get 5,000 variants. Run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSizeLongerBurnInMouse/ForwardSims/ConstantSizeMouse.sh with many $SGE_TASK_ID values until you get at least 5,000 variants ending at a 1% frequency. If needed, create the results directories to direct the output files from those two bash scripts.


Then run the lines from HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/PrintSValuesAtParticularFrequency.sh that help you obtain the files ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantMouse.txt ,
 ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantMouseLongBurnIn.txt , ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantMouseLongerBurnIn.txt , ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantBoyko.txt ,
 ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantBoykoLongBurnIn.txt , ../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantBoykoLongerBurnIn.txt .

### SI 6

Follow README_FoIS.txt to get the results needed to do this plot.

### SI 7 and 8

Run 
HaplotypeDFEStandingVariation/Scripts/DataAnalysis/InferDFEWithHapLengths/ABC_Analysis/ABCDemographyAnalysisConstantPopSizeNotCpGs.sh and HaplotypeDFEStandingVariation/Scripts/DataAnalysis/InferDFEWithHapLengths/ABC_Analysis/ABCDemographyAnalysisPopExpansionNotCpGs.sh 500 times each with a different SLURM_TASK_ID value.

Then run the commands in HaplotypeDFEStandingVariation/Scripts/DataAnalysis/InferDFEWithHapLengths/ABC_Analysis/ConcatenateMismatchStatisticAndLDistances.sh to get 5 Results/ABCResults/Best100NotCpGPopExpansion files . Also get 5 Results/ABCResults/Best100NotCpGConstantPopSize files.

### SI 9

Run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/ConstantSize_4Ns0_99PercentFreqAllele.sh , HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/ConstantSize_4Ns50_99PercentFreqAllele.sh and HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/ConstantSize_4Ns100_99PercentFreqAllele.sh to get 10,000 allele frequency trajectories. Do the same with HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansion/ForwardSims/ConstantSize_4Ns0_99PercentFreqAllele.sh , HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansion/ForwardSims/ConstantSize_4Ns50_99PercentFreqAllele.sh and HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansion/ForwardSims/ConstantSize_4Ns100_99PercentFreqAllele.sh to get 10,000 allele frequency trajectories. Then run the commands shown after '############## HF' to get the reduced trajectories in HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/CreateReducedTrajectoriesFileHF.sh . Also get the 10,000 trajectories in HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansion/ForwardSims/CreateReducedTrajectoriesFileHF.sh

Run HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesMisspecifiedAncestralState.sh with SGE_TASK_ID values from 101-150 and 301-350. Then run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRecLessAncMisspecified.sh from 1-100 and HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansion/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRecLessAncMisspecified.sh from 1-100.

Then run the commands from HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansion/ForwardSims/GetMax4NsValueFromTable.sh and HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.sh to get the results starting with SelectionPopExpansionAncestryMisspecified and SelectionConstantPopSizeAncestryMisspecified.

### SI 10

Run HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesDeleteSingletons.sh from 101-150 and 301-350.

Run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSizeNoSingletons/ImportanceSamplingSimsRunMsselCalculateDistance10000.sh from 1 to 1000. Then run SumDistances10000.pl and then run CreateNewP_L_Given_S_Table.sh
 
Then run the commands from HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansion/ForwardSims/GetMax4NsValueFromTable.sh and HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.sh to get the results starting with SelectionPopExpansionAncestryMisspecified and SelectionConstantPopSizeAncestryMisspecified. 

### SI 11 and 12

Run HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesPhasing.sh with SGE_TASK_ID values from 101-150 and 301-350.

Then run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRecLessPhasing.sh from 1-100 

Then run the commands from HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansion/ForwardSims/GetMax4NsValueFromTable.sh and HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.sh to get the results starting with SelectionPopExpansionPhasing and SelectionConstantPopSizePhasing. 

### SI 13 and 14

Run HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesFivePercentBigMut.sh , HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesFivePercentSmallMut.sh , HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesFivePercentFivePercentBigMut.sh , HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesFivePercentFivePercentSmallMut.sh , HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesFivePercentBigRec.sh , HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesFivePercentSmallRec.sh , HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesFivePercentFivePercentBigRec.sh , HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesFivePercentFivePercentSmallRec.sh , with SLURM_TASK_ID values from 101-150 and 301-350.

Then run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRecLessRecMisspecified.sh, HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRecLessMutMisspecified.sh, HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRecLessRecMutFivePercentMisspecified.sh from 1-100 

Then run the commands from HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansion/ForwardSims/GetMax4NsValueFromTable.sh and HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ForwardSims/GetMax4NsValueFromTable.sh to run the commands after the line starting with #### Rec and Mut Misspecification

## SI 15, 16, 17 and 18

The simulations can be performed using different values of the SLURM_TASK_ID values in the files /HaplotypeDFEStandingVariation/Scripts/Sims/SLiM/PopExpansion/PopExpansionChangedRecRate/SimulationPipeline.sh , /HaplotypeDFEStandingVariation/Scripts/Sims/SLiM/PopExpansion/PopExpansionChangedRecRate4Ns50/SimulationPipeline.sh , /HaplotypeDFEStandingVariation/Scripts/Sims/SLiM/PopExpansion/PopExpansionChangedRecRate4Ns100/SimulationPipeline.sh , /HaplotypeDFEStandingVariation/Scripts/Sims/SLiM/PopExpansion/PopExpansionChangedRecRateBoykoDFE/SimulationPipeline.sh . Run those commands until you obtain at least 600 Nonsynonymous (ReplicateNS_HapLength* file) and synonymous (ReplicateSyn_HapLength* file) files replicates when running perl SeparateNSandSynHapLengthFiles.pl in each directory.

Then we use the perl script ShuffleLDistribution.pl to create 10 replicates of L values with synonymous sites. We must provide a number to that script in the command line (e.g. run perl ShuffleLDistribution.pl 1). Then run the commands below ´########## Random´ on the file LCalculationsSyn.sh to get the L distribution file 'LDistributionSynSitesRand$i.txt' where $i takes a value from 1 to 10.

The script LCalculationsBootstrap.sh is used to create 100 replicates of L values in nonsynonymous sites.

We used the 7 scripts from the directory Scripts/DataAnalysis/InferDFEWithHapLengths/ . Those are ABC_AnalysisRunSLiMABCPipelinePart1SaveBoykoParametersPart1RunPReFerSim.sh $i , RunSLiMABCPipelinePart2SaveBoykoParametersPart2.sh $i , RunSLiMABCPipelinePart3SaveBoykoParametersPart3.sh $i ,... RunSLiMABCPipelinePart7SaveBoykoParametersPart7.sh $i with values of $i from 1 to 10 to obtain our results. We create a different demographic model with each value of $i from the distribution of L obtained with synonymous sites when running ShuffleLDistribution.pl. The $i values given here must match the values given to the script ShuffleLDistribution.pl .

## SI 19

Run the script /HaplotypeDFEStandingVariation/Scripts/DataAnalysis/InferDFEWithHapLengths/ABC_Analysis/ABCDemographyAnalysisNotCpGs.sh 500 times to obtain data from simulations to perform the ABC analysis.

## SI 20

We ran the Scripts/DataAnalysis/InferDFEWithHapLengths/CompareFunctionalContentNS.pl and HaplotypeDFEStandingVariation/Scripts/DataAnalysis/InferDFEWithHapLengths/CompareBValuesContent.pl . Note that these scripts require genome-wide data from the B statistic and the PhastCons files.

## SI 21

We ran HaplotypeSelectionProject/Scripts/DataAnalysis/InferDFEWithHapLengths/GetGeneticMapLeftRightSynonymousNotCpGPrintMap.pl This script also requires processing the recombination rate map data from DeCoDe Genetics

## SI 22

We ran HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns-25.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns-50.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns0.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns25.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns50.sh with values from 1 to 50 in SLURM_TASK_ID in each case.

Then we ran Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableFromSims.sh with values from 1 to 50.

Then run Scripts/Sims/UK10K_OnePercenters/ForwardSims/GetMax4NsValueSims.pl 

## SI 23

cd Scripts/Sims/UK10K_OnePercenters/ForwardSims
sbatch --array=1-21 RunMssel_4Ns0singleRecManyRec.sh
sbatch --array=1-21 RunMssel_4Ns25singleRecManyRec.sh
sbatch --array=1-21 RunMssel_4Ns50singleRecManyRec.sh
sbatch --array=1-21 RunMssel_4Ns-25singleRecManyRec.sh
sbatch --array=1-21 RunMssel_4Ns-50singleRecManyRec.sh


Then we ran HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableFromSimsSingleRecMany.sh with values from 1 to 21.

Then run Scripts/Sims/UK10K_OnePercenters/ForwardSims/GetMax4NsValueSimsSingleRec.pl 

## SI 24 and 25

Run the forward in time simulations and get the ESS from SI 23, README_FoIS.txt and README_ForwardSims.txt. Then run HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/CalculatePLGivenSDistribution.sh
and HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/CalculatePLGivenSDistributionUK10K.sh

## SI 26

Run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ImportanceSamplingSims/CreateNewP_L_Given_S_Table1000.sh after following README_FoIS.txt and then run cd Scripts/Sims/ConstantPopSize/ForwardSims
sbatch --array=1-100 CreateSimTestTableWithLLResultsDenseGridNoRecLess.sh

cd Scripts/Sims/ConstantPopSize/ForwardSims/
bash GetMax4NsValueFromTable.sh

Also:

Run HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSize/ImportanceSamplingSims/CreateNewP_L_Given_S_Table100.sh after following README_FoIS.txt and then run cd Scripts/Sims/ConstantPopSize/ForwardSims
sbatch --array=1-100 CreateSimTestTableWithLLResultsDenseGridNoRecLess.sh

cd Scripts/Sims/ConstantPopSize/ForwardSims/
bash GetMax4NsValueFromTable.sh

## SI 27

Follow README_DFEUK10K.txt and then run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns0NewMisspecifiedAncestralState.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns25NewMisspecifiedAncestralState.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns50NewMisspecifiedAncestralState.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns-25NewMisspecifiedAncestralState.sh and HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns-50NewMisspecifiedAncestralState.sh taking values from 1 to 21 in SLURM_TASK_ID.

Run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableFromSimsSingleRecManyMisspecifiedAncestralState.sh taking values from 1 to 21 in SLURM_TASK_ID.

## SI 28

Follow README_DFEUK10K.txt and then run HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesPhasingUK10K.sh for SLURM_TASK_ID values going from 551-560 , HaplotypeDFEStandingVariation/Scripts/Sims/ConcatenateManyStatisticsScripts/SimulateLDatasetsWithMsselMultiLessBothSidesPhasingPartTwoUK10K.sh for SLURM_TASK_ID values going from 18001-19500 , SimulateLDatasetsWithMsselMultiLessBothSidesPhasingPartThreeUK10K.sh  for SLURM_TASK_ID values going from 18001-19500.

Run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRecLessPhasing.sh taking values from 1 to 500 in SLURM_TASK_ID.

## SI 29

Follow README_DFEUK10K.txt . Then run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns0singleRecManyRecHighMut.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns0singleRecManyRecLowMut.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns-25singleRecManyRecHighMut.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns-25singleRecManyRecLowMut.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns-50singleRecManyRecHighMut.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_4Ns-50singleRecManyRecLowMut.sh for a SLURM_TASK_ID value of 11.

Run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableFromSimsSingleRecManyMisMut.sh for SLURM_TASK_ID values going from 51-55.

## SI 30 and SI 31

Follow README_DFEUK10K.txt . Then run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/Expansion_DFE.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/Expansion_DFEHighPop.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/Expansion_DFEMouse.sh and HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/Expansion_DFEMouseHighPop.sh with SLURM_TASK_ID values from 1 to 100.

Run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateReducedTrajectoriesFileAllDFE.sh

Run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_DFE.sh and HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_DFEMouse.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_DFEHighPop.sh and HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RunMssel_DFEMouseHighPop.sh with SLURM_TASK_ID values from 1 to 100.

Run 
HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEHighPopSims.sh and HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFESims.sh , HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEAnotherSims.sh and HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEHighPopAnotherSims.sh with SLURM_TASK_ID values from 1 to 100.

Then run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/GetMax4NsValueSimsLargerSpaceDFE.pl and HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/GetMax4NsValueSimsLargerSpaceHighPopDFE.pl

## SI 32

Follow README_DFEUK10K.txt . Then run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableBootstrap.sh with SLURM_TASK_ID values from 1 to 100.

Then run perl GetMax4NsValueBootstrap.pl

## SI 33

Follow README_DFEUK10K.txt . Then run HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/CreateSimTestTableWithLLResultsDenseGridNoRec_NewPLGivenSTableDFEBootstrap.sh with SLURM_TASK_ID values from 1 to 100.

Then run perl GetMax4NsValueDFEBootstrap.pl

## SI 34

Just Follow README_DFEUK10K.txt .

## SI 35

Follow README_DFEUK10K.txt and the instructions to make SI 28.

## SI 36

Follow README_DFEUK10K.txt 