# $File = $ARGV[0];

open (FILE, "cat sim_seq_info_1.txt | grep \"cnc\" |") or die "NO!";

$CurrentNumber = 0;
$LineNumber = 0;
while (<FILE>){

chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
$NumberOne = $SplitLine[1];
$NumberTwo = $SplitLine[2];
# print "$NumberOne\t$NumberTwo\n";
if ($CurrentNumber >= $NumberOne){
die "NO $LineNumber\n";
}else{
$CurrentNumber = $NumberOne;
}

if ($CurrentNumber >= $NumberTwo){
die "NO $LineNumber\n";
}else{
$CurrentNumber = $NumberOne;
}

$LineNumber++;
}

close (FILE);
