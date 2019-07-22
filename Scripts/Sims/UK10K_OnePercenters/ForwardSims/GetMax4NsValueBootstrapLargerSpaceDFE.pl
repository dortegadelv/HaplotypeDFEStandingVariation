@FourNs = ();

$FourNs[1]="DFETest";

for ( $DirNumber = 1; $DirNumber <= 1 ; $DirNumber++ ) {
print "$FourNs[$DirNumber]\n";
$ExitFile = "../../../../Results/ResultsSelectionInferred/SelectionLargerSpaceBootstrapUK10K".$FourNs[$DirNumber].".txt";
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 100 ; $RepNumber++) {
$File="../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFEBootstrapWideRangeOne".$RepNumber.".txt";

open (FILE,$File) or die "NO! $File\n";

$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# print "$SplitLine[1]";
if ($LineNumber == 1){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
if ($LineNumber > 0){
if ($SplitLine[1] > $Max ){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
}
# print "\t$MaxNum\n";
$LineNumber++;
}

close (FILE);
$SelValue = $MaxNum - 1;
$FirstMaxLL = $Max;
$FirstSelValue = $SelValue; 
# print EXIT "0\t$SelValue\t$Max\t";
$File="../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFEBootstrapWideRangeTwo".$RepNumber.".txt";

open (FILE,$File) or die "NO! $File\n";

$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# print "$SplitLine[1]";
if ($LineNumber == 1){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
if ($LineNumber > 0){
if ($SplitLine[1] > $Max ){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
}
# print "\t$MaxNum\n";
$LineNumber++;
}

close (FILE);
$SelValue = $MaxNum - 1;

if ($FirstMaxLL > $Max){
print EXIT "0\t$FirstSelValue\t$FirstMaxLL\n";
}else{
print EXIT "1\t$SelValue\t$Max\n";
}

}
close (EXIT);
}

