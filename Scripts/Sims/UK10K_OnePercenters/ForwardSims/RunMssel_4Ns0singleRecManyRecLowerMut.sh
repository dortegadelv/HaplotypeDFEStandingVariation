#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.out
#SBATCH --error=example_sbatch.err
#SBATCH --time=24:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1000

module load python

TrajNum=$( wc -l ../../../../Results/UK10K/ForwardSims/4Ns_-50/Alleles{1..120}.txt | tail -n1 | awk '{print $1}' )
echo $TrajNum

## For Single Sequence
NumberOfMarkers[1]="1000"
NumberOfMarkers[2]="5000"
NumberOfMarkers[3]="273"

## For Multi Sequence
# NumberOfMarkers[1]="100"
# NumberOfMarkers[2]="500"
# NumberOfMarkers[3]="1000"

RecRate[1]="0"
RecRate[2]="191.352"
RecRate[3]="495.326"
RecRate[4]="783.562"
RecRate[5]="1079.2"
RecRate[6]="1370.047"
RecRate[7]="1888.974"
RecRate[8]="2244.487"
RecRate[9]="2512.65"
RecRate[10]="2881.44"
RecRate[11]="3391.733"
RecRate[12]="3977.678"
RecRate[13]="4614.348"
RecRate[14]="5215.098"
RecRate[15]="5869.541"
RecRate[16]="6966.051"
RecRate[17]="7767.025"
RecRate[18]="8498.236"
RecRate[19]="10215.751"
RecRate[20]="12984.294"
RecRate[21]="23003.3"


# RecNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) / 1 + 1 ))
Repetition=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 100 + 1 ))

for RecNumber in {11..11}
do

ResampledTrajFile="../../../../Results/UK10K/ForwardSims/4Ns_0/ResampledTraj"${RecRate[$RecNumber]}"_"$Repetition".txt"
MsselOut="../../../../Results/UK10K/ForwardSims/4Ns_0/MsselOut"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengths="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLength"${RecRate[$RecNumber]}"_"$Repetition".txt"
MsselOutNoRec="../../../../Results/UK10K/ForwardSims/4Ns_0/MsselOutNoRecSingleRec"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsNoRec="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthNoRec"${RecRate[$RecNumber]}"_"$Repetition".txt"
MsselOutNoRecAnc="../../../../Results/UK10K/ForwardSims/4Ns_0/MsselOutNoRecAnc"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsNoRecAnc="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthNoRecAnc"${RecRate[$RecNumber]}"_"$Repetition".txt"

MsselOutMultiSeq="../../../../Results/UK10K/ForwardSims/4Ns_0/MsselOutMultiSeq"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsMultiSeq="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthMultiSeq"${RecRate[$RecNumber]}"_"$Repetition".txt"
T2File="../../../../Results/UK10K/ForwardSims/4Ns_0/T2Values"${RecRate[$RecNumber]}"_"$Repetition".txt"

# perl TrajToMsselFormat.pl ../../../../Results/UK10K/ForwardSims/4Ns_-50/Traj_0.01_ 20000 ../../../../Results/UK10K/ForwardSims/4Ns_-50/TrajMsselLike.txt $TrajNum 0 1000
# cat ../../../../Results/UK10K/ForwardSims/4Ns_-50/TrajMsselLike.txt | ../stepftn > ../../../../Results/UK10K/ForwardSims/4Ns_-50/ReducedTrajectories.txt
DistancesFile="../../../../Results/UK10K/ForwardSims/4Ns_0/SimDistancesMsselSingleRecHighRecLowerMut"${NumberOfMarkers[3]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
rm $DistancesFile
touch $DistancesFile

for i in {69..76}
do
Value[$i]=$( grep 'age' ../../../../Results/UK10K/ForwardSims/4Ns_0/ReducedTrajectories_$i.txt | wc -l )
done

Test=`python MultinomialDist.py ${Value[69]} ${Value[70]} ${Value[71]} ${Value[72]} ${Value[73]} ${Value[74]} ${Value[75]} ${Value[76]}`
Samples[69]=$( echo $Test | cut -d' ' -f1 )
Samples[70]=$( echo $Test | cut -d' ' -f2 )
Samples[71]=$( echo $Test | cut -d' ' -f3 )
Samples[72]=$( echo $Test | cut -d' ' -f4 )
Samples[73]=$( echo $Test | cut -d' ' -f5 )
Samples[74]=$( echo $Test | cut -d' ' -f6 )
Samples[75]=$( echo $Test | cut -d' ' -f7 )
Samples[76]=$( echo $Test | cut -d' ' -f8 )


for i in {69..76}
do
HapLengths="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthN"${NumberOfMarkers[3]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsNoRec="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthNoRecN"${NumberOfMarkers[3]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsMultiSeq="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthMultiSeqN"${NumberOfMarkers[3]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsNoRecAnc="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthNoRecAncN"${NumberOfMarkers[3]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
HapLengthsRecAware="../../../../Results/UK10K/ForwardSims/4Ns_0/HapLengthRecAwareN"${NumberOfMarkers[3]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
DistancesFileOne="../../../../Results/UK10K/ForwardSims/4Ns_0/SimDistancesPartOneMsselSingleRec"${NumberOfMarkers[3]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
DistancesFileTwo="../../../../Results/UK10K/ForwardSims/4Ns_0/SimDistancesPartTwoMsselSingleRec"${NumberOfMarkers[3]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"
DistancesFileTemp="../../../../Results/UK10K/ForwardSims/4Ns_0/SimDistancesMsselSingleRecHighRecTemp"${NumberOfMarkers[3]}"_"${RecRate[$RecNumber]}"_"$Repetition".txt"

perl ../../ConstantPopSize/ForwardSims/SampleTrajectories.pl ../../../../Results/UK10K/ForwardSims/4Ns_0/ReducedTrajectories_$i.txt ${Samples[$i]} $ResampledTrajFile $Repetition

Rate=$( echo "scale = 5; ${RecRate[$RecNumber]} * 2" | bc )

echo $Rate

Num=$(( $i + 1 ))
../../../../Programs/Mssel/mssel3 $Num ${Samples[$i]} 1 $i $ResampledTrajFile 250000 -r $Rate 499999 -t 11101.185 -eN 0.0 1.0 -eN 0.0001490 0.0077465 -eN 0.0008817 0.0071263 -eN 0.0019518 0.0553806 -eN 0.0056639 0.0279335 > $MsselOutNoRec

time perl ../../ConcatenateManyStatisticsScripts/DistanceToFirstSegregatingSiteMultiSequence_DeleteSingletonsBothSides.pl $MsselOutNoRec $DistancesFileTemp 1 $i 0 0 25 250000 

cat $DistancesFileTemp >> $DistancesFile
rm $DistancesFileTemp
rm $ResampledTrajFile
rm $DistancesFileTwo
rm $DistancesFileOne
rm $MsselOutNoRec

done
done

