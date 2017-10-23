RandomSeed=1
RandomNumber=1
time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m36.338 -t$RandomNumber -z1 -gpoint 0.0 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S0 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m36.338 -t$RandomNumber -z2 -gpointprob SelPointTest.txt 10000 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S0 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m36.338 -t$RandomNumber -z3 -ggamma 0.184 319.8626 1000 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S0 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m36.338 -t$RandomNumber -z4 -gbeta 0.5 0.5 1.0 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S0 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m36.338 -t$RandomNumber -z5 -gdist -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S0 Test

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m36.338 -t$RandomNumber -z6 -gunifbounds SelUnifBounds.txt 100000 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S0 Test 

time GSL_RNG_SEED=$RandomSeed GSL_RNG_TYPE=mrg ./fwd_seldist_gsl_2012_4epoch.debug -m36.338 -t$RandomNumber -z7 -glognormal 5.02 5.94 1000 -f1.0 -h0.5 -Ffixed 0.0 -n20 -RDemographicHistoryBreedDogs1000.txt -S0 Test

