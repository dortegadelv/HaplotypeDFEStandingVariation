@FourNs = ();

$FourNs[1]="DFETest";

for ( $DirNumber = 1; $DirNumber <= 1 ; $DirNumber++ ) {
print "$FourNs[$DirNumber]\n";
$ExitFile = "../../../../Results/ResultsSelectionInferred/SelectionLargerSpaceBootstrapUK10K".$FourNs[$DirNumber].".txt";
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 100 ; $RepNumber++) {
$File="../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFEBootstrap".$RepNumber.".txt";

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
if ( ( $LineNumber > 0 ) && ( $LineNumber != 1501 ) ){
if ($SplitLine[1] > $Max ){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
}
# print "\t$MaxNum\n";
$LineNumber++;
}
print "Rep number = $RepNumber\tLine number = $LineNumber\n";
close (FILE);
$SelValue = $MaxNum - 1;

if ($MaxNum <= 1500){
print EXIT "0\t$SelValue\t$Max\n";
}else{
$CurValue = $MaxNum - 1502;
print EXIT "1\t$CurValue\t$Max\n";
}

}
close (EXIT);
}

