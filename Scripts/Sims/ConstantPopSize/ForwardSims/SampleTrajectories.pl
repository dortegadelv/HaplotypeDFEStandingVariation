$InputFile = $ARGV[0];
$RepNumber = $ARGV[1];
$ExitFile = $ARGV[2];
$RandomSeed = $ARGV[3];
$N_Zero = $ARGV[4];

$UpperLimit = 10000;
srand($RandomSeed);

open (INPUT,$InputFile) or die "NO! $InputFile";
open (OUTPUT,">$ExitFile") or die "NO! $ExitFile";
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

$N_Zero = $N_Zero / 2;
print OUTPUT "//This is an input file for Hudson's mssel stepftn.c program
$RepNumber N0: $N_Zero
1\n";

for ($i = 1; $i <= $RepNumber ; $i++){
$RandomNumber = int(rand($UpperLimit));
print OUTPUT "$Trajectories[$RandomNumber]";
}
