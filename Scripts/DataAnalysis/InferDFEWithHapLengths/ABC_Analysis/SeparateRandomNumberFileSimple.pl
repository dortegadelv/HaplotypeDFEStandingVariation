open (RECFILE,"../../../../Data/RecSynFileNumber.txt") or die "NO!";
@RecFile = ();

while (<RECFILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push (@RecFile,$Line);
}

close (RECFILE);

$Left = $ARGV[0];
$Right = $ARGV[1];

$LeftO = $Left.".txt";
$RightO = $Right.".txt";

open (LEFT,">$LeftO") or die "NO!";

open (RIGHT,">$RightO") or die "NO!";

$LineNumber = 0;

open (LEFTO, $Left ) or die "NO!";
while (<LEFTO>){
chomp;
$Line = $_;
if ($RecFile[$LineNumber] != 0){
print LEFT "$Line\n";
# print RIGHT69 "$Line\n";
}
$LineNumber++;
}

close (LEFTO);

$LineNumber = 0;

open (RIGHTO, $Right ) or die "NO!";
while (<RIGHTO>){
chomp;
$Line = $_;
if ($RecFile[$LineNumber] != 0){
# print LEFT69 "$Line\n";
print RIGHT "$Line\n";
}
$LineNumber++;
}
close (RIGHTO);

