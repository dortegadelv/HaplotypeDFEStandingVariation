$File = $ARGV[0];
$ExitFile = $ARGV[1];
$Window = $ARGV[2];
$BoundariesFile=$ARGV[3];

@Bounds = ();
@Distances = ();
open (BOUNDS,$BoundariesFile) or die "NO!";

while(<BOUNDS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@Bounds,$SplitLine[0]);
}

close(BOUNDS);

@WindowCount = ();
foreach $i (@Bounds){
push(@WindowCount,0);
}

open (FILE,$File) or die "NO!";
open (EXIT,">>$ExitFile") or die "NO!\n";

$FlagSequences = 4;

while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

if ($FlagSequences <= 3){
$Sequences[$FlagSequences-1] = $Line;

if ($FlagSequences == 3){

$MiniFlag = 0;
for ($i = $SelSite; $i < length($Sequences[0]); $i++){
	$SubstrOne = substr($Sequences[1],$i,1);
	$SubstrTwo = substr($Sequences[2],$i,1);
	if ($SubstrOne ne $SubstrTwo){
		$Distance = ( $Positions[$i+1] - $Position ) * $Window;
		push(@Distances,$Distance);
#		print EXIT "$Distance\n";
		$MiniFlag = 1;
		last;
	}
}
if ($MiniFlag == 0){
$Boundary = $Window + 1;
push(@Distances,$Boundary);
#print EXIT "$Boundary\n";
}

}

}

if ($SplitLine[0] eq "selsite:"){
$SelSite = $SplitLine[1];
}
if ($SplitLine[0] eq "positions:"){
$Position = $SplitLine[$SelSite+1];
$FlagSequences = 0;
@Sequences = ();
@Positions = @SplitLine;
}

$FlagSequences++;
}

close (FILE);
# close (EXIT);

$NumberOfDistances = 0;
foreach $i (@Distances){
# print "$i\t";
$NumberOfDistances++;
for ($j = 0; $j <= scalar(@Bounds); $j++) {
if ( ($i >= $Bounds[$j]) && ($i <= $Bounds[$j+1]) ){
$WindowCount[$j]++;
# print "$j\n";
last;
}
}
}
# print EXIT "HEY!\t";
for ($j = 0; $j < scalar(@WindowCount) ; $j++){
$Fraction = $WindowCount[$j]/$NumberOfDistances;
print EXIT "$Fraction\t";
}

print EXIT "\n";
close (EXIT);
