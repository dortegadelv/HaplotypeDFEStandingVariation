$File = $ARGV[0];
$ExitFile = $ARGV[1];
$Window = $ARGV[2];
$BoundariesFile=$ARGV[3];
$ErrorRate = $ARGV[4];

use Math::Random qw(random_poisson);
use Math::Random qw(random_uniform);

$NoSingletonProb = 0.520749;

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
@CurrentDistanceSet = ();
$NumberOfVariantAlleles = 0;
for ($i = $SelSite; $i < length($Sequences[0]); $i++){
	$SubstrOne = substr($Sequences[1],$i,1);
	$SubstrTwo = substr($Sequences[2],$i,1);
	if ($SubstrOne ne $SubstrTwo){
		$RandomUniform = random_uniform(1,0,1);
		if ($RandomUniform <= $NoSingletonProb){
		$Distance = ( $Positions[$i+1] - $Position ) * $Window;
#		push(@CurrentDistance,$Distance);
#		print EXIT "$Distance\n";
		$MiniFlag = 1;
		$NumberOfVariantAlleles++;
		last;
		}
	}
}
print " $MiniFlag $Distance ";
if ($MiniFlag == 0){
$FalsePositives = ($ErrorRate *($Window));
# die "NO! MADE IT HERE!\n";
if ( $FalsePositives <= 0){
print "ERROR!!! $Distance $FalsePositives $ErrorRate\n";
$FalsePositives = 0;
push (@Distances,$Window+1);
print "$Window 1\n";
# die "NO! MADE IR HERE!\n";
}else{
$RandomFP = random_poisson(1,$FalsePositives);
@ShortenedDistances = random_uniform($RandomFP, 0, $Distance);
$MinimumDistance = $Window+1;
if (scalar(@ShortenedDistances) > 0){
$MinimumDistance = $ShortenedDistances[0];
for ($l = 0; $l < scalar(@ShortenedDistances); $l++){
if ($MinimumDistance < $ShortenedDistances[$l]){
$MinimumDistance = $ShortenedDistances[$l];
}
}
push (@Distances,$MinimumDistance);
print "$MinimumDistance 2\n";
}else{
print "$Distance 5\n";
push (@Distances,$Window+1);
}

}
# else{
# push (@Distances,$Window+1);
# }

#print EXIT "$Boundary\n";
}else{
$FalsePositives = ($ErrorRate *($Distance-1));
if ($Distance <= 0){
# print "ERROR!!! $Distance $FalsePositives\n";
}
if ( $FalsePositives <= 0){
print "ERROR!!! $Distance $FalsePositives $ErrorRate\n";
$FalsePositives = 0;
push (@Distances,$Distance);
print "$Distance 3\n";
}else{

$RandomFP = random_poisson(1,$FalsePositives);
@ShortenedDistances = random_uniform($RandomFP, 0, $Distance);
if (scalar(@ShortenedDistances) > 0){
$MinimumDistance = $ShortenedDistances[0];
for ($l = 0; $l < scalar(@ShortenedDistances); $l++){
if ($MinimumDistance < $ShortenedDistances[$l]){
$MinimumDistance = $ShortenedDistances[$l];
}
}
print "$MinimumDistance 4\n";
push (@Distances,$MinimumDistance);
}else{
print "$Distance 5\n";
push (@Distances,$Distance);
}

}
#else{
#push (@Distances,$Distance);
#}
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
print "positions\t";
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
print EXIT "$NumberOfDistances";
print EXIT "\n";
close (EXIT);
