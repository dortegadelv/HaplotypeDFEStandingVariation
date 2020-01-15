SNPNumberToTake=$1
FrequencyFile=$2
PositionsFilePrefix=$3
PlinkTpedFilePrefix=$4
PlinkTfamFilePrefix=$5
IndividualsToTake=$6
HapLengthToTake=$7

### Check if you have all the variables

if [ -z "$SNPNumberToTake" ]
then
      echo "The variable SNPNumberToTake given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$FrequencyFile" ]
then
      echo "The variable FrequencyFile given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$PositionsFilePrefix" ]
then
      echo "The variable PositionsFilePrefix given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$PlinkTpedFilePrefix" ]
then
      echo "The variable PlinkTpedFilePrefix given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$PlinkTfamFilePrefix" ]
then
      echo "The variable PlinkTfamFilePrefix given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$IndividualsToTake" ]
then
      echo "The variable IndividualsToTake given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$HapLengthToTake" ]
then
      echo "The variable HapLengthToTake given in the command line was not given a value in the command line"
      exit 1
fi

cd CalculateLData

perl CalculateHaplotypeLengths.pl $SNPNumberToTake $FrequencyFile $PositionsFilePrefix $PlinkTpedFilePrefix $PlinkTfamFilePrefix $IndividualsToTake $HapLengthToTake

