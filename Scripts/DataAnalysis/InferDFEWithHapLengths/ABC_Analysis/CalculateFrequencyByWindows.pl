$BoundariesFile=$ARGV[0];
$HaplotypeDistancesFile=$ARGV[1];
$ExitDistanceFile = $ARGV[2];

@Bounds = ();
@Distances = ();
open (BOUNDS,$BoundariesFile) or die "NO!";

while(<BOUNDS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@Bounds,$SplitLine[0]);
}

close(BOUNDS);

open (EXIT,">>$ExitDistanceFile") or die "NO!";

@WindowCount = ();
foreach $i (@Bounds){
push(@WindowCount,0);
}

open (DIST,$HaplotypeDistancesFile) or die "NO!";

while (<DIST>){
chomp;
$Distance = $_;
push (@Distances, $Distance );
}

close (DIST);

foreach $i (@Distances){
for ($j = 0; $j <= scalar(@Bounds); $j++) {
if ( ($i >= $Bounds[$j]) && ($i <= $Bounds[$j+1]) ){
$WindowCount[$j]++;
# print "$j\n";
last;
}
}
}
$DistanceNumber = scalar(@Distances);
print "Distances in vector = $DistanceNumber\n";
for ($j = 0; $j < scalar(@WindowCount) ; $j++){
$Fraction = $WindowCount[$j]/$DistanceNumber;
print EXIT "$Fraction\t";
}

print EXIT "\n";
close (EXIT);

