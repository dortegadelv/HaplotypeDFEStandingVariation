open (DATA,"../../Data/RandomForestResults/uk10k.votesWithHeader/votes_4.txt") or die "NO!";

$LineNumber = 0;
open (EXIT,">../../Data/RandomForestResults/uk10k.votesWithHeader/votes4_perindividual.txt") or die "NO!";
while (<DATA>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ( $LineNumber == 0 ){
@Header = 0;
@Counter = ();
for ($i = 0; $i < scalar(@SplitLine) ; $i++){
$Header[$i] = $SplitLine[$i];
$Counter[$i] = 0;
}
}else{

$Max = $SplitLine[3];
$MaxRow = 3;
for ($i = 4; $i < scalar(@SplitLine) ; $i++){
if ($SplitLine[$i] > $Max){
$Max = $SplitLine[$i];
$MaxRow = $i;
}
}
$Counter[$MaxRow]++;
print EXIT "$SplitLine[2]\t$Header[$MaxRow-1]\n";
}
$LineNumber++;
}
close(EXIT);


open (EXIT,">../../Data/RandomForestResults/uk10k.votes4MaxCount.txt") or die "NO!";

for ($i = 3; $i < scalar(@SplitLine); $i++){
print EXIT "$Counter[$i]\t";
}
print EXIT "\n";
close(DATA);
close(EXIT);
