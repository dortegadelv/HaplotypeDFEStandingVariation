@Folders = ();
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.000000012RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.000000012RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.000000012RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.000000012RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.000000015RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.000000015RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.000000015RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.000000015RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.00000002RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.00000002RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.00000002RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.000005MutRate0.00000002RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.000000012RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.000000012RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.000000012RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.000000012RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.000000015RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.000000015RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.000000015RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.000000015RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.00000002RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.00000002RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.00000002RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0000075MutRate0.00000002RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.000000012RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.000000012RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.000000012RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.000000012RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.000000015RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.000000015RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.000000015RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.000000015RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.00000002RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.00000002RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.00000002RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.00001MutRate0.00000002RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.000000012RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.000000012RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.000000012RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.000000012RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.000000015RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.000000015RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.000000015RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.000000015RecRate0.0000000234");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.00000002RecRate0.0000000025");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.00000002RecRate0.0000000075");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.00000002RecRate0.0000000125");
push(@Folders,"ImportanceSamplingSimsErrorRate0.0MutRate0.00000002RecRate0.0000000234");


for ($FolderNum = 0; $FolderNum < 48 ; $FolderNum++){

$ExitFile = "../../../../../Results/UK10K/".$Folders[$FolderNum]."/SumDistancesFile10000.txt";
open (EXIT,">$ExitFile") or die "NO! $ExitFile\n";

for ( $j = 1; $j <= 100; $j++ ){
print "File Number = $j\n";
@Distances = ();
for ( $i = 0; $i < 27; $i++){
# print "Row = $i\n";
for ( $row = 0; $row < 1000; $row++ ){
$Distances[$i][$row] = 0;
}}

for ( $k = 1; $k <= 1; $k++ ){
$InputFile = "../../../../../Results/UK10K/".$Folders[$FolderNum]."/DistancesFile10000_".$j.".txt";
open (INPUT,$InputFile) or die "NO! $InputFile\n";
$row = 0;
while (<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ( $i = 0; $i < 27; $i++){
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
for ( $i = 0; $i < 27; $i++){
$Distances[$i][$row] = $Distances[$i][$row] / 1;
print EXIT "$Distances[$i][$row]\t";
}
print EXIT "\n";
}
}
close (EXIT);
}
