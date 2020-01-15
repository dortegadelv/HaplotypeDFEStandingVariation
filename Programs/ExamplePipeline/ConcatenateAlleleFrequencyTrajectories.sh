#### Parameters of the pipeline

# This is a parameter file that is used to concatenate the allele frequency trajectories of alleles that end at a frequency f in the present and have a particular selection coefficient s.
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

### Concatenate allele frequency trajectories and give them the format required by mssel. If you have many trajectories in the Results/ directory they will be concatenated and put into the file $CurrentTrajs.

cd PReFerSim

CurrentTrajs="../Results/ReducedTrajectories.txt"
ResampledTrajectory="../Results/ResampledTrajs"$Identifier".txt"
TrajsMsselLike="../Results/TrajMsselLike"$Identifier".txt"

LastPopSize=$( tail -n1 $DemographicScenario | awk '{print $1}' )

echo "Last pop size = "$LastPopSize

AlleleCount=$( wc -l ../Results/Alleles_*.txt | tail -n1 | awk '{print $1}' )
echo $AlleleCount
Reps=$( ls ../Results/Alleles_*.txt | wc -l )
perl TrajToMsselFormat.pl ../Results/Traj_ $LastPopSize $TrajsMsselLike $AlleleCount 0 $Reps
cat $TrajsMsselLike | ../Mssel/stepftn > $CurrentTrajs

