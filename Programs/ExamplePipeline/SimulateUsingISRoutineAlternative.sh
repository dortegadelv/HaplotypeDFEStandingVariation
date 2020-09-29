HomozygoteFitness=$1
HeterozygoteFitness=$2
PresentDayAlleleFrequency=$3
Replicates=$4
# PresentDayChromosomes=$5
Identifier=$5
DemScenario=$6
SelValuesForwardFile=$7
SampleSize=$8

cd ISProgram

PresentDayChromosomes=$( tail -n1 $DemScenario | awk '{print $1}' )
echo $PresentDayChromosomes
### Check if you have all the variables

if [ -z "$HomozygoteFitness" ]
then
      echo "The variable HomozygoteFitness given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$HeterozygoteFitness" ]
then
      echo "The variable HeterozygoteFitness given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$PresentDayAlleleFrequency" ]
then
      echo "The variable PresentDayAlleleFrequency given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$Replicates" ]
then
      echo "The variable Replicates given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$PresentDayChromosomes" ]
then
      echo "The variable PresentDayChromosomes given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$Identifier" ]
then
      echo "The variable Identifier given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$DemScenario" ]
then
      echo "The variable DemScenario given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$SelValuesForwardFile" ]
then
      echo "The variable SelValuesForwardFile given in the command line was not given a value in the command line"
      exit 1
fi

if [ -z "$SampleSize" ]
then
      echo "The variable SampleSize given in the command line was not given a value in the command line"
      exit 1
fi

FoISDemScenario=$DemScenario""$Identifier".txt"
perl CreateMsselParameter.pl $DemScenario $FoISDemScenario

ExitPrefix="../Results/ImportanceSamplingSims_"$Identifier".txt"

echo "./FoIS -A $HomozygoteFitness -a $HeterozygoteFitness -f $PresentDayAlleleFrequency -r $Replicates -N $PresentDayChromosomes -s $Identifier -F $ExitPrefix -b Bounds.txt -D $DemScenario -X $SelValuesForwardFile -p $SampleSize"

time ./NewFoIS -A $HomozygoteFitness -a $HeterozygoteFitness -f $PresentDayAlleleFrequency -r $Replicates -N $PresentDayChromosomes -s $Identifier -F $ExitPrefix -D $FoISDemScenario -X $SelValuesForwardFile -p $SampleSize
