### How to make sure that the trajectories don't print the frequency information from the random sampling

SGE_TASK_ID=1

GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z8 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 -N1000 -TTestData/run.2/Alleles$SGE_TASK_ID.txt TestData/run.8/Traj_0.01_$SGE_TASK_ID.txt /u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/

GSL_RNG_SEED=$SGE_TASK_ID GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m1000 -t$SGE_TASK_ID -z2 -gpoint 0.0 -f1.0 -h0.5 -F0.0 -n20 -RConstantSizeDemHist.txt -S0 -TTestData/run.2/Alleles$SGE_TASK_ID.txt TestData/run.2/Traj_0.01_$SGE_TASK_ID.txt /u/home/d/diegoort/project/PurifyingSelectionProject/ForwardSimsKirkProgram/NewProgram/TestData/

ls -l TestData/run.2/Traj_0.01_$SGE_TASK_ID.txt
ls -l TestData/run.8/Traj_0.01_$SGE_TASK_ID.txt

## Because these files are identical, I know that the frequency information from the last generation is not printed
diff TestData/run.2/Traj_0.01_$SGE_TASK_ID.txt TestData/run.8/Traj_0.01_$SGE_TASK_ID.txt 

### T-Test for the differences in ages when you do and don't do random sampling on R


Data1 <- read.table("TestData/run.8/Freq0_01.txt")
Data2 <- read.table("TestData/run.2/Freq0_01.txt")
Ages1 <- 25000 - Data1$V2
Ages2 <- 25000 - Data2$V2
> t.test(Ages1,Ages2)

	Welch Two Sample t-test

data:  Ages1 and Ages2
t = -1.6733, df = 39912.56, p-value = 0.09427
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -9.1095121  0.7188349
sample estimates:
mean of x mean of y 
 87.60293  91.79827 

Data1 <- read.table("TestData/run.9/Freq0_01.txt")
Data2 <- read.table("TestData/run.3/Freq0_01.txt")
Ages1 <- 25000 - Data1$V2
Ages2 <- 25000 - Data2$V2
> t.test(Ages1,Ages2)

	Welch Two Sample t-test

data:  Ages1 and Ages2
t = -5.1296, df = 15975.45, p-value = 2.937e-07
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2.0650357 -0.9231851
sample estimates:
mean of x mean of y 
 21.67245  23.16656 

