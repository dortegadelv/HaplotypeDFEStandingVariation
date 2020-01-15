Bound=$1;
FrequencyFilePrefix=$2;
MapFilePrefix=$3;
Chromosome=$4;

### Check if you have all the variables

if [ -z "$Bound" ]
then
      echo "The variable Bound given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$FrequencyFilePrefix" ]
then
      echo "The variable FrequencyFilePrefix given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$MapFilePrefix" ]
then
      echo "The variable MapFilePrefix given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$Chromosome" ]
then
      echo "The variable Chromosome given in the command line was not given a value in the command line"
      exit 1
fi

cd CalculateLData

perl GetGeneticMapLeftRightPrintMap.pl 250000 MissenseOnePercent maps_chr. 1
