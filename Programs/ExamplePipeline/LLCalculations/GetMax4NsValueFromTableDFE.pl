$InputTable = $ARGV[0];
$SelectionTable = $ARGV[1];
$ExitValues = "../Results/MaxLLEstimatesDFE.txt";

open (LL,$SelectionTable) or die "NO 5 $SelectionTable\n";

@SelectionValues = ();
while (<LL>){
    chomp;
    $Line = $_;
    @LineContent = split(/\s+/,$Line);
    $Params = "$LineContent[0]\t$LineContent[1]";
    push(@SelectionValues, $Params);
}

close (LL);

open (INPUT,$InputTable) or die "NO! 16 Input $InputTable";
open (OUTPUT,">$ExitValues") or die "NO! 17 $ExitValues";

while(<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$Max = $SplitLine[0];
$BestValue = 0;
for ($i = 0; $i < scalar(@SplitLine); $i++){
if ($SplitLine[$i] > $Max){
$Max = $SplitLine[$i];
$BestValue = $i;
}
}
print "Max = $Max\n";
print OUTPUT "$SelectionValues[$BestValue]\t";

}

close(INPUT);
close(OUTPUT);

