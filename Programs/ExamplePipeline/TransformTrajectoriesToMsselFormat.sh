NumberOfSims=$1
DemographicScenario=$2
RepsPerSim=$3

### Check if you have all the variables

if [ -z "$NumberOfSims" ]
then
      echo "The variable NumberOfSims given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$DemographicScenario" ]
then
      echo "The variable DemographicScenario given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$RepsPerSim" ]
then
      echo "The variable RepsPerSim given in the command line was not given a value in the command line"
      exit 1
fi


cd ISProgram

LastPopSize=$( tail -n1 $DemographicScenario | awk '{print $1}' )
LastPopSize=$(( LastPopSize / 2 ))

for (( i=1; i<=$NumberOfSims; i++ ))
do
echo $i
Sum=$(( $i + 1000 ))
FileOne="../Results/ImportanceSamplingSims_"$i".txtTrajectory.txt"
ExitFile="../Results/ExitMsselImportanceSamplingSims_"$i".txtTrajectory.txt"
CurrentTrajs="../Results/ExitMsselReducedImportanceSamplingSims_"$i".txtTrajectory.txt"
perl TrajToMsselFormatReverse.pl $FileOne $ExitFile $RepsPerSim $LastPopSize
cat $ExitFile | ../Mssel/stepftn > $CurrentTrajs
done
