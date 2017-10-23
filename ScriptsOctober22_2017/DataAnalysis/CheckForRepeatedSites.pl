open (REP,">../../Data/RepeatedPositions.txt") or die "NO";
for ($i = 1; $i <= 22; $i++){
$File = "../../Data/UK10K_COHORTChr".$i.".20160215.sites";
$CurrentPosition = 0;
$LineNumber = 0;
open (FILE,$File) or die "NO!";
while (<FILE>){
chomp;
if ($LineNumber > 0){
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@MiniStuff = split(/\./,$SplitLine[1]);
if ($MiniStuff[0] < $CurrentPosition){
die "NO! Positions not in ascending order!\n"
}elsif ($MiniStuff[0] == $CurrentPosition){
print REP "$i\t$MiniStuff[0]\n";
}
}
$LineNumber++;
}

close(FILE);
}
close(REP);
