$RecRateFile = $ARGV[0];
$ConvertedRecRateFile = $ARGV[1];

open (RECRATE, $RecRateFile) or die "NO";
open (EXIT,">$ConvertedRecRateFile") or die "NO"; 
while (<RECRATE>){
chomp;
$Line = $_;
$ConvertedRecRate = 2 * 209142 * $Line * 250000 * 5 / 100;
print EXIT "$ConvertedRecRate\n";
}

close (RECRATE);
close (EXIT);

