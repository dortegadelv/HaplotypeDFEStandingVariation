#!/bin/bash
#SBATCH --job-name=example_sbatch
#SBATCH --output=example_sbatch.%A_%a.out
#SBATCH --error=example_sbatch.%A_%a.err
#SBATCH --time=12:00:00
#SBATCH --partition=jnovembre
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=16000


Directory[1]="AncientBottleneck"
Directory[2]="AncientBottleneckPointFivePercent"
Directory[3]="ConstantPopSize"
Directory[4]="ConstantPopSizePointFivePercent"
Directory[5]="MediumBottleneck"
Directory[6]="MediumBottleneckPointFivePercent"
Directory[7]="PopExpansion"
Directory[8]="PopExpansionPointFivePercent"
Directory[9]="RecentBottleneck"
Directory[10]="RecentBottleneckPointFivePercent"
Directory[11]="ConstantPopSizePopFrequency"
Directory[12]="UK10K"

FourNs[1]="4Ns_0"
FourNs[2]="4Ns_50"
FourNs[3]="4Ns_25"
FourNs[4]="4Ns_-50"
FourNs[5]="4Ns_-25"

DemScenario[1]="DemHistBottleneck.txt"
DemScenario[2]="DemHistBottleneck.txt"
DemScenario[3]="DemographicHistoryConstant.txt"
DemScenario[4]="DemographicHistoryConstant.txt"
DemScenario[5]="DemHistBottleneck.txt"
DemScenario[6]="DemHistBottleneck.txt"
DemScenario[7]="DemHistExpansion.txt"
DemScenario[8]="DemHistExpansion.txt"
DemScenario[9]="DemUK10KHistBottleneck.txt"
DemScenario[10]="DemHistBottleneck.txt"
DemScenario[11]="DemographicHistoryConstant.txt"
DemScenario[12]="DemHistExpansion.txt"

Ne[1]="10000"
Ne[2]="10000"
Ne[3]="20000"
Ne[4]="20000"
Ne[5]="10000"
Ne[6]="10000"
Ne[7]="100000"
Ne[8]="100000"
Ne[9]="10000"
Ne[10]="10000"
Ne[11]="20000"
Ne[12]="346884"

DemHistNumber=$(( ( ( $SLURM_ARRAY_TASK_ID - 1) / 500 ) + 1 ))
FourNsNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 -  ( ( $DemHistNumber - 1 ) * 500 ) ) / 100 + 1 ))
SeriesNumber=$(( ( $SLURM_ARRAY_TASK_ID - 1 ) % 100 ))
GenMapNumber=$(( $SeriesNumber + 1 ))

i=$DemHistNumber

j=$FourNsNumber

echo "DemHist = $DemHistNumber FourNs = $FourNsNumber Series = $SeriesNumber"

Start=$(( ( $SeriesNumber - 1 ) * 1 + 1 ))
End=$(( $SeriesNumber * 1 ))
echo ${Directory[$i]}
CurrentTrajs="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/ReducedTrajectories10000.txt"
# TTwosFile="../../../Results/TTwos/TTwos"${Directory[$i]}"_"${FourNs[$j]}".txt"
# ExitDir="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/Trajectories"
# DemHist="../../../Scripts/Sims/"${Directory[$i]}"/ImportanceSamplingSims/"${DemScenario[$i]}
# grep 'age' $CurrentFile | awk '{print $6}' > $AlleleAgesFile
# mkdir $ExitDir

DirToCreate="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/HapLengths/"
mkdir $DirToCreate

PhasedDataPrefix=$DirToCreate"PhasedVCF1.txt."$SeriesNumber".txt"
PhasedDataOutput=$DirToCreate"PhasedShapeitVCF1.txt."$SeriesNumber".phased"
PhasedDataOutputHaps=$DirToCreate"PhasedShapeitVCF1.txt."$SeriesNumber".phased.haps"


MsselOut="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/MsselFiles/MsselOutLess_"$Repetition".txt"
MsselPhasedOutFile="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/MsselFiles/MsselOutLessPhased_"$SeriesNumber".txt"
HapLengths=$DirToCreate"HapLengthsLessStatPhase"$SeriesNumber".txt"
LogOutput="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/MsselFiles/Log"$SLURM_ARRAY_TASK_ID".txt"
#### Followed by
# DerHaps=$( cat ../../../Results/${Directory[$i]}/ForwardSims/${FourNs[$j]}/Params.txt | awk '{print $2}' )

echo "time ../../../Programs/shapeit.v2.904.3.10.0-693.11.6.el7.x86_64/bin/shapeit --input-vcf $PhasedDataPrefix -M GeneticMapConstantPopSize.txt -O $PhasedDataOutput --output-log $LogOutput
perl CreatePhasedToVCF.pl $MsselOut $PhasedDataOutputHaps $MsselPhasedOutFile $SeriesNumber
perl DistanceToFirstSegregatingSiteMultiSequence_NoSingletonsBothSides.pl $MsselPhasedOutFile $HapLengths 1 40"

##time ../../../Programs/shapeit.v2.904.3.10.0-693.11.6.el7.x86_64/bin/shapeit --input-vcf $PhasedDataPrefix -M GeneticMapUK10K.txt -O $PhasedDataOutput --output-log $LogOutput
for Repetition in {1..100}
do
MsselOut="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/MsselFiles/MsselOutLess_"$Repetition".txt"
MinusNumber=$(( $Repetition - 1 ))
ParamsFile="../../../Results/${Directory[$i]}/ForwardSims/${FourNs[$j]}/Params$Repetition.txt"
DerHaps=$( cat $ParamsFile | awk '{print $2}' )
PhasedDataOutputHaps=$DirToCreate"PhasedShapeitVCF1.txt."$Repetition".phased.haps"
MsselPhasedOutFile="../../../Results/"${Directory[$i]}"/ForwardSims/"${FourNs[$j]}"/MsselFiles/MsselOutLessPhased_"$Repetition".txt"
HapLengths=$DirToCreate"HapLengthsLessStatPhase"$Repetition".txt"
perl CreatePhasedToVCF.pl $MsselOut $PhasedDataOutputHaps $MsselPhasedOutFile 0
perl DistanceToFirstSegregatingSiteMultiSequence_DeleteSingletonsBothSides.pl $MsselPhasedOutFile $HapLengths 1 $DerHaps
done
# perl DistanceToFirstSegregatingSiteMultiSequence_DeleteSingletonsBothSides.pl $MsselPhasedOutFile $HapLengths 7170 72
# perl DistanceToFirstSegregatingSiteMultiSequence_DeleteSingletonsBothSides.pl $MsselOut $HapLengths 3960 40

# time ../../../Programs/shapeit.v2.904.3.10.0-693.11.6.el7.x86_64/bin/shapeit --input-vcf ../../../Results/ConstantPopSize/ForwardSims/4Ns_0/HapLengths/PhasedVCF1.txt.0.txt -M GeneticMapConstantPopSize.txt -O TestShapeIt.phased
# perl DistanceToFirstSegregatingSiteMultiSequence_NoSingletonsBothSides.pl $MsselOut $HapLengths 1 40
# rm $MsselOut



