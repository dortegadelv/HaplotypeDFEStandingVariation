### Nelson

open (SFS,"../../Programs/fastNeutrino_v1.0/examples/sfsNelsonEtAl.txt") or die "NO!";

@NumberOfSegSites = ();
$LineNumber = 0;
for ($i = 0; $i < 184; $i++){
push (@NumberOfSegSites,0);
}

while(<SFS>){
chomp;
$Line = $_;
if ($LineNumber > 1){
@SplitLine = split(/\s+/,$Line);
for ($i = 0; $i < 184; $i++){
$NumberOfSegSites[$i] = $NumberOfSegSites[$i] + $SplitLine[$i];
}
}
$LineNumber++;
}

close(SFS);
$TotalSegSites = 0;
for ($i = 0; $i < 184; $i++){
print "Gene $i = $NumberOfSegSites[$i]\n";
$TotalSegSites = $TotalSegSites + $NumberOfSegSites[$i];
}
print "Total number of sites = $TotalSegSites\n";

## All genes

open (SFS,"../../Data/fastNeutrinoExitFile.txt") or die "NO!";

@NumberOfSegSites = ();
$LineNumber = 0;
for ($i = 0; $i < 16095; $i++){
push (@NumberOfSegSites,0);
}

while(<SFS>){
chomp;
$Line = $_;
if ($LineNumber > 1){
@SplitLine = split(/\s+/,$Line);
for ($i = 0; $i < 16095; $i++){
$NumberOfSegSites[$i] = $NumberOfSegSites[$i] + $SplitLine[$i];
}
}
$LineNumber++;
}

close(SFS);
$TotalSegSites = 0;
for ($i = 0; $i < 16095; $i++){
print "Gene $i = $NumberOfSegSites[$i]\n";
$TotalSegSites = $TotalSegSites + $NumberOfSegSites[$i];
}
print "Total number of sites = $TotalSegSites\n";

