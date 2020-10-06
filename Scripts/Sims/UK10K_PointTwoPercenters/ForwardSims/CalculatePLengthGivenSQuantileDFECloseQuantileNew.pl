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
$DFETableRec = $ARGV[11];
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

@FullPLGivenSTable = ();
$LineNumber = 0;
open (REG,$DFETableRec) or die "NO!";
while (<REG>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line );
for ($i = 0; $i < scalar(@SplitLine); $i++){
$FullPLGivenSTable[$i][$LineNumber] = $SplitLine[$i];
}
$LineNumber++;
}

close (REG);


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

for ($i = 0; $i <= 1500; $i++){
$LogLikelihoods[$i] = 0;
# print "Interval = $i LL = $LogLikelihoods[$i]\n";
}
# die "NO\n";

for ( $j = 1 ; $j <= 21 ; $j++ ){

$IS_File = $IS_Prefix.$j."/TableToTest.txt";
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

for ($i = 1; $i <= 1500; $i++){
$LogLikelihoods[$i] = 0;
}

$VariantNumberSum = 0;
$RecNum = 0;
$AppropriateVariantRecNumber = 0;
for ($VarNum = 0; $VarNum < $NumberOfVariants; $VarNum++ ){
$VariantFlagFount = 0;

$SubResultsFile = $ExitFile.$VarNum.".txt";
open (SUBR,">$SubResultsFile") or die "NO!\n";

@CurrentLogLikelihoods = ();
for ($i = 1; $i <= 1500; $i++){
$CurrentLogLikelihoods[$i] = 0;
}


if (grep {$_ eq $VarNum} @VariantsToUse) {
#  print "Element '$element' found!\n" ;
$VariantFlagFount = 1;
$VariantNumberSum++;
}
if ($VariantFlagFount == 1){
$HapFileToOpen = $HapLengthFile.$VarNum.".txt";
$CurrentLeftRec = $LeftRecRate[$RecNum];
$CurrentRightRec = $RightRecRate[$RecNum];
$RecRateLeft = $CurrentLeftRec * .01 * 4*$LastPopSize*250000;
$RecRateRight= $CurrentRightRec * .01 * 4*$LastPopSize*250000;
$RecNum++;
### Get Recombination rate
print "$VarNum\t$RecRateLeft\t$RecRateRight\n";

$HapLengthFileToOpen = $HapLengthFile.$VarNum.".txt";


open (HAP,$HapLengthFileToOpen ) or die "NO! File\n";
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
$CurrentLogLikelihoods[$i] = $CurrentLogLikelihoods[$i] + log ($FullPLGivenSTable[$VarNum][ ( $i + 1 ) * 6 + $j ]);
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ($FullPLGivenSTable[$VarNum][ ( $i + 1 ) * 6 + $j ]);
# print "$i\t$j\t$FullPLGivenSTable[$VarNum][ ( $i + 1 ) * 6 + $j ]\n";
# print "$ISValues[$QuantileLeft][$i+1][$j+1]\t$Line\t$j\t$QuantileLeft\tNO\n";
}else{
# print "$i\t$j\t$FullPLGivenSTable[$VarNum + $NumberOfVariants][ ( $i + 1 ) * 6 + $j ]\n";
# if ( ( $RecRateRight < $QuantileRec[20] ) && (  $RecRateRight > $QuantileRec[0] ) && ($SmallRecDifFlagRight == 1)){
$CurrentLogLikelihoods[$i] = $CurrentLogLikelihoods[$i] + log ($FullPLGivenSTable[$VarNum + $NumberOfVariants][ ( $i + 1 ) * 6 + $j ]);
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ($FullPLGivenSTable[$VarNum + $NumberOfVariants][ ( $i + 1 ) * 6 + $j ]);
# die "$ISValues[$QuantileRight][$i+1][$j+1]\t$Line\t$j\t$QuantileRight\tNO\n";
# die "NO\n";
}
# print "Hap = $i  $ISValues[$QuantileLeft][$i+2][$j]\n";
}
$OddOrEven++;
}
print "LL=$LogLikelihoods[1]\n";
close (HAP);

for ($i = 0; $i <= 1500; $i++){

print SUBR "$i\t$CurrentLogLikelihoods[$i]\n";
}
close (SUBR);
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


