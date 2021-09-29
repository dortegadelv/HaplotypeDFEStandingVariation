@FourNs = ();

$FourNs[1]="4Ns_0";
$FourNs[2]="4Ns_-25";
$FourNs[3]="4Ns_-50";
$FourNs[4]="4Ns_25";
$FourNs[5]="4Ns_50";
$FourNs[6]="4Ns_1";

for ( $DirNumber = 1; $DirNumber <= 5 ; $DirNumber++ ) {
print "$FourNs[$DirNumber]\n";
$ExitFile = "../../../../Results/ResultsSelectionInferred/SelectionUK10KPhasing".$FourNs[$DirNumber]."_N10000.txt";
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 100 ; $RepNumber++) {
$File="../../../../Results/UK10K/ForwardSims/".$FourNs[$DirNumber]."/HapLengths/ExitFileNoRecLessPhasingN10000_".$RepNumber.".txt";

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

###################

for ( $DirNumber = 1; $DirNumber <= 5 ; $DirNumber++ ) {
print "$FourNs[$DirNumber]\n";
$ExitFile = "../../../../Results/ResultsSelectionInferred/SelectionUK10KLessStatPhasing".$FourNs[$DirNumber]."_N10000.txt";
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 100 ; $RepNumber++) {
$File="../../../../Results/UK10K/ForwardSims/".$FourNs[$DirNumber]."/HapLengths/ExitFileNoRecLessStatPhasingN10000_".$RepNumber.".txt";

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
# # print "\t$MaxNum\n";
$LineNumber++;
}

close (FILE);
$SelValue = $MaxNum - 201;
print EXIT "$SelValue\n";
}
close (EXIT);
}

