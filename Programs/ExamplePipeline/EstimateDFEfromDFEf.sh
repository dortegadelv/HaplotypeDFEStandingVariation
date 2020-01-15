MaxLLFile=$1
P_OnePercentAllele=$2
FileScoefficientsAtOnePercent=$3
ChromAncestralEpoch=$4
AllelesSimulatedInDemHistory=$5
IntervalLength=$6
IntervalNumber=$7

cd DFEfToDFE
pwd
echo $MaxLLFile

Rscript DFEfToDFE.R $MaxLLFile $P_OnePercentAllele $FileScoefficientsAtOnePercent $ChromAncestralEpoch $AllelesSimulatedInDemHistory $IntervalLength $IntervalNumber
