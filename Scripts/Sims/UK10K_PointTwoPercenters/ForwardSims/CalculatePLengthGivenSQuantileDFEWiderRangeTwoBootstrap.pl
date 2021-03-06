$HapLengthFile = $ARGV[0];
$UnitsOfHapLengthFile = $ARGV[1];
$IS_Prefix = $ARGV[2];
$FileISBoundaries = $ARGV[3];
$ExitFile = $ARGV[4];
$LeftRecFile = $ARGV[5];
$RightRecFile = $ARGV[6];
$NumberOfVariants = $ARGV[7];
$VariantsToIncludeFile = $ARGV[8];
$QuantilesFile = $ARGV[9];
$LastPopSize = $ARGV[10];
$CurrentRandomSeed = $ARGV[11];

srand($CurrentRandomSeed);
@HapLengths = ();
@ISValues = ();
@VariantsToUse = ();

@Bounds = ();
open (BOUNDS,$FileISBoundaries) or die "NO!";

while(<BOUNDS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@Bounds,$SplitLine[0]);
# print "Test = $SplitLine[0]\n";
}

close(BOUNDS);

@LLValues = ();

$NumberOfIntervalsToCheck = 0;

for ($i = 0; $i < scalar(@Bounds);$i++){
if ( int ($UnitsOfHapLengthFile) < int ($Bounds[$i]) ){
last;
}
$NumberOfIntervalsToCheck = $i;
# print "Here = $UnitsOfHapLengthFile \< $Bounds[$i] \t$NumberOfIntervalsToCheck\t$Bounds[$NumberOfIntervalsToCheck]\t$Bounds[$i]\n";
}

# print "End = $NumberOfIntervalsToCheck\t$Bounds[$NumberOfIntervalsToCheck]\t$LineNumber\n";

@LogLikelihoods = ();

for ($i = 0; $i <= 1560; $i++){
$LogLikelihoods[$i] = 0;
# print "Interval = $i LL = $LogLikelihoods[$i]\n";
}
# die "NO\n";

for ( $j = 1 ; $j <= 21 ; $j++ ){

$IS_File = $IS_Prefix.$j."/FirstDFETableToTest.txt";
open (IS,$IS_File) or die "NO! $IS_File\n";

$LineNumber = 0;

while(<IS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ($i = 0; $i < scalar(@SplitLine); $i++){
$ISValues[$j-1][$LineNumber][$i] = $SplitLine[$i];
}
$LineNumber++;
}

close(IS);
}

@LeftRecRate = ();
@RightRecRate = ();

open (LEFT, $LeftRecFile ) or die "NO";

while ( <LEFT> ){
chomp;
$Line = $_;
push (@LeftRecRate,$Line);
}
close (LEFT);

open (RIGHT, $RightRecFile ) or die "NO";

while ( <RIGHT> ){
chomp;
$Line = $_;
push (@RightRecRate,$Line);
}
close (RIGHT);

open (VARFILE,$VariantsToIncludeFile ) or die "NO! $VariantsToIncludeFile";

while (<VARFILE>){
chomp;
$Line = $_;
push (@VariantsToUse , $Line );
}

close(VARFILE);

open (QUANTILE,$QuantilesFile) or die "NO $QuantilesFile\n";

@QuantileRec = ();
while (<QUANTILE>){
chomp;
$Line = $_;
push (@QuantileRec, $Line );
}

close (QUANTILE);

$VariantNumberSum = 0;
$RecNum = 0;
for ($VarNum = 0; $VarNum < scalar(@VariantsToUse); $VarNum++ ){
$VariantFlagFount = 0;
$RanVar = int(rand($NumberOfVariants));
$VarTotal = scalar(@VariantsToUse);
print "Sampled $VarNum variants out of $VarTotal\n";
while ($VariantFlagFount == 0){
if (grep {$_ eq $RanVar} @VariantsToUse) {
# print "Element '$RanVar' found!\n" ;
$VariantFlagFount = 1;
$VariantNumberSum++;
}else{
#  print "Element '$RanVar' not found!\n" ;
$RanVar = int(rand($NumberOfVariants));
}
}
print "Here\t";
if ($VariantFlagFount == 1){
for ($VarCheck = 0; $VarCheck < scalar(@VariantsToUse); $VarCheck++){
if ($VariantsToUse[$VarCheck] == $RanVar){
last;
}
}
$HapFileToOpen = $HapLengthFile.$RanVar.".txt";
$CurrentLeftRec = $LeftRecRate[$VarCheck];
$CurrentRightRec = $RightRecRate[$VarCheck];
$RecRateLeft = $CurrentLeftRec * .01 * 4*$LastPopSize*250000;
$RecRateRight= $CurrentRightRec * .01 * 4*$LastPopSize*250000;
# $RecNum++;
### Get Recombination rate
print "$VarNum\t$RanVar\t$VarCheck\t$VariantsToUse[$VarCheck]\t$RecRateLeft\t$RecRateRight\t";
### Get Recombination rate
print "$VarNum\t$RecRateLeft\t$RecRateRight\t";
$SmallRecDiffFlagLeft = 0;
$SmallRecDiffFlagRight = 0;
for ( $QuantTest = 0 ; $QuantTest < 20 ; $QuantTest++ ){
$MidPoint = ( $QuantileRec[$QuantTest+1] - $QuantileRec[$QuantTest]) / 2 + $QuantileRec[$QuantTest] ;
if ( ( $RecRateLeft <= ($MidPoint)) && ($RecRateLeft >= $QuantileRec[$QuantTest]  )){
$QuantileLeft = $QuantTest;
if ($QuantTest != 0){
$DifCheck = abs($RecRateLeft - $QuantileRec[$QuantTest])/$QuantileRec[$QuantTest];
if ($DifCheck < 0.01){
$SmallRecDifFlagLeft = 1;
$AppropriateVariantRecNumber++;
}else {
$SmallRecDifFlagLeft = 0;
}
}

}
if ( ( $RecRateRight <= ($MidPoint)) && ($RecRateRight >= $QuantileRec[$QuantTest]  )){
$QuantileRight = $QuantTest;
if ($QuantTest != 0){
$DifCheck = abs($RecRateRight - $QuantileRec[$QuantTest])/$QuantileRec[$QuantTest];
if ($DifCheck < 0.01){
$SmallRecDifFlagRight = 1;
$AppropriateVariantRecNumber++;
}else {
$SmallRecDifFlagRight = 0;
}
}
}

if ( ( $RecRateLeft > ($MidPoint)) && ($RecRateLeft <= $QuantileRec[$QuantTest+1]  )){
$QuantileLeft = $QuantTest + 1;
$DifCheck = abs($RecRateLeft - $QuantileRec[$QuantTest+1])/$QuantileRec[$QuantTest+1];
if (($DifCheck < 0.01)){
$SmallRecDifFlagLeft = 1;
$AppropriateVariantRecNumber++;
}else {
$SmallRecDifFlagLeft = 0;
}

}


if ( ( $RecRateRight > ($MidPoint)) && ($RecRateRight <= $QuantileRec[$QuantTest+1]  )){
$QuantileRight = $QuantTest + 1;
$DifCheck = abs($RecRateRight - $QuantileRec[$QuantTest+1])/$QuantileRec[$QuantTest+1];
if (($DifCheck < 0.01)){
$SmallRecDifFlagRight = 1;
$AppropriateVariantRecNumber++;
}else {
$SmallRecDifFlagRight = 0;
}

}
#print "$QuantileLeft\t$QuantileRight\n";

}
if ($RecRateRight > $QuantileRec[20]){
$QuantileRight = 20;
}
if ($RecRateLeft > $QuantileRec[20]){
$QuantileLeft = 20;
}



###################################################################################################
print "$QuantileRec[$QuantileLeft]\t$QuantileLeft\t$QuantileRec[$QuantileRight]\t$QuantileRight\n";
$HapLengthFileToOpen = $HapLengthFile.$RanVar.".txt";

@HapLengths = ();
@AllRecValues = ();
@AllLengthWindows = ();

$ContinueFlagLeft = 0;
$ContinueFlagRight = 0;
if ( ( $RecRateLeft < $QuantileRec[20] ) && (  $RecRateLeft > $QuantileRec[0] ) && ($SmallRecDifFlagLeft == 1)){
$ContinueFlagLeft =  1;
}elsif ( $RecRateLeft == $QuantileRec[0]){
$ContinueFlagLeft =  1;
}elsif ( $RecRateLeft == $QuantileRec[20]){
$ContinueFlagLeft =  1;
}

if ( ( $RecRateRight < $QuantileRec[20] ) && (  $RecRateRight > $QuantileRec[0] ) && ($SmallRecDifFlagRight == 1)){
$ContinueFlagRight =  1;
}elsif ( $RecRateRight == $QuantileRec[0]){
$ContinueFlagRight =  1;
}elsif ( $RecRateRight == $QuantileRec[20]){
$ContinueFlagRight =  1;
}

# print "$ContinueFlagRight\t$ContinueFlagLeft\n";
# if ( ($ContinueFlagLeft == 0) && ($ContinueFlagRight == 0)) {
# next;
# }



open (HAP,$HapLengthFileToOpen ) or die "NO! $HapLengthFileToOpen\n";
$OddOrEven = 0;
while (<HAP>){
chomp;
$Line = $_;
# push(@HapLengths,int($Line));
# print "$Line\t";
for ($j = 0; $j < $NumberOfIntervalsToCheck; $j++){
if ( ($Line >= $Bounds[$j]) && ($Line <= $Bounds[$j+1])){
$IntervalFlag = 1;
# print "$Bounds[$j]\t$Bounds[$j+1]\t";
last;
}
}
# print "$j\n";
# die "NO!\n";
for ($i = 1; $i <= 1500; $i++){
$ToCheckNum = $OddOrEven % 2;
if ($ToCheckNum == 0){
# if ( ( $RecRateLeft < $QuantileRec[20] ) && (  $RecRateLeft > $QuantileRec[0] ) && ($SmallRecDifFlagLeft == 1)){
if ( ( $RecRateLeft < $QuantileRec[20] ) && (  $RecRateLeft > $QuantileRec[0] )){
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ($ISValues[$QuantileLeft][$i+1][$j+1]);
# print "$ISValues[$QuantileLeft][$i+1][$j+1]\t$Line\t$j\t$QuantileLeft\tNO\n";
}elsif ( $RecRateLeft == $QuantileRec[0]){
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ($ISValues[0][$i+1][$j+1]);
$TotalVariantNumberUsed++;
}elsif ( $RecRateLeft == $QuantileRec[20]){
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ($ISValues[20][$i+1][$j+1]);
$TotalVariantNumberUsed++;
}else{
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ($ISValues[$QuantileLeft][$i+1][$j+1]);
$TotalVariantNumberUsed++;
}

}else{
# if ( ( $RecRateRight < $QuantileRec[20] ) && (  $RecRateRight > $QuantileRec[0] ) && ($SmallRecDifFlagRight == 1)){
if ( ( $RecRateRight < $QuantileRec[20] ) && (  $RecRateRight > $QuantileRec[0] )){
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ($ISValues[$QuantileRight][$i+1][$j+1]);
# die "$ISValues[$QuantileRight][$i+1][$j+1]\t$Line\t$j\t$QuantileRight\tNO\n";
}elsif ( $RecRateRight == $QuantileRec[0]){
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ($ISValues[0][$i+1][$j+1]);
$TotalVariantNumberUsed++;
}elsif ( $RecRateRight == $QuantileRec[20]){
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ($ISValues[20][$i+1][$j+1]);
$TotalVariantNumberUsed++;
}else{
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ($ISValues[$QuantileRight][$i+1][$j+1]);
$TotalVariantNumberUsed++;
}
}
# print "Hap = $i  $ISValues[$QuantileLeft][$i+2][$j]\n";
}
$OddOrEven++;
}
close (HAP);

for ($i = 0; $i <= 1500; $i++){
# print "LL $i = $LogLikelihoods[$i]\n";
}

# die "NO!\n";
}
}
open (EXIT,">$ExitFile") or die "NO!";

for ($i = 0; $i <= 1500; $i++){
print EXIT "$i\t$LogLikelihoods[$i]\n";
}

close (EXIT);
die "Here? $VariantNumberSum $HapFileToOpen\n";

open (EXIT,">$ExitFile") or die "NO!";

open (HAP,$HapLengthFile) or die "NO!";

while(<HAP>){
chomp;
$Line = $_;
$Variable = int($Line*$UnitsOfHapLengthFile + 0.5);
push(@HapLengths,int($Line*$UnitsOfHapLengthFile + 0.5));
# die "No! $Line $Variable\n";
}

close(HAP);


@Bounds = ();
open (BOUNDS,$FileISBoundaries) or die "NO!";

while(<BOUNDS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@Bounds,$SplitLine[0]);
}

close(BOUNDS);

@LLValues = ();

$NumberOfIntervalsToCheck = 0;

for ($i = 0; $i < scalar(@Bounds);$i++){
if ($UnitsOfHapLengthFile < $Bounds[$i]){
last;
}
$NumberOfIntervalsToCheck = $i;
print "$NumberOfIntervalsToCheck\t$Bounds[$NumberOfIntervalsToCheck]\n";
}

print "$NumberOfIntervalsToCheck\t$Bounds[$NumberOfIntervalsToCheck]\t$LineNumber\n";

@LogLikelihoods = ();

for ($i = 0; $i < $NumberOfIntervalsToCheck; $i++){
$LogLikelihoods[$i] = 0;
print "Interval = $i LL = $LogLikelihoods[$i]\n";
}

for $i (@HapLengths){
$IntervalFlag = 0;
# print "HapLength = $i\n";
for ($j = 0; $j < $NumberOfIntervalsToCheck; $j++){
if ( ($i >= $Bounds[$j]) && ($i <= $Bounds[$j+1])){
$IntervalFlag = 1;
last;
}
}
# print "$i\t$Bounds[$j]\t$Bounds[$j+1]\n";

#### The remainder of the probability

@ProbRem = ();

for ($k = 1; $k < $LineNumber; $k++){
$ProbRem[$k-1] = 0;
for ($l = 0; $l < $NumberOfIntervalsToCheck; $l++){
$ProbRem[$k-1] = $ProbRem[$k-1] + $ISValues[$k][$l+1];
}
$ProbRem[$k-1] = 1 - $ProbRem[$k-1];
# print "$k\t$ProbRem[$k-1]\n";
}

for ($k = 1; $k < $LineNumber; $k++){
if ($IntervalFlag == 0){
$LogLikelihoods[$k-1] = $LogLikelihoods[$k-1] + log($ProbRem[$k-1]);
}else{
$LogLikelihoods[$k-1] = $LogLikelihoods[$k-1] + log($ISValues[$k][$j+1]);
}
# print "$ISValues[$k][$j+1]\t";
}
# print "\n";
# die "NO";
}

for ($k = 2; $k < $LineNumber; $k++){
print EXIT "$LogLikelihoods[$k-1]\t";
}
print EXIT "\n";


