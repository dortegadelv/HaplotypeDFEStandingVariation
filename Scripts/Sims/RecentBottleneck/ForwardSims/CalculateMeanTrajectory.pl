$TrajFile = $ARGV[0];
$ExitMeanTrajFile = $ARGV[1];
$Ne = $ARGV[2];
$TrajNumberToTake = $ARGV[3];

%MeanTrajValues = ();
%SDErrorTrajValues = ();
$MaxTime = 10000;
$NumberOfTrajectories = 0;

open (FILE,$TrajFile) or die "NO!";
open (EXIT,">$ExitMeanTrajFile") or die "NO!";

for ($i = 0; $i <= $MaxTime ; $i++ ){
$MeanTrajValues{$Gen} = 0;
$SDErrorTrajValues{$Gen} = 0;
}

while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if (scalar(@SplitLine) == 2){
$Gen = int(( $Age + (1/(4*$Ne)) - $SplitLine[0])*4*$Ne + 0.5);
if ($Gen <= $MaxTime ){
$MeanTrajValues{$Gen} = $MeanTrajValues{$Gen} + $SplitLine[1];
}
}

if(/age: (.+)/){
$NumberOfTrajectories++;
$Age = $1;
# print "$NumberOfTrajectories\t$Age\n";
}

if ($NumberOfTrajectories > $TrajNumberToTake){
last;
}
}

close(FILE);

$NumberOfTrajectories = $NumberOfTrajectories - 1;
for ($i = 0; $i <= $MaxTime ; $i++ ){
$MeanTrajValues{$i} = $MeanTrajValues{$i} / $NumberOfTrajectories;
# print EXIT "$i\t$MeanTrajValues{$i}\n";
}

$NumberOfTrajectories = 0;

open (FILE,$TrajFile) or die "NO!";

while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if (scalar(@SplitLine) == 2){
$Gen = int(( $Age - $SplitLine[0])*4*$Ne + 0.5);
if ($Gen <= $MaxTime ){
# $MeanTrajValues{$Gen} = $MeanTrajValues{$Gen} + $SplitLine[1];
$SDErrorTrajValues{$Gen} = $SDErrorTrajValues{$Gen} + ($SplitLine[1] - $MeanTrajValues{$Gen}) * ($SplitLine[1] - $MeanTrajValues{$Gen});
}
}

if(/age: (.+)/){
$NumberOfTrajectories++;
$Age = $1;
# print "$NumberOfTrajectories\t$Age\n";
}

if ($NumberOfTrajectories > $TrajNumberToTake){
last;
}
}

close(FILE);

$NumberOfTrajectories = $NumberOfTrajectories - 1;
print "Number of trajectories = $NumberOfTrajectories\n";
for ($i = 0; $i <= $MaxTime ; $i++ ){
$SDErrorTrajValues{$i} = ( $SDErrorTrajValues{$i} / $NumberOfTrajectories ) ** ( 1 / 2 ) ;
$SDErrorTrajValues{$i} = $SDErrorTrajValues{$i} / ( $NumberOfTrajectories ** ( 1 / 2 )  );
$LowError = $MeanTrajValues{$i} - $SDErrorTrajValues{$i};
$UpError = $MeanTrajValues{$i} + $SDErrorTrajValues{$i};
print EXIT "$i\t$MeanTrajValues{$i}\t$LowError\t$UpError\n";
}

