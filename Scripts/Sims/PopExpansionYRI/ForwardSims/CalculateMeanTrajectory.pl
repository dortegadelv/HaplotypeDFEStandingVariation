$TrajFile = $ARGV[0];
$ExitMeanTrajFile = $ARGV[1];
$Ne = $ARGV[2];

%MeanTrajValues = ();
$MaxTime = 10000;
$NumberOfTrajectories = 0;

open (FILE,$TrajFile) or die "NO!";
open (EXIT,">$ExitMeanTrajFile") or die "NO!";

for ($i = 1; $i <= $MaxTime ; $i++ ){
$MeanTrajValues{$Gen} = 0;
}

while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if (scalar(@SplitLine) == 2){
$Gen = int(( $Age - $SplitLine[0])*4*$Ne + 0.5);
if ($Gen <= $MaxTime ){
$MeanTrajValues{$Gen} = $MeanTrajValues{$Gen} + $SplitLine[1];
}
}

if(/age: (.+)/){
$NumberOfTrajectories++;
$Age = $1;
print "$NumberOfTrajectories\t$Age\n";
}

}

close(FILE);

for ($i = 1; $i <= $MaxTime ; $i++ ){
$MeanTrajValues{$i} = $MeanTrajValues{$i} / $NumberOfTrajectories;
print EXIT "$i\t$MeanTrajValues{$i}\n";
}

