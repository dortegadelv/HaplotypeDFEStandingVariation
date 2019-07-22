@FourNs = ();

$FourNs[1]="4Ns_0";
$FourNs[2]="4Ns_-25";
$FourNs[3]="4Ns_-50";
$FourNs[4]="4Ns_25";
$FourNs[5]="4Ns_50";
$FourNs[6]="4Ns_1";

@ExitFiles = ();
push (@ExitFiles,"../../../../Results/ResultsSelectionInferred/SelectionUK10KBootstrapTenFold.txt");
push (@ExitFiles,"../../../../Results/ResultsSelectionInferred/SelectionOnlyNegUK10KBootstrapTenFold.txt");
push (@ExitFiles,"../../../../Results/ResultsSelectionInferred/SelectionSynUK10KBootstrapTenFold.txt");
push (@ExitFiles,"../../../../Results/ResultsSelectionInferred/SelectionOnlyNegSynUK10KBootstrapTenFold.txt");

@InputFilePrefix = ();
push (@InputFilePrefix,"../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataBootstrap");
push (@InputFilePrefix,"../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataBootstrap");
push (@InputFilePrefix,"../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataBootstrapSyn");
push (@InputFilePrefix,"../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataBootstrapSyn");

@Limits = ();
push (@Limits,277);
push (@Limits,202);
push (@Limits,277);
push (@Limits,202);


for ( $DirNumber = 0; $DirNumber <= 3 ; $DirNumber++ ) {
print "$FourNs[$DirNumber]\n";
$ExitFile = $ExitFiles[$DirNumber];
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 100 ; $RepNumber++) {
$File=$InputFilePrefix[$DirNumber].$RepNumber.".txt";
open (FILE,$File) or die "NO!";
if ( ($RepNumber % 5) == 1){
@LLValues = ();
$RowNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@LLValues, $SplitLine[1]);
$RowNumber++;
}
close (FILE);
}elsif(($RepNumber % 5) == 0){
$RowNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$LLValues[$RowNumber] = $LLValues[$RowNumber] + $SplitLine[1];
$RowNumber++;
}
close (FILE);
for ($i = 0; $i < scalar(@LLValues); $i++){
if ($i == 126){
$Max = $LLValues[$i];
$MaxNum = $i;
}elsif(($LLValues[$i] > $Max) && ($i > 126) && ($i < $Limits[$DirNumber])){
$Max = $LLValues[$i];
$MaxNum = $i;
}
}
$SelValue = $MaxNum - 201;
print EXIT "$SelValue\n";

}else{
$RowNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$LLValues[$RowNumber] = $LLValues[$RowNumber] + $SplitLine[1];
$RowNumber++;
}
close (FILE);
}

}
close (EXIT);
}




