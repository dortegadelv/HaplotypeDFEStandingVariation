$ExitFile = "../../../../Results/PopExpansion/ImportanceSamplingSims/SumDistancesFile10000_50Windows.txt";
open (EXIT,">$ExitFile") or die "NO! $ExitFile\n";

for ( $j = 1; $j <= 100; $j++ ){
print "File Number = $j\n";
@Distances = ();
for ( $i = 0; $i < 127; $i++){
# print "Row = $i\n";
for ( $row = 0; $row < 1000; $row++ ){
$Distances[$i][$row] = 0;
}}

for ( $k = 1; $k <= 1; $k++ ){
$InputFile = "../../../../Results/PopExpansion/ImportanceSamplingSims/DistancesFile10000_50Windows_".$j."_".$k.".txt";
open (INPUT,$InputFile) or die "NO! $InputFile\n";
$row = 0;
while (<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ( $i = 0; $i < 127; $i++){
$Distances[$i][$row] = $Distances[$i][$row] + $SplitLine[$i];
# print "$Distances[$i][$row]\t";
}
# print "\n";
# die "Enough\n";
$row++;
}

close(INPUT);
}
print "Here?\n";
for ( $row = 0; $row < 1000; $row++ ){
for ( $i = 0; $i < 127; $i++){
$Distances[$i][$row] = $Distances[$i][$row] / 1;
print EXIT "$Distances[$i][$row]\t";
}
print EXIT "\n";
}
}
close (EXIT);

