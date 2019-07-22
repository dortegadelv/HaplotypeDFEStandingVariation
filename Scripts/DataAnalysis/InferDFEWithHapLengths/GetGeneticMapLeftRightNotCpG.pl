open (MAP,"../../../Data/LeftBpRecRatePerVariant.txt") or die "NO\n";
open (MAPNOCPG,">../../../Data/LeftBpRecRatePerVariantNoCpG.txt") or die "NO\n";
@RecRate = ();

while (<MAP>){
chomp;
$Line = $_;
push (@RecRate, $Line);
}

close (MAP);

open (VARNUM, "../../../Data/Plink/CpGMisOnePercentNumberPositions.frq") or die "NO!\n";

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

open (MAP,"../../../Data/RightBpRecRatePerVariant.txt") or die "NO\n";
open (MAPNOCPG,">../../../Data/RightBpRecRatePerVariantNoCpG.txt") or die "NO\n";
@RecRate = ();

while (<MAP>){
chomp;
$Line = $_;
push (@RecRate, $Line);
}

close (MAP);

open (VARNUM, "../../../Data/Plink/CpGMisOnePercentNumberPositions.frq") or die "NO!\n";

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

