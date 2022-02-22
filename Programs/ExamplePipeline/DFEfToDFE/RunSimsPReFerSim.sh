Identifier=$1
PReFerSimFile=$2

time GSL_RNG_SEED=$Identifier GSL_RNG_TYPE=mrg ../PReFerSim/PReFerSim $PReFerSimFile $Identifier

time perl GetListOfRunsWhereFrequencyMatches.pl 0.01 0.01 ../Results/Output.$Identifier.full_out.txt ../Results/Alleles_$Identifier.txt 0
