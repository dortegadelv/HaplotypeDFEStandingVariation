@FourNs = ();

$FourNs[1]="4Ns_0";
$FourNs[2]="4Ns_-25";
$FourNs[3]="4Ns_-50";
$FourNs[4]="4Ns_25";
$FourNs[5]="4Ns_50";
$FourNs[6]="4Ns_1";

@CoefNums = (1,3,4,5,6,7,8,9);
for ( $DirNumber = 1; $DirNumber <= 5 ; $DirNumber++ ) {
foreach $CoefNum ( @CoefNums ){
print "$FourNs[$DirNumber]\n";
$ExitFile = "../../../../Results/ResultsSelectionInferred/SelectionUK10K".$FourNs[$DirNumber]."CoefNum".$CoefNum.".txt";
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 100 ; $RepNumber++) {
$File="../../../../Results/UK10K/ForwardSims/".$FourNs[$DirNumber]."/LLSimsMssel273_".$RepNumber."_CoefNum".$CoefNum.".txt";

open (FILE,$File) or die "NO! $File";

$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# print "$SplitLine[1]";
if ($LineNumber == 123){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
if ($LineNumber > 0){
if ( ($SplitLine[1] > $Max) && ($LineNumber > 123) && ($LineNumber < 294) ){
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
}
