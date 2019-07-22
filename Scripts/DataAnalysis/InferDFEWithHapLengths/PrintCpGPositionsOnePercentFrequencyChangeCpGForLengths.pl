open (CPG,"../../../Data/Plink/SynonymousOnePercentCpG.frq") or die "NO!\n";

@UsedSites = ();
while (<CPG>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
push(@UsedSites,$SplitLine[2]);
}

close (CPG);

$VarFile = "../../../Data/VariantNumberToIncludeSynonymous.txt";
open (VAR,$VarFile) or die "NO\n";
@VarInclude = ();
while (<VAR>){
chomp;
$Line = $_;
push(@VarInclude, $Line);
}
close (VAR);

open (ALL,"../../../Data/Plink/AllSynonymousOnePercent.frq") or die "NO!\n";
@SynOnePercent = ();
while (<ALL>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
push(@SynOnePercent,$SplitLine[2]);
}
close (ALL);
open (POSEXIT,">../../../Data/Plink/CpGSynOnePercentNumberPositionsVar.txt") or die "NO\n";

for ($i = 0; $i < scalar(@VarInclude); $i++){
for ($j = 0; $j < scalar(@UsedSites);$j++){
if ($UsedSites[$j] eq $SynOnePercent[$i]){
print POSEXIT "$j\n";
}
}
}

close (POSEXIT);


open (CPG,"../../../Data/Plink/MissenseOnePercentCpG.frq") or die "NO!\n";

@UsedSites = ();
while (<CPG>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
push(@UsedSites,$SplitLine[2]);
}

close (CPG);

$VarFile = "../../../Data/VariantNumberToInclude.txt";
open (VAR,$VarFile) or die "NO\n";
@VarInclude = ();
while (<VAR>){
chomp;
$Line = $_;
push(@VarInclude, $Line);
}
close (VAR);

open (ALL,"../../../Data/Plink/AllMissenseOnePercent.frq") or die "NO!\n";
@SynOnePercent = ();
while (<ALL>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
push(@SynOnePercent,$SplitLine[2]);
}
close (ALL);
open (POSEXIT,">../../../Data/Plink/CpGMisOnePercentNumberPositionsVar.txt") or die "NO\n";

for ($i = 0; $i < scalar(@VarInclude); $i++){
for ($j = 0; $j < scalar(@UsedSites);$j++){
if ($UsedSites[$j] eq $SynOnePercent[$i]){
print POSEXIT "$j\n";
}
}
}

close (POSEXIT);


