$ExitMeanTrajFilePrefix = $ARGV[0];
$ExitWeightsFilePrefix = $ARGV[1];
$Ne = $ARGV[2];
$StartNumberSeries = $ARGV[3]; 
$EndNumberSeries = $ARGV[4];
$NumberOfSelCoefs = $ARGV[5];
$ExitMeanTrajFile = $ARGV[6];

@MeanTrajValues = ();
$MaxTime = 10000;
@TotalSumWeights = ();

for ($i = 0; $i < $NumberOfSelCoefs ; $i++){
$TotalSumWeights[$i] = 0;
for ($j = 0; $j < $MaxTime ; $j++){
$MeanTrajValues[$i][$j] = 0;
}
}

for ($i = $StartNumberSeries ; $i <= $EndNumberSeries ; $i++){

print "File number = $i\n";
$WeightsFile = $ExitWeightsFilePrefix.$i.".txtWeightYears.txt";

@CurrentTotalWeights = ();

open (WEIGHT,$WeightsFile) or die "NO!";

$LineNumber = 0;
while(<WEIGHT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ($j = 2; $j < scalar(@SplitLine); $j++){
$CurrentTotalWeights[$j-2][$LineNumber] = $SplitLine[$j];
# $LineNumber++;
$TotalSumWeights[$j-2] =$TotalSumWeights[$j-2] +  $SplitLine[$j];
}
$LineNumber++;
}

close(WEIGHT);

for ($j = 0; $j < $NumberOfSelCoefs ; $j++){
# print "$TotalSumWeights[$j]\n";
}

# die "Weights file = $WeightsFile NO!\n";
$TrajFile = $ExitMeanTrajFilePrefix . $i . ".txtTrajectory.txt";
open (FILE,$TrajFile) or die "NO! $TrajFile";

#i die "Traj file = $TrajFile\n";
$WeightCount = 0;
while (<FILE>){

chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

if (/TRA\t0\t(.+)/){
$CurrentTrajectory = "$Line\n";
}elsif(/TRA/){
$CurrentTrajectory = $CurrentTrajectory. "$Line\n";
}

if (/TOT\t(\w+)/){
$Age = ($1 - 1);
@SplitCurrentTrajectory = split(/\n/,$CurrentTrajectory);
$PastGeneration = 0;
foreach $CurTrajLine (@SplitCurrentTrajectory){
@LineSplitted = split(/\s+/,$CurTrajLine);
$CurGen = int ($LineSplitted[1]*4*$Ne + 0.5);
if ($WeightCount == 10){
#die "NO! Weight ten\n";
}
# die "CurGen = $CurGen NO!\n";
# print "ThisLine= $PastGeneration\t$LineSplitted[1]\t$LineSplitted[2]\n";
if ($CurGen == 0){
$PastFreq = $LineSplitted[2];
}
else{
# die "death $PastGeneration\t$CurGen\n";
for ($k = $PastGeneration ; $k < $CurGen ; $k++ ) {
for ($l = 0; $l < $NumberOfSelCoefs ; $l++){
$MeanTrajValues[$k][$l] = $MeanTrajValues[$k][$l] + $PastFreq*$CurrentTotalWeights[$l][$WeightCount];
# print "CurLine= $MeanTrajValues[$k][$l]\tF=$PastFreq\tW=$CurrentTotalWeights[$l][$WeightCount]\tl=$l\n";
}
}
# die "NO!\n";
# $PastGeneration = int ($LineSplitted[1]*4*$Ne + 0.5);
# $PastFreq = $LineSplitted[2];
}
$PastGeneration = int ($LineSplitted[1]*4*$Ne + 0.5);
$PastFreq = $LineSplitted[2];

}
$WeightCount++;
# die "NO! $Age\n$CurrentTrajectory";
}
}

# for ($k = 0 ; $k < $MaxTime ; $k++ ) {
# print "$k\t";
# for ($l = 0; $l < $NumberOfSelCoefs ; $l++){
# print "$MeanTrajValues[$k][$l]\t";
# }
# print "\n";
# }

# die "Got Here!\n";
# close(FILE);
}

open (EXIT,">$ExitMeanTrajFile") or die "NO!";

for ($k = 0 ; $k < $MaxTime ; $k++ ) {
print EXIT "$k";
for ($l = 0; $l < $NumberOfSelCoefs ; $l++){
$MeanTrajValues[$k][$l] = $MeanTrajValues[$k][$l] / $TotalSumWeights[$l] ;
print EXIT "\t$MeanTrajValues[$k][$l]";
}
print EXIT "\n";
}

close (EXIT);

