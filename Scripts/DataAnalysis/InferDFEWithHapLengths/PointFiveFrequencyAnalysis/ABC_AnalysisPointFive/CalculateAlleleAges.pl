$ReducedTrajectories = $ARGV[0];
$AlleleAges = $ARGV[1];
$NumberOfAlleles = $ARGV[2];
open (TRAJ,$ReducedTrajectories) or die "NO";
open (EXIT,">>$AlleleAges") or die "NO";
$NumberOfAges = 0;
@Ages = ();

while (<TRAJ>){
chomp;
$Line = $_;

if ($Line =~ /N0/){
@SplitLine = split(/\s+/,$Line);
$N0 = $SplitLine[2];
}

if ($Line =~ /age/){
@SplitLine = split(/\s+/,$Line);
$CurrentAge = $N0 * 4 * $SplitLine[5];
push ( @Ages , $CurrentAge );
# print "$CurrentAge $N0 $SplitLine[5]\n";
$NumberOfAges++;
}
if ($NumberOfAges == $NumberOfAlleles){
last;
}
}

close(TRAJ);

$Max = 0;
$Min = 99999999;
$Mean = 0;
$MeanSq = 0;
foreach $i ( @Ages ) {
if ($i > $Max){
$Max = $i;
}
if ($i < $Min){
$Min = $i;
}
$Mean = $Mean + $i;
$MeanSq = $MeanSq + $i * $i;
}

$Mean = $Mean / scalar(@Ages);
$MeanSq = $MeanSq / scalar(@Ages);

$SD = ($MeanSq - $Mean * $Mean)** (1/2);
print EXIT "$Mean\t$SD\t$Max\t$Min\n";

