gcc -g -o fwd_seldist_gsl_2012_4epoch.original.debug fwd_seldist_gsl_2012_4epoch.gutted.dom_inbreed.c -lm -lgsl -lgslcblas -O3


RandomSeed=1
RandomNumber=1

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t1 -z1 -gpoint 0.0 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t2 -z1 -ggamma 0.184 319.8626 1000 -f1.0 -h0.5 -Fchanged FChangedExample.txt -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t3 -z1 -gpoint 0.0 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t4 -z1 -gpoint 0.0 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t5 -z1 -gpointprob SelPointTest.txt 10000 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t6 -z1 -ggamma 0.184 319.8626 1000 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t7 -z1 -gbeta 0.5 0.5 1.0 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t8 -z1 -gdist -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t9 -z1 -gunifbounds SelUnifBounds.txt 100000 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t10 -z1 -glognormal 5.02 5.94 1000 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t12 -z1 -ggamma 0.184 319.8626 1000 -f1.0 -h0.5 -Fchanged FChangedExample.txt -r 1 0.0 1.0 0 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.original.debug -m4 -t13 -z1 -ggamma 0.184 319.8626 1000 -f1.0 -h0.5 -Fchanged FChangedExample.txt -r 1 0.9 1.0 1 -n20 -RDemographicHistoryBreedDogs1000.txt -S1 1 Test
