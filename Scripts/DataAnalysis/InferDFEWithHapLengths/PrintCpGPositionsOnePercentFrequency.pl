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
open (POSEXIT,">../../../Data/Plink/CpGSynOnePercentNumberPositions.frq") or die "NO\n";
foreach $Site (@UsedSites){
for ($i = 0; $i < scalar(@SynOnePercent); $i++){
if ($Site eq $SynOnePercent[$i]){
print POSEXIT "$i\n";
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
open (POSEXIT,">../../../Data/Plink/CpGMisOnePercentNumberPositions.frq") or die "NO\n";
foreach $Site (@UsedSites){
for ($i = 0; $i < scalar(@VarInclude); $i++){
if ($Site eq $SynOnePercent[$i]){
print POSEXIT "$i\n";
}
}
}
close (POSEXIT);




