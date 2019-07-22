@FourNs = ();

$FourNs[1]="4Ns_0";
$FourNs[2]="4Ns_-25";
$FourNs[3]="4Ns_-50";
$FourNs[4]="4Ns_25";
$FourNs[5]="4Ns_50";

for ( $DirNumber = 1; $DirNumber <= 5 ; $DirNumber++ ) {
print "$FourNs[$DirNumber]\n";
$ExitFile = "../../../../Results/ResultsSelectionInferred/SelectionUK10KSingleRecMoreSamples".$FourNs[$DirNumber].".txt";
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 1000 ; $RepNumber++) {
$File="../../../../Results/UK10K/ForwardSims/".$FourNs[$DirNumber]."/LLSimsSingleRecMssel273_".$RepNumber.".txt";

if (( $RepNumber % 10 ) == 1){
open (FILE,$File) or die "NO!";

@LLSums = ();
$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# print "$SplitLine[1]";
$LLSums[ $LineNumber ] = $SplitLine[1];
# print "\t$MaxNum\n";
$LineNumber++;
}
close (FILE);
}elsif (( $RepNumber % 10 ) == 0){
open (FILE,$File) or die "NO!";

@LLSums = ();
$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# print "$SplitLine[1]";
$LLSums[ $LineNumber ] = $SplitLine[1] + $LLSums[ $LineNumber ];
# print "\t$MaxNum\n";
$LineNumber++;
}
close (FILE);
$MaxFourNsLL = $LLSums[ 126 ];
$MaxFourNs = 126 - 201;
# print EXIT "Start = $MaxFourNs\t$MaxFourNsLL\n";
for ($CurrentCheckedLine = 126; $CurrentCheckedLine < 202; $CurrentCheckedLine++){
if ($MaxFourNsLL < $LLSums[ $CurrentCheckedLine ] ){
$MaxFourNsLL = $LLSums[ $CurrentCheckedLine ];
$MaxFourNs = $CurrentCheckedLine - 201;
}
$CurrentFourNs = $CurrentCheckedLine - 201;
# print EXIT "$CurrentFourNs\t$LLSums[ $CurrentCheckedLine ]\n"
}
$MaxFourNs = $MaxFourNs;
print EXIT "$MaxFourNs\n";
}else{
open (FILE,$File) or die "NO!";

@LLSums = ();
$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# print "$SplitLine[1]";
$LLSums[ $LineNumber ] = $SplitLine[1] + $LLSums[ $LineNumber ];
# print "\t$MaxNum\n";
$LineNumber++;
}
close (FILE);
}
}
close (EXIT);
}

