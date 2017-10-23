for ($i = 0; $i < 4 ; $i++){

@HapLengths = ();
$LengthsPerGroup = "../../../Data/LengthsGroupsPerRecRateSynonymous".$i.".txt";
$BetterFormatLength = "../../../Data/BetterFormatLengthsGroupsPerRecRateSynonymous".$i.".txt";

open (LENGTH,"$LengthsPerGroup") or die "NO!";
open (FORMAT,">$BetterFormatLength") or die "NO!";

while (<LENGTH>){
chomp;
$Line = $_;
if ($Line == 250001){
print FORMAT "2.0\n";
}
else{
$Line = $Line / 250000;
print FORMAT "$Line\n";
}
}

close (LENGTH);
close (FORMAT);
}
