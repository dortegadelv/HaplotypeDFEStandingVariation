gcc -g -o fwd_seldist_gsl_2012_4epoch.debug fwd_seldist_gsl_2012_4epoch.gutted.dom_inbreedParameterFile.c -lm -lgsl -lgslcblas -O3

RandomSeed=1
RandomNumber=1

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile1.txt 1

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile2.txt 2

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile3.txt 3

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile4.txt 4

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile5.txt 5

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile6.txt 6

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile7.txt 7

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile8.txt 8

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile9.txt 9

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile10.txt 10

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile12.txt 12

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile13.txt 13

############ SFS check ## Theta 4 and
for i in {101..1100}
do
time GSL_RNG_SEED=$i GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile14.txt $i
done

for i in {2101..2200}
do
time GSL_RNG_SEED=$i GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile15.txt $i
done
cat Output.{2101..2200}.sfs_out.txt > Output.NoBurnInSFS.txt
unexpand Output.NoBurnInSFS.txt > Output.NoBurnInSFSTab.txt

for i in {1101..2100}
do
time GSL_RNG_SEED=$i GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile16.txt $i
done
cat Output.{1101..2100}.sfs_out.txt > AllSFS_2.txt
unexpand AllSFS_2.txt > AllSFSTab_2.txt

#### Gamma = 0

for i in {2301..3200}
do
time GSL_RNG_SEED=$i GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile17.txt $i
done

cat MiniTest/Output.{2201..3200}.sfs_out.txt > MiniTest/AllSFS_3.txt
unexpand MiniTest/AllSFS_3.txt > MiniTest/AllSFSTab_3.txt


for i in {3420..4200}
do
time GSL_RNG_SEED=$i GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug ParameterFile18.txt $i
done

cat MiniTest/Output.{3201..4200}.sfs_out.txt > MiniTest/AllSFS_4.txt
unexpand MiniTest/AllSFS_4.txt > MiniTest/AllSFSTab_4.txt




