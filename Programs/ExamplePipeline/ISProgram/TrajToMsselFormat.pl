$File = $ARGV[0];
$ExitFile = $ARGV[1];
$NumberOfTrajectories=$ARGV[2];
$Ne = $ARGV[3];

open (FILE,$File) or die "Cannot open file $File";
open (EXIT,">$ExitFile") or die "Cannot create file $ExitFile";

print EXIT "// This is an input file for Hudson's mssel stepftn.c program\n";
print EXIT "$NumberOfTrajectories N0: $Ne\n";
print EXIT "1\n";
while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

if ($Line =~ "REP"){
$NewTraj = "";
$NumberOfIntervals = 0;
}
elsif ($Line =~ "TRA"){
$NewTraj = $NewTraj."\n$SplitLine[1]\t$SplitLine[2]";
$NumberOfIntervals++;
$Age = $SplitLine[1];
}
elsif ($Line =~ "TOT"){
print EXIT "n:\t$NumberOfIntervals s: 0.000000 age: $Age";
print EXIT "$NewTraj\n";
}
}

close(FILE);

