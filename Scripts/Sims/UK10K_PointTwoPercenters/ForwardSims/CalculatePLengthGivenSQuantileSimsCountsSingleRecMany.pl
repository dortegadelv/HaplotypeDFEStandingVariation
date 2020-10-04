$HapLengthFile = $ARGV[0];
$UnitsOfHapLengthFile = $ARGV[1];
$IS_Prefix = $ARGV[2];
$FileISBoundaries = $ARGV[3];
$ExitFile = $ARGV[4];
$NumberOfVariants = $ARGV[5];
$LastPopSize = $ARGV[6];
$RecValueTested = $ARGV[7];
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
print "Test = $SplitLine[0]\n";
}

close(BOUNDS);

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

for ($i = 0; $i <= 401; $i++){
$LogLikelihoods[$i] = 0;
print "Interval = $i LL = $LogLikelihoods[$i]\n";
}
# die "NO\n";


$VariantNumberSum = 0;
$RecNum = 0;


$HapFileToOpen = $HapLengthFile;
$CurrentLeftRec = $LeftRecRate[$RecNum];
$CurrentRightRec = $RightRecRate[$RecNum];
$RecRateLeft = $CurrentLeftRec * .01 * 4*$LastPopSize*250000;
$RecRateRight= $CurrentRightRec * .01 * 4*$LastPopSize*250000;
print "Rec left = $RecRateLeft Rec right = $RecRateRight\n";
$RecNum++;
### Get Recombination rate
#print "$QuantileLeft\t$QuantileRight\n";

$HapLengthFileToOpen = $HapLengthFile.$VarNum.".txt";

@HapLengths = ();
open (HAP,$HapLengthFile ) or die "NO! File\n";
$OddOrEven = 0;
$LineNumber = 0;
while (<HAP>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
# push(@HapLengths,int($Line));
# print "$Line\t";
# print "$j\n";
# die "NO!\n";
for ($BinNum = 0; $BinNum < 6; $BinNum++){
for ($i = 1; $i <= 401; $i++){
$ToCheckNum = $OddOrEven % 2;
$LogLikelihoods[$i] = $LogLikelihoods[$i] + $SplitLine[$BinNum] * log ($ISValues[$RecValueTested - 1][$i+1][$BinNum+1]);
# print "$BinNum\t$i\n";
}
$LineNumber++;
$OddOrEven++;
}
}
close (HAP);

for ($i = 0; $i <= 401; $i++){
# print "LL $i = $LogLikelihoods[$i]\n";
}

# die "NO!\n";


open (EXIT,">$ExitFile") or die "NO!";

for ($i = 0; $i <= 401; $i++){
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
print "HapLength = $i\n";
for ($j = 0; $j < $NumberOfIntervalsToCheck; $j++){
if ( ($i >= $Bounds[$j]) && ($i <= $Bounds[$j+1])){
$IntervalFlag = 1;
last;
}
}
print "Check = $i\t$Bounds[$j]\t$Bounds[$j+1]\n";

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
print "$ISValues[$k][$j+1]\n";
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


