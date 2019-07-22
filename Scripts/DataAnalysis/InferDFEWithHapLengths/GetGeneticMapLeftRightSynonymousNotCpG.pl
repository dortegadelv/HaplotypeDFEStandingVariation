open (MAP,"../../../Data/LeftBpRecRatePerVariantSynonymous.txt") or die "NO\n";
open (MAPNOCPG,">../../../Data/LeftBpRecRatePerVariantNoCpGSynonymous.txt") or die "NO\n";
@RecRate = ();

while (<MAP>){
chomp;
$Line = $_;
push (@RecRate, $Line);
}

close (MAP);

open (VARNUM, "../../../Data/Plink/CpGSynOnePercentNumberPositions.frq") or die "NO!\n";

@VarNum = ();

while (<VARNUM>){
chomp;
$Line = $_;
push (@VarNum, $Line);
}
close (VARNUM);

foreach $i (@VarNum){
print MAPNOCPG "$RecRate[$i]\n";
}

close (MAPNOCPG);

open (MAP,"../../../Data/RightBpRecRatePerVariantSynonymous.txt") or die "NO\n";
open (MAPNOCPG,">../../../Data/RightBpRecRatePerVariantNoCpGSynonymous.txt") or die "NO\n";
@RecRate = ();

while (<MAP>){
chomp;
$Line = $_;
push (@RecRate, $Line);
}

close (MAP);

open (VARNUM, "../../../Data/Plink/CpGSynOnePercentNumberPositions.frq") or die "NO!\n";

@VarNum = ();

while (<VARNUM>){
chomp;
$Line = $_;
push (@VarNum, $Line);
}
close (VARNUM);

foreach $i (@VarNum){
print MAPNOCPG "$RecRate[$i]\n";
}

close (MAPNOCPG);

