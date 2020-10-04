open (FILE,"LDistributionPopExpansionSLiM4Ns50.txt") or die "NO";
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
for ($i = 1; $i <= 5000; $i++){
print "File = $i\n";
$File = "../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowDistanceOutNotCpG".$i.".txt";
open (FILE,$File) or die "NO";
$ExitFile = "../../../../Results/ABCAnalysisPopExpansionLessFiveFold/Output/WindowMismatchNotCpG4Ns_50".$i.".txt";
open (EXIT,">$ExitFile") or die "NO";

while (<FILE>){
$Line = $_;
@LDistSims = split(/\s+/,$Line);
$MismatchStatistic = 0;
for ($j = 0; $j < 6; $j++){
$MismatchStatistic = $MismatchStatistic + abs($LDistData[$j] - $LDistSims[$j]);
# print "$j $LDistSims[$j] $LDistData[$j]\t";
}
# print "$MismatchStatistic\n";
# die "NO\n";
print EXIT "$MismatchStatistic\n";
}
close (FILE);
close (EXIT);
}
