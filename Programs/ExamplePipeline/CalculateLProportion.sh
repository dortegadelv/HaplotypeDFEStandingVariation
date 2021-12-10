SNPNumberToTake=$1
BreaksFile=$2
### Check if you have all the variables

if [ -z "$SNPNumberToTake" ]
then
      echo "The variable SNPNumberToTake given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$BreaksFile" ]
then
      echo "The variable BreaksFile given in the command line was not given a value in the command line"
      exit 1
fi

cd CalculateLData

perl CalculateLProportion.pl $SNPNumberToTake $BreaksFile

