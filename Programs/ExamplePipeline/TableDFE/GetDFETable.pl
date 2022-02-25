$InputTable = $ARGV[0];
$ExitDistancesTable = $ARGV[1];
$LowNsValue = $ARGV[2];
$UpNsValue = $ARGV[3];

open (TABLE , "$InputTable" ) or die "NO!";

$Number = 0;

@DistanceFourNSProbabilities = ();
while (<TABLE>){

chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
if ( ( $Number >= $LowNsValue ) && ( $Number <= $UpNsValue ) ) {
$CurrentFourNs = $UpNsValue - $Number;
print "$CurrentFourNs";
for ($k = 0; $k < scalar(@SplitLine) ; $k++){
# $CurrentFourNs = 402 - $Number - 2;
$DistanceFourNSProbabilities[$CurrentFourNs][$k] = $SplitLine[$k];
print "\t$SplitLine[$k]";
}
print "\n";
}

$Number++;
}
# die "NO!";
$TableNumber = $Number;
$ColumnNumberTable = $k;
close(TABLE);

open (PROBS, "AnotherExtraTableOfProbabilities.txt" ) or die "NO!";

@Probabilities = ();
$Number = 0;

while (<PROBS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

for ($k = 0; $k < scalar(@SplitLine) ; $k++){
$Probabilities[$Number][$k] = $SplitLine[$k];
}

$LengthOfVector = scalar(@SplitLine);
# print "Number = $Number and length = $LengthOfVector\n";
$Number++;
}

$TableNumber = $Number;
close(PROBS);

open ( EXIT, ">$ExitDistancesTable") or die "NO!";

@ExitTable = ();
$RowNumber = 0;
$ColumnNumber = 0;

print "Table number = $TableNumber Column number = $ColumnNumberTable\n";
for ( $i = 0; $i < $TableNumber; $i++){
for ( $k = 0; $k < $ColumnNumberTable; $k++){ 
$CurrentValue = 0;
for ( $j = 0; $j <= ($UpNsValue - $LowNsValue); $j++){
$CurrentValue = $CurrentValue + $Probabilities[$i][$j+2] * $DistanceFourNSProbabilities[$j][$k];
# print "$Probabilities[$i][$j+2]\t$DistanceFourNSProbabilities[$j][$k]\n";
# die "NO!";
}
print EXIT "$CurrentValue\t";
# $ExitTable[$RowNumber][$ColumnNumber] = $CurrentNumber;
}
print EXIT "\n";
$RowNumber++;
$ColumnNumber = 0;
}


