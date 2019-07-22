$InputTable = $ARGV[0];
$ExitDistancesTable = $ARGV[1];

for ( $QuantileNum = 1; $QuantileNum <= 21 ; $QuantileNum++ ) {
$TableFile = $InputTable.$QuantileNum."/TableToTest.txt";
$ExitDistancesFile = $ExitDistancesTable.$QuantileNum."/DFETableToTest.txt";
print "Currently in quantile $QuantileNum\n";
open (TABLE , "$TableFile" ) or die "NO! $TableFile";

$Number = 0;

@DistanceFourNSProbabilities = ();
while (<TABLE>){

chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
if ( ( $Number >= 2 ) && ( $Number < 203 ) ) {
$CurrentFourNs = 202 - $Number;
print "$CurrentFourNs";
for ($k = 0; $k < scalar(@SplitLine) ; $k++){
# $CurrentFourNs = 402 - $Number - 2;
$DistanceFourNSProbabilities[$CurrentFourNs][$k] = $SplitLine[$k];
# print "\t$SplitLine[$k]";
}
print "\n";
}

$Number++;
}
# die "NO!";
$TableNumber = $Number;
$ColumnNumberTable = $k;
close(TABLE);

open (PROBS, "DFETableOfProbabilities.txt" ) or die "NO!";

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
# die "NO!";
open ( EXIT, ">$ExitDistancesFile") or die "NO!";

@ExitTable = ();
$RowNumber = 0;
$ColumnNumber = 0;

print "Table number = $TableNumber Column number = $ColumnNumberTable\n";

for ( $i = 0; $i < 2; $i++){
for ( $k = 0; $k < $ColumnNumberTable; $k++){
$CurrentValue = 0;
for ( $j = 0; $j <= 80; $j++){
$CurrentValue = $CurrentValue + $Probabilities[0][$j+2] * $DistanceFourNSProbabilities[$j][$k];
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

$RowNumber = 0;
$ColumnNumber = 0;

for ( $i = 0; $i < $TableNumber; $i++){
for ( $k = 0; $k < $ColumnNumberTable; $k++){ 
$CurrentValue = 0;
for ( $j = 0; $j <= 80; $j++){
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

}
