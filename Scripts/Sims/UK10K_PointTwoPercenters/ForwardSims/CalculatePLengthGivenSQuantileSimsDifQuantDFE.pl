$HapLengthFile = $ARGV[0];
$UnitsOfHapLengthFile = $ARGV[1];
$IS_Prefix = $ARGV[2];
$FileISBoundaries = $ARGV[3];
$ExitFile = $ARGV[4];
$RightRecFile = $ARGV[5];
$LeftRecFile = $ARGV[6];
$NumberOfVariants = $ARGV[7];
$QuantilesFile = $ARGV[8];
$LastPopSize = $ARGV[9];
$PLGivenSFile = $ARGV[10];
@HapLengths = ();
@ISValues = ();
@VariantsToUse = ();

print "HapFile = $HapLengthFile
Units = $UnitsOfHapLengthFile
ISPrefix = $IS_Prefix
FileISBoundaries = $FileISBoundaries
ExitFile = $ExitFile
LeftRecFile = $LeftRecFile
RightRecFile = $RightRecFile
NumberOfVariants = $NumberOfVariants
QuantilesFile = $QuantilesFile
LastPopSize = $LastPopSize\n";

open ( QUANT,"QuantileToPrint.txt") or die "NO!";
@Quantiles = ();
$QuantileNumber = 0;
while (<QUANT>){
chomp;
$Line = $_;
push(@Quantiles, $Line );
}
close (QUANT);

@FullPLGivenSTable = ();
$LineNumber = 0;
open (REG,$PLGivenSFile) or die "NO!";
while (<REG>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line );
for ($i = 0; $i < 550; $i++){
$FullPLGivenSTable[$i][$LineNumber] = $SplitLine[$i];
}
$LineNumber++;
}

close (REG);

$DownNotUp = 0;
@Bounds = ();
open (BOUNDS,$FileISBoundaries) or die "NO!";

while(<BOUNDS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@Bounds,$SplitLine[0]);
print "Test = $SplitLine[0]\n";
}

close(BOUNDS);

@LLValues = ();

$NumberOfIntervalsToCheck = 0;

for ($i = 0; $i < scalar(@Bounds);$i++){
if ( int ($UnitsOfHapLengthFile) < int ($Bounds[$i]) ){
last;
}
$NumberOfIntervalsToCheck = $i;
print "Here = $UnitsOfHapLengthFile \< $Bounds[$i] \t$NumberOfIntervalsToCheck\t$Bounds[$NumberOfIntervalsToCheck]\t$Bounds[$i]\n";
}

print "End = $NumberOfIntervalsToCheck\t$Bounds[$NumberOfIntervalsToCheck]\t$LineNumber\n";

@LogLikelihoods = ();

for ($i = 0; $i <= 1500; $i++){
$LogLikelihoods[$i] = 0;
print "Interval = $i LL = $LogLikelihoods[$i]\n";
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
@RecRate = ();

open (RIGHT, $RightRecFile ) or die "NO RightRecRate";

while ( <RIGHT> ){
chomp;
$Line = $_;
push (@RecRate,$Line);
}
close (RIGHT);

open (LEFT, $LeftRecFile ) or die "NO LeftRecFile";

while ( <LEFT> ){
chomp;
$Line = $_;
push (@RecRate,$Line);
}
close (LEFT);


open (QUANTILE,$QuantilesFile) or die "NO Q$QuantilesFile\n";

@QuantileRec = ();
while (<QUANTILE>){
chomp;
$Line = $_;
push (@QuantileRec, $Line );
}

close (QUANTILE);

$VariantNumberSum = 0;
$RecNum = 0;


$HapFileToOpen = $HapLengthFile;
$CurrentLeftRec = $LeftRecRate[$RecNum];
$CurrentRightRec = $RightRecRate[$RecNum];
$RecRateLeft = $CurrentLeftRec * .01 * 4*$LastPopSize*250000;
$RecRateRight= $CurrentRightRec * .01 * 4*$LastPopSize*250000;
$RecNum++;
### Get Recombination rate
$HapLengthFileToOpen = $HapLengthFile.$VarNum.".txt";

@HapLengths = ();
open (HAP,$HapLengthFile ) or die "NO! File $HapLengthFile\n";
$OddOrEven = 0;
$LineNumber = 0;
$RecCount = 0;
$RecNum = 0;
while (<HAP>){
chomp;
$Line = $_;
$Original = $Line;
# push(@HapLengths,int($Line));
$Line = $Line * 250000;
# print "Line = $Line\t";
for ($j = 0; $j < $NumberOfIntervalsToCheck; $j++){
if ( ($Line >= $Bounds[$j]) && ($Line <= $Bounds[$j+1])){
$IntervalFlag = 1;
# print "$Bounds[$j]\t$Bounds[$j+1]\n";
last;
}
}
# print "$j\n";
# die "NO\n";

if ($Original eq "#"){
$RecCount++;
if ($RecCount % 2 == 0){
$RecNum= int ( $RecCount / 2 );
print "$RecNum\n";
}else{
$RecNum= int ( $RecCount / 2 ) + $NumberOfVariants;
print "$RecNum\n";
}
print "Rec num = $RecNum\t";
$CurrentRec = $RecRate[$RecNum];

$RecRate = $CurrentRec * .01 * 4*$LastPopSize*250000;
print "rec rate = $RecRate\t";
$PositionFlag = 0;
}else{
# print "$j\n";
# die "NO!\n";
for ($i = 1; $i <= 1500; $i++){
$ToCheckNum = $OddOrEven % 2;
$Value = $FullPLGivenSTable[$RecNum][ ( $i + 1 ) * 6 + $j];


# print "$RegressionCoefficients[$j * 5 + 0][$i+1]\t$RegressionCoefficients[$j * 5 + 1][$i+1]\t$RegressionCoefficients[$j * 5 + 2][$i+1]\t$RegressionCoefficients[$j * 5 + 3][$i+1]\t$RegressionCoefficients[$j * 5 + 4][$i+1]\t$RecRate\t$j\t$i\t$Value\n";
# die "NO!";
$LogLikelihoods[$i] = $LogLikelihoods[$i] + log ( $Value  );
# print "$j\t$LogLikelihoods[$i]\n";
# die "NO\n";
# print "$ISValues[$QuantileLeft][$i+1][$j+1]\t$Line\t$j\t$QuantileLeft\tNO\n";

# print "Hap = $i  $ISValues[$QuantileLeft][$i+2][$j]\n";
}}
# die "NO\n";

$LineNumber++;
$OddOrEven++;
}
close (HAP);

for ($i = 0; $i <= 1500; $i++){
# print "LL $i = $LogLikelihoods[$i]\n";
}

# die "NO!\n";


open (EXIT,">$ExitFile") or die "NO! Exit";

for ($i = 0; $i <= 1500; $i++){
print EXIT "$i\t$LogLikelihoods[$i]\n";
}

close (EXIT);
die "Here? $VariantNumberSum $HapFileToOpen\n";

open (EXIT,">$ExitFile") or die "NO! Exit";

open (HAP,$HapLengthFile) or die "NO! ";

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


