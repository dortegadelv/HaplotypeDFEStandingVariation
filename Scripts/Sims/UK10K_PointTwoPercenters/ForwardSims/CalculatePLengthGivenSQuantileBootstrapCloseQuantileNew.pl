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
$ExitFileBootstrap = $ARGV[11];

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

for ($i = 0; $i <= 401; $i++){
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

$VariantNumberSum = 0;
$RecNum = 0;
for ($VarNum = 0; $VarNum < scalar(@VariantsToUse); $VarNum++ ){
$VariantFlagFount = 0;
$RanVar = int(rand($NumberOfVariants));
$VarTotal = scalar(@VariantsToUse);
# print "Sampled $VarNum variants out of $VarTotal\n";
$SubResultsFile = $ExitFile.$RanVar.".txt";
open (SUBR,"$SubResultsFile") or die "NO! $SubResultsFile\n";
@LLSubResults = ();
$LineNumber = 0;
while (<SUBR>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
$LLSubResults[$LineNumber] = $SplitLine[1];
$LogLikelihoods[$LineNumber] = $LogLikelihoods[$LineNumber] + $SplitLine[1];
$LineNumber++;
}

print "Status = \t$VarNum\t LL = \t$LogLikelihoods[1]\t LLSubResult = \t$LLSubResults[1]\t RanVar = \t$RanVar\n";

close (SUBR);

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

for ($i = 0; $i <= 401; $i++){
# print "LL $i = $LogLikelihoods[$i]\n";
}

# die "NO!\n";
}

open (EXIT,">$ExitFileBootstrap") or die "NO!";

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


