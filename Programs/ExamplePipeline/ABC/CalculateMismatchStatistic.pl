$LDistributionOnePercent = $ARGV[0];
$IdentifierEnd = $ARGV[1];

open (FILE,$LDistributionOnePercent) or die "NO";
@LDistData = ();

while (<FILE>){
chomp;
$Line = $_;
@LDistData = split(/\s+/,$Line);
print "Line = $Line $LDistData[0] $LDistData[1]\n";
}
close (FILE);
foreach $j (@LDistData){
print "$j\t";
}
print "\n";

@LDistSims = ();
for ($i = 1; $i <= $IdentifierEnd; $i++){
print "File = $i\n";
$File = "../Results/WindowDistanceOutNotCpG".$i.".txt";
open (FILE,$File) or die "NO";
$ExitFile = "../Results/WindowMismatchNotCpG".$i.".txt";
open (EXIT,">$ExitFile") or die "NO";

while (<FILE>){
$Line = $_;
@LDistSims = split(/\s+/,$Line);
$MismatchStatistic = 0;
for ($j = 0; $j < 6; $j++){
$MismatchStatistic = $MismatchStatistic + abs($LDistData[$j] - $LDistSims[$j]);
}
print EXIT "$MismatchStatistic\n";
}
close (FILE);
close (EXIT);
}
