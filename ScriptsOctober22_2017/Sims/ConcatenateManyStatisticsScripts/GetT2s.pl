$File = $ARGV[0];
$ExitFile = $ARGV[1];

open (FILE,$File) or die "NO!";
open (EXIT,">$ExitFile") or die "NO!\n";

$FlagSequences = 4;
$TreeFlag = 0;
while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# print "$Line\n";
if ($Line =~ /\[\w+\](.+)2:(\w+\.\w+)/) {
# print "Here?\n";
if ($TreeFlag == 0){
print EXIT "$2\n";
}
$TreeFlag = 1;
}
if ($SplitLine[0] eq "selsite:"){
$SelSite = $SplitLine[1];
}
if ($SplitLine[0] eq "positions:"){
$Position = $SplitLine[$SelSite+1];
$FlagSequences = 0;
@Sequences = ();
@Positions = @SplitLine;
$TreeFlag = 0;
}

$FlagSequences++;
}

close (FILE);
close (EXIT);

