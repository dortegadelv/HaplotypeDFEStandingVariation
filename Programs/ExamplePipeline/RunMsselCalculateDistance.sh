ThetaHaplotype=$1
RhoHaplotype=$2
Identifier=$3
DemographicHistory=$4
NumberOfSites=$5
Replicates=$6
SimsPerTrajectory=$7
NumberOfHaplotypesWithTheDerivedAllele=$8

### Check if you have all the variables

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

if [ -z "$Identifier" ]
then
      echo "The variable Identifier given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$DemographicHistory" ]
then
      echo "The variable DemographicHistory given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$NumberOfSites" ]
then
      echo "The variable NumberOfSites given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$Replicates" ]
then
      echo "The variable Replicates given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$SimsPerTrajectory" ]
then
      echo "The variable SimsPerTrajectory given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$NumberOfHaplotypesWithTheDerivedAllele" ]
then
      echo "The variable NumberOfHaplotypesWithTheDerivedAllele given in the command line was not given a value in the command line"
      exit 1
fi


cd ISProgram

File="../Results/ExitMsselReducedImportanceSamplingSims_"$Identifier".txtTrajectory.txt"
ExitMssel="../Results/TrajParTrajPartMsselOut_"$Identifier".txt"
MsselFile="../Results/MsselFileOut_"$Identifier".txt"
DistancesFile="../Results/DistancesFile_"$Identifier".txt"
# ./mssel3 3 1000 1 2 $File 1 -r 100 500000 -t 100 > $ExitMssel

rm $DistancesFile

echo "Here"
# perl DistanceToFirstSegregatingSiteMultiSequence.pl TestData/run.2/MsselOutSum.txt TestData/run.2/HapLengthSum.txt 1 2
for (( i=1; i<=$Replicates; i++ ))
do
echo $i
echo "Before $DemographicHistory"
LastPopSize=$( tail -n1 $DemographicHistory | awk '{print $1}' )
echo "Before"

CorrectLastPopSize=$(( LastPopSize / 2 ))
echo "LastPopSize $CorrectLastPopSize"
perl TrajectoryPartMssel.pl $File $i $ExitMssel $CorrectLastPopSize
LastFrequency=$( tail -n1 $ExitMssel | awk '{print $2}' )
echo "After"
echo "Last frequency = "$LastFrequency
if [ "$LastFrequency" == "0.000000" ]
then
echo "NO"
rm $MsselOutput
# for k in {1..1000}
# do

CommandLineMssel=$( perl CreateMsselCommandLine.pl $ThetaHaplotype $RhoHaplotype $DemographicHistory $NumberOfHaplotypesWithTheDerivedAllele $SimsPerTrajectory $NumberOfSites $Identifier | less )

echo "Command line = "$CommandLineMssel
pwd
# ../Mssel/mssel3 3 10 1 2 $ResampledTrajectory 1 -r 500 250000 -t 600 -eN 0.0 1.0 -eN 0.0005 0.1 -seeds $Identifier $Identifier $Identifier > MsselOutput.txt

eval "$CommandLineMssel"

MsselOutput="../Results/MsselOutput"$Identifier".txt"
HapLengths="../Results/Distances"$Identifier".txt"
perl DistanceToFirstSegregatingSiteMultiSequenceFractions.pl $MsselOutput $DistancesFile 1 $NumberOfHaplotypesWithTheDerivedAllele 0 0 25 $NumberOfSites TestT2Bounds.txt

else
Bounds=$( wc -l TestT2Bounds.txt | awk '{print $1}' )
Bounds=$(( $Bounds - 1 ))
Line=""
l=0
while [ "$l" -le "$Bounds" ]; do
  echo "$l"
  l=$(($l + 1))
Line=$Line"0	"
done

echo $Line >> $DistancesFile
fi
done
