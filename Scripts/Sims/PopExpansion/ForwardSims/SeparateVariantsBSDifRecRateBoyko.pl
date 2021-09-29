@FourNs = ("4Ns_0","4Ns_-50","4Ns_-100","4Ns_50","4Ns_100");

$ExitFile = "../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/HapLengthsDifRecRateNS1_1.txt";
open (EXIT, ">$ExitFile") or die "NO!";


for ($i = 1; $i <= 100; $i++ ) {

$File = "../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/HapLengthsDifRecRateNS$i.txt";

open (FILE, $File) or die "NO!";
$LineNumber = 0;
$Counter = 1;
while (<FILE>){
chomp;
$Line = $_;
if ($LineNumber % 1560 == 0){

close (EXIT);
$ExitFile = "../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/HapLengthsDifRecRateNS$i"."_"."$Counter.txt";
print "$ExitFile\n";
open (EXIT, ">$ExitFile") or die "NO!";
$Counter++
}
print EXIT "$Line\n";
$LineNumber++;
}

close (FILE);
}

