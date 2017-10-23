$File = "TestData/run.2/Traj_0.01_";
$File = $ARGV[0];
$TwoN = $ARGV[1];
$ExitFile = $ARGV[2];
$TrajNumber = $ARGV[3];
$s = $ARGV[4];
$RepsStart = $ARGV[5];
$RepsEnd = $ARGV[6];

open (EXIT,">$ExitFile") or die "NO!";

$N0 = $TwoN / 2;

print EXIT "// This is an input file for Hudson's mssel stepftn.c program\n";
print EXIT "$TrajNumber N0: $N0\n";
for ($i = $RepsStart; $i <= $RepsEnd; $i++){
print "$i\n";
# $File = "TestData/run.2/Traj_0.01_".$i.".txt";
$FileToOpen = $File.$i.".txt";
open (FILE,$FileToOpen) or die "NO! $FileToOpen";

@AllelesToKeep = ();
%TimePerAllele = ();
%Trajectories = ();
%Ages = ();
while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if (grep {$_ eq $SplitLine[0]} @AllelesToKeep) {

$TimePerAllele{$SplitLine[0]}++;
$Time = ( $TimePerAllele{$SplitLine[0]} + 1 ) / (2 * $TwoN);

$Trajectories{$SplitLine[0]} = $Trajectories{$SplitLine[0]}."$Time\t$SplitLine[1]\n";
$Ages{$SplitLine[0]} = $Time - 1/(2 * $TwoN);

}else{
push(@AllelesToKeep,$SplitLine[0]);
$TimePerAllele{$SplitLine[0]} = 0;
$Time = ($TimePerAllele{$SplitLine[0]} + 1) / (2 * $TwoN);
$Trajectories{$SplitLine[0]} = "0\t0.0\n$Time\t$SplitLine[1]\n";
$Ages{$SplitLine[0]} = $Time - 1/(2 * $TwoN);
}}
close(FILE);

foreach $Traj (@AllelesToKeep){
print EXIT "# s: $s age: $Ages{$Traj}\n";
print EXIT "$Trajectories{$Traj}";
}
}

close(EXIT);
