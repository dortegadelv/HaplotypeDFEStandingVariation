@FourNs = ();

$FourNs[1]="4Ns_0";
$FourNs[2]="4Ns_-25";
$FourNs[3]="4Ns_-50";
$FourNs[4]="4Ns_25";
$FourNs[5]="4Ns_50";

for ( $DirNumber = 1; $DirNumber <= 5 ; $DirNumber++ ) {
print "$FourNs[$DirNumber]\n";
$ExitFile = "../../../../Results/ResultsSelectionInferred/SelectionCloseQuantileUK10K".$FourNs[$DirNumber].".txt";
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 100 ; $RepNumber++) {
$File="../../../../Results/UK10K/ForwardSims/".$FourNs[$DirNumber]."/LLSimsMsselCloseQuantile273_".$RepNumber.".txt";

open (FILE,$File) or die "NO!";

$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# print "$SplitLine[1]";
if ($LineNumber == 126){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
if ($LineNumber > 125){
if ( ($SplitLine[1] > $Max ) && ($LineNumber > 125) && ($LineNumber < 277) ){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
}
# print "\t$MaxNum\n";
$LineNumber++;
}

close (FILE);
$SelValue = $MaxNum - 201;
print EXIT "$SelValue\n";
}
close (EXIT);
}

