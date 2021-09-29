open (VAR,"../../../../Data/Plink/CpGSynOnePercentNumberPositionsVar.txt") or die "NO";

@Vars = ();
while (<VAR>){
chomp;
$Line = $_;
push (@Vars,$Line);
}

close (VAR);

@HapLength = ();
for ($j = 0 ; $j < 6 ; $j++ ){
push (@HapLength,0);
}

$TotalVars = 0 ;

open (LD, ">LDistributionOnePercentSynSites_NotCpG.txt" ) or die "NO!";

for ($i =0; $i < scalar(@Vars); $i++){

print "Vars = $Vars[$i]\n";

$File = "../../../../Data/Plink/HapLengths/HapLengthSynonymousNotCpG".$Vars[$i].".txt";

open (FILE,$File) or die "NO";

while (<FILE>){
chomp;
$Line = $_;
$Fraction = int ( $Line / 50000 );
$HapLength[$Fraction]++;
$TotalVars++;
}
close (FILE);
}

$Fraction = $HapLength[0] / $TotalVars;
print LD "$Fraction";

for ($j = 1 ; $j < 6 ; $j++ ){
$Fraction = $HapLength[$j] / $TotalVars;
print LD "\t$Fraction";
}
print LD "\n";
close (LD);
###############

open (VAR,"../../../../Data/Plink/CpGMisOnePercentNumberPositionsVar.txt") or die "NO";

@Vars = ();
while (<VAR>){
chomp;
$Line = $_;
push (@Vars,$Line);
}

close (VAR);

@HapLength = ();
for ($j = 0 ; $j < 6 ; $j++ ){
push (@HapLength,0);
}

$TotalVars = 0 ;

open (LD, ">LDistributionOnePercentMisSites_NotCpG.txt" ) or die "NO!";

for ($i =0; $i < scalar(@Vars); $i++){

print "Vars = $Vars[$i]\n";

$File = "../../../../Data/Plink/HapLengths/HapLengthOnlyCpG".$Vars[$i].".txt";

open (FILE,$File) or die "NO";

while (<FILE>){
chomp;
$Line = $_;
$Fraction = int ( $Line / 50000 );
$HapLength[$Fraction]++;
$TotalVars++;
}
close (FILE);
}

$Fraction = $HapLength[0] / $TotalVars;
print LD "$Fraction";

for ($j = 1 ; $j < 6 ; $j++ ){
$Fraction = $HapLength[$j] / $TotalVars;
print LD "\t$Fraction";
}
print LD "\n";
close (LD);

