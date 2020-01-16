#### Parameters of the pipeline

# This is a parameter file that is used to simulate the L values of alleles that end at a frequency f in the present and have a particular selection coefficient s.
PReFerSimParameterFile1=$1
PReFerSimParameterFile2=$2
Identifier=$3
AlleleFrequencyDown=$4
AlleleFrequencyUp=$5
NumberOfHaplotypesWithTheDerivedAllele=$6
NumberOfIndependentVariants=$7
DemographicScenario=$8
ThetaHaplotype=$9
RhoHaplotype=${10}
NumberOfSites=${11}

### Check if you have all the variables

if [ -z "$PReFerSimParameterFile1" ]
then
      echo "The variable PReFerSimParameterFile1 given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$PReFerSimParameterFile2" ]
then
      echo "The variable PReFerSimParameterFile2 given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$Identifier" ]
then
      echo "The variable Identifier given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$AlleleFrequencyDown" ]
then
      echo "The variable AlleleFrequencyDown given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$AlleleFrequencyUp" ]
then
      echo "The variable AlleleFrequencyUp given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$NumberOfHaplotypesWithTheDerivedAllele" ]
then
      echo "The variable NumberOfHaplotypesWithTheDerivedAllele given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$NumberOfIndependentVariants" ]
then
      echo "The variable NumberOfIndependentVariants given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$DemographicScenario" ]
then
      echo "The variable DemographicScenario given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$ThetaHaplotype" ]
then
      echo "The variable ThetaHaplotype given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$RhoHaplotype" ]
then
      echo "The variable RhoHaplotype given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$NumberOfSites" ]
then
      echo "The variable NumberOfSites given in the command line was not given a value in the command line"
      exit 1
fi

cd PReFerSim

CurrentTrajs="../Results/ReducedTrajectories.txt"
ResampledTrajectory="../Results/ResampledTrajs"$Identifier".txt"
# TrajsMsselLike="../Results/TrajMsselLike"$Identifier".txt"

LastPopSize=$( tail -n1 $DemographicScenario | awk '{print $1}' )

### Simulate haplotype data using the allele frequency trajectories with mssel. This process uses the structured coalescent model. The allele frequency trajectories will be sampled with replacement from the file $CurrentTrajs. Then, the pairwise identity by state lengths L will be calculated from the files generated with mssel and will be put into the file that starts with the prefix ../Results/HapLengths

UpperTrajLimit=$( grep 'age' $CurrentTrajs | wc -l )

perl SampleTrajectories.pl $CurrentTrajs $NumberOfIndependentVariants $ResampledTrajectory $Identifier $LastPopSize

CommandLineMssel=$( perl CreateMsselCommandLine.pl $ThetaHaplotype $RhoHaplotype $DemographicScenario $NumberOfHaplotypesWithTheDerivedAllele $NumberOfIndependentVariants $NumberOfSites $Identifier | less )

echo $CommandLineMssel
pwd
# ../Mssel/mssel3 3 10 1 2 $ResampledTrajectory 1 -r 500 250000 -t 600 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds $Identifier $Identifier $Identifier > MsselOutput.txt

eval "$CommandLineMssel"

MsselOutput="../Results/MsselOutput"$Identifier".txt"
HapLengths="../Results/HapLengths"$Identifier".txt"
perl ../DistanceToFirstSegregatingSiteMultiSequence.pl $MsselOutput $HapLengths 1 $NumberOfHaplotypesWithTheDerivedAllele 0 0 25 $NumberOfSites

AlleleFile="../Results/Alleles_"$Identifier".txt"
TrajFile="../Results/Traj_"$Identifier".txt"
# rm $AlleleFile
# rm $MsselOutput
# rm $ResampledTrajectory
# rm $CurrentTrajs
# rm $TrajFile
# rm $TrajsMsselLike
