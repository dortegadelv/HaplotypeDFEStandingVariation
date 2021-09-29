@FourNs = ();

$FourNs[1]="4Ns_0";
$FourNs[2]="4Ns_-50";
$FourNs[3]="4Ns_-100";
$FourNs[4]="4Ns_50";
$FourNs[5]="4Ns_100";
$FourNs[6]="4Ns_1";


$ExitFile = "../../../../Results/ResultsSelectionInferred/SelectionPopExpansionBoykoDifRecRate.txt";
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 100 ; $RepNumber++) {
$File="../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/LLDataDifRecRateNS$RepNumber.txt";

open (FILE,$File) or die "NO!";

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
if ( ($SplitLine[1] > $Max) ){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
}
# print "\t$MaxNum\n";
$LineNumber++;
}

close (FILE);
$SelValue = $MaxNum - 1;
print EXIT "$SelValue\n";
}
close (EXIT);




