$File = $ARGV[0];
$ExitFile = $ARGV[1];
$SequenceLength = $ARGV[2];
$SelSite = $ARGV[3];

open (FILE,$File) or die "NO!";
open (EXIT,">$ExitFile") or die "NO!\n";

$FlagSequences = 4;

while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

if ($FlagSequences <= 3){
$Sequences[$FlagSequences-1] = $Line;

if ($FlagSequences == 3){

$MiniFlag = 0;
print "$Positions[0]\t$Positions[1]\t$Positions[2]\n";
for ($i = 0; $i < length($Sequences[0]); $i++){
	$SubstrOne = substr($Sequences[1],$i,1);
	$SubstrTwo = substr($Sequences[2],$i,1);
	if ($SubstrOne ne $SubstrTwo){
		$Distance = ($Positions[$i+1] - $SelSite ) / $SequenceLength;
		print EXIT "$Distance\n";
		$MiniFlag = 1;
		last;
	}
}
if ($MiniFlag == 0){
print EXIT "2.0\n";
}

}

}

# if ($SplitLine[0] eq "selsite:"){
# $SelSite = $SplitLine[1];
# }
if ($SplitLine[0] eq "positions:"){
$Position = $SplitLine[$SelSite+1];
$FlagSequences = 0;
@Sequences = ();
@Positions = @SplitLine;
}

$FlagSequences++;
}

close (FILE);
close (EXIT);
