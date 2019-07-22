open (MAP,"../../../Data/LeftBpRecRatePerVariantSynonymousPrintMap.txt") or die "NO\n";

open (VARNUM, "../../../Data/Plink/CpGSynOnePercentNumberPositions.frq") or die "NO!\n";

@VarNum = ();

while (<VARNUM>){
chomp;
$Line = $_;
push (@VarNum, $Line);
}
close (VARNUM);

open (MAPNOCPG,">../../../Data/LeftBpRecRatePerVariantNoCpGSynonymousPrintMap.txt") or die "NO\n";
@RecRate = ();

$PrintSNPFlag = 0;
$SNPCount = -1;
$CurrentSNP = "";
while (<MAP>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/, $Line);
$FirstSNP = $SplitLine[0].".".$SplitLine[1];
if ($FirstSNP ne $CurrentSNP){
$SNPCount++;
$CurrentSNP = $FirstSNP;
$PrintSNPFlag = 0;
foreach $NumToCheck (@VarNum){
if ($NumToCheck eq $SNPCount){
$PrintSNPFlag = 1;
}
}
}
if ($PrintSNPFlag == 1){
print MAPNOCPG "$Line\n";
}
}

close (MAP);

close (MAPNOCPG);

open (MAP,"../../../Data/RightBpRecRatePerVariantSynonymousPrintMap.txt") or die "NO\n";
open (VARNUM, "../../../Data/Plink/CpGSynOnePercentNumberPositions.frq") or die "NO!\n";

@VarNum = ();

while (<VARNUM>){
chomp;
$Line = $_;
push (@VarNum, $Line);
}
close (VARNUM);


open (MAPNOCPG,">../../../Data/RightBpRecRatePerVariantNoCpGSynonymousPrintMap.txt") or die "NO\n";

@RecRate = ();

$PrintSNPFlag = 0;
$SNPCount = -1;
$CurrentSNP = "";
while (<MAP>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/, $Line);
$FirstSNP = $SplitLine[0].".".$SplitLine[1];
if ($FirstSNP ne $CurrentSNP){
$SNPCount++;
$CurrentSNP = $FirstSNP;
$PrintSNPFlag = 0;
foreach $NumToCheck (@VarNum){
if ($NumToCheck eq $SNPCount){
$PrintSNPFlag = 1;
}
}
}
if ($PrintSNPFlag == 1){
print MAPNOCPG "$Line\n";
}
}

close (MAP);

close (MAPNOCPG);


