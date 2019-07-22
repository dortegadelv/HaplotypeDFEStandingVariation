$InputFile = $ARGV[0];
$RepNumber = $ARGV[1];
$ExitFile = $ARGV[2];
$RandomSeed = $ARGV[3];

$UpperLimit = 10000;
srand($RandomSeed);

open (INPUT,$InputFile) or die "NO!";
open (OUTPUT,">$ExitFile") or die "NO!";
@Trajectories = ();
$HeaderFlag = 0;
$Header = "";
$TrajNumber = -1;

while(<INPUT>){
chomp;
$Line = $_;
push(@File,$Line);

if ($Line =~ /age/){
$HeaderFlag = 1;
$TrajNumber++;
$Trajectories[$TrajNumber] = "";
}

if ($HeaderFlag == 0){
$Header = $Header."$Line\n";
}else{
$Trajectories[$TrajNumber] = $Trajectories[$TrajNumber]."$Line\n";
}
}

close(INPUT);

print "Number of trajectories = $TrajNumber\n";

print "Header = $Header";

print OUTPUT "$Header";

for ($i = 1; $i <= $RepNumber ; $i++){
$RandomNumber = int(rand($UpperLimit));
print OUTPUT "$Trajectories[$RandomNumber]";
}
