$File = $ARGV[0];
$TrajNumber = $ARGV[1];
$ExitFile = $ARGV[2];

open (FILE,$File) or die "NO!";
open (EXIT,">$ExitFile") or die "NO!";
$CurrentTrajNumber = 0;
while (<FILE>){
chomp;
$Line = $_;

if (/age/){

$CurrentTrajNumber++;
}

if ($CurrentTrajNumber > $TrajNumber){
last;
}
print EXIT "$Line\n";
}

close (FILE);
close (EXIT);
