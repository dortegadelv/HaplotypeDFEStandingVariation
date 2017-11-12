open (FILE,"LDistributionAllOnePercentSynSites.txt") or die "NO";
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
@MismatchStatistic = ();
for ($j = 0; $j < 6; $j++){
$MismatchStatistic[$j] = 0;
}

for ($i = 1; $i <= 100; $i++){
print "File = $i\n";
$File = "../../../../Results/ABCReplication/Output/WindowDistanceOut".$i.".txt";
open (FILE,$File) or die "NO";

while (<FILE>){
$Line = $_;
@LDistSims = split(/\s+/,$Line);
# $MismatchStatistic = 0;
for ($j = 0; $j < 6; $j++){
$MismatchStatistic[$j] = $MismatchStatistic[$j] + abs( $LDistSims[$j] - $LDistData[$j]);
}
}
close (FILE);
}
print "Mismatch statistic windows =";
$TotalSum = 0;
for ($j = 0; $j < 6; $j++){
$MismatchStatistic[$j] = $MismatchStatistic[$j] / 100;
print "\t$MismatchStatistic[$j]";
$TotalSum = $TotalSum + $MismatchStatistic[$j];
}
# $MismatchStatistic = $MismatchStatistic / 100;
# print "Mismatch statistic = $MismatchStatistic\n";
print "\n";
print "Total sum = $TotalSum\n";
