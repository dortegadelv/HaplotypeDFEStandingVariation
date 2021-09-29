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

$Left69 = $Left."69";
$Left70 = $Left."70";
$Left71 = $Left."71";
$Left72 = $Left."72";
$Left73 = $Left."73";
$Left74 = $Left."74";
$Left75 = $Left."75";
$Left76 = $Left."76";

$Right69 = $Right."69";
$Right70 = $Right."70";
$Right71 = $Right."71";
$Right72 = $Right."72";
$Right73 = $Right."73";
$Right74 = $Right."74";
$Right75 = $Right."75";
$Right76 = $Right."76";

open (LEFT69,">$Left69") or die "NO!";
open (LEFT70,">$Left70") or die "NO!";
open (LEFT71,">$Left71") or die "NO!";
open (LEFT72,">$Left72") or die "NO!";
open (LEFT73,">$Left73") or die "NO!";
open (LEFT74,">$Left74") or die "NO!";
open (LEFT75,">$Left75") or die "NO!";
open (LEFT76,">$Left76") or die "NO!";

open (RIGHT69,">$Right69") or die "NO!";
open (RIGHT70,">$Right70") or die "NO!";
open (RIGHT71,">$Right71") or die "NO!";
open (RIGHT72,">$Right72") or die "NO!";
open (RIGHT73,">$Right73") or die "NO!";
open (RIGHT74,">$Right74") or die "NO!";
open (RIGHT75,">$Right75") or die "NO!";
open (RIGHT76,">$Right76") or die "NO!";

$LineNumber = 0;

open (LEFT, $Left ) or die "NO!";
while (<LEFT>){
chomp;
$Line = $_;
if ($RecFile[$LineNumber] == 69){
print LEFT69 "$Line\n";
# print RIGHT69 "$Line\n";
}
if ($RecFile[$LineNumber] == 70){
print LEFT70 "$Line\n";
# print RIGHT70 "$Line\n";
}
if ($RecFile[$LineNumber] == 71){
print LEFT71 "$Line\n";
# print RIGHT71 "$Line\n";
}
if ($RecFile[$LineNumber] == 72){
print LEFT72 "$Line\n";
# print RIGHT72 "$Line\n";
}
if ($RecFile[$LineNumber] == 73){
print LEFT73 "$Line\n";
# print RIGHT73 "$Line\n";
}
if ($RecFile[$LineNumber] == 74){
print LEFT74 "$Line\n";
# print RIGHT74 "$Line\n";
}
if ($RecFile[$LineNumber] == 75){
print LEFT75 "$Line\n";
# print RIGHT75 "$Line\n";
}
if ($RecFile[$LineNumber] == 76){
print LEFT76 "$Line\n";
# print RIGHT76 "$Line\n";
}
$LineNumber++;
}

close (LEFT);

$LineNumber = 0;

open (RIGHT, $Right ) or die "NO!";
while (<RIGHT>){
chomp;
$Line = $_;
if ($RecFile[$LineNumber] == 69){
# print LEFT69 "$Line\n";
print RIGHT69 "$Line\n";
}
if ($RecFile[$LineNumber] == 70){
# print LEFT70 "$Line\n";
print RIGHT70 "$Line\n";
}
if ($RecFile[$LineNumber] == 71){
# print LEFT71 "$Line\n";
print RIGHT71 "$Line\n";
}
if ($RecFile[$LineNumber] == 72){
# print LEFT72 "$Line\n";
print RIGHT72 "$Line\n";
}
if ($RecFile[$LineNumber] == 73){
# print LEFT73 "$Line\n";
print RIGHT73 "$Line\n";
}
if ($RecFile[$LineNumber] == 74){
# print LEFT74 "$Line\n";
print RIGHT74 "$Line\n";
}
if ($RecFile[$LineNumber] == 75){
# print LEFT75 "$Line\n";
print RIGHT75 "$Line\n";
}
if ($RecFile[$LineNumber] == 76){
# print LEFT76 "$Line\n";
print RIGHT76 "$Line\n";
}
$LineNumber++;
}

close (RIGHT);

