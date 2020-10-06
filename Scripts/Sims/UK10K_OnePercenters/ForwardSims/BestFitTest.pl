$TableBestFit = "BestFitTest4Ns50.txt";

@Probs = ();

open (TABLE,$TableBestFit) or die "NO!";
$LineNumber = 0;
while (<TABLE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
for ($i = 0; $i < 6 ; $i++){
$Probs[$i][$LineNumber] = $SplitLine[$i];
}
$LineNumber++;
}

close (TABLE);

for ($Quantile = 1; $Quantile <= 21 ; $Quantile++){

$TableFile = "../../../../Results/UK10K_OnePercenters/ImportanceSamplingSims/Quantile".$Quantile."/TableToTest.txt";

$MinAbsValue = 1;
$FourNsMinAbsValue = 0;
$FiftyAbsValue = 0;
open (TABLE,$TableFile ) or die "NO! $TableFile";

$LineNumber = 0;
while (<TABLE>){
chomp;
$CurrentAbsValue = 0;
$Line = $_;
@SplitTable = split(/\s+/,$Line);
for ($Window = 0; $Window < 6; $Window++){
$CurrentAbsValue = $CurrentAbsValue + abs($Probs[$Window][$Quantile-1] - $SplitTable[$Window+1]);
# print "$Probs[$Window][$Quantile-1]\t$SplitTable[$Window+1]\n"
}
# print "$LineNumber\t$CurrentAbsValue\n";
# die "NO!\n";
if ($LineNumber == 253){
$FiftyAbsValue = $CurrentAbsValue;
}

if ( $CurrentAbsValue < $MinAbsValue){
$MinAbsValue = $CurrentAbsValue;
$FourNsMinAbsValue = $LineNumber;
}

$LineNumber++;
}
close (TABLE);
# die "NO!\n";
print "Quantile $Quantile
$MinAbsValue\t$FourNsMinAbsValue
$FiftyAbsValue\t50\n";
}
