@FourNs = ("4Ns_0","4Ns_-50","4Ns_-100","4Ns_50","4Ns_100");

$ExitFile = "../../../../Results/PopExpansion/ForwardSims/4Ns_0/HapLengths/HapLengthsLessDifRecRateNS1_1.txt";
open (EXIT, ">$ExitFile") or die "NO!";

for ($j = 0; $j < 5; $j++ ){
for ($i = 1; $i <= 100; $i++ ) {

$File = "../../../../Results/PopExpansion/ForwardSims/$FourNs[$j]/HapLengths/HapLengthsLessDifRecRateNS$i.txt";

open (FILE, $File) or die "NO!";
$LineNumber = 0;
$Counter = 1;
while (<FILE>){
chomp;
$Line = $_;
if ($LineNumber % 1560 == 0){

close (EXIT);
$ExitFile = "../../../../Results/PopExpansion/ForwardSims/$FourNs[$j]/HapLengths/HapLengthsLessDifRecRateNS$i"."_"."$Counter.txt";
print "$ExitFile\n";
open (EXIT, ">$ExitFile") or die "NO!";
$Counter++
}
print EXIT "$Line\n";
$LineNumber++;
}

close (FILE);
}
}
