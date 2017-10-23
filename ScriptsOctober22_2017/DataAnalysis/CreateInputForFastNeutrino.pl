chomp($NumberOfIndividuals=`cat ../../Data/SampleAncestry.txt | grep 'GBR' | wc -l`);
chomp($NumberOfRegions=`cat ../../Data/mergedgencode.v19.annotation.gtf | wc -l`);
open (EXIT,">../../Data/fastNeutrinoExitFile.txt") or die "NO!";

print EXIT "$NumberOfIndividuals $NumberOfRegions\n";

open (REGION,"../../Data/mergedgencode.v19.annotation.gtf") or die "NO!";

@ChromosomeRegion = ();
@StartRegion = ();
@EndRegion = ();

while(<REGION>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@MiniSplit = split(/r/,$SplitLine[0]);
push(@ChromosomeRegion,$MiniSplit[1]);
push(@StartRegion,$SplitLine[1]);
push(@EndRegion,$SplitLine[2]);
# print "$ChromosomeRegion[0]\t$StartRegion[0]\t$EndRegion[0]\n";
}

close(REGION);

$StartCounter = 0;
@SitesIdentity = ();
$SiteNumber = 0;
@SuperMatrix = ();
for ($i = 0; $i < ($NumberOfIndividuals*2); $i++){
for ($j = 0; $j < $NumberOfRegions; $j++){
# $SuperMatrix[$i][$j] = 0;
}
}

for ($i = 1; $i <= 22; $i++){
print "Chromosome = $i\n";
@SitesIdentity = ();
$File = "../../Data/UK10K_COHORTChr".$i.".20160215.sites";

open (FILE,$File) or die "NO!";

while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ($SplitLine[0] eq "synonymous"){
# print "Site Number = $SiteNumber\n";
@SplitOtherStuff = split(/\./,$SplitLine[1]);
for ($j = 0; $j < scalar(@ChromosomeRegion); $j++){
if ( ($ChromosomeRegion[$j] == $i) && ( $SplitOtherStuff[0] >= $StartRegion[$j] ) && ($SplitOtherStuff[0] <= $EndRegion[$j] )){
push(@SitesIdentity,$j);
# print EXIT "$j\n";
last;
}
}
$SiteNumber++;
}
}
close(FILE);
print "Finished with the identity\n";
$CurrentSiteNumber = 0;
$File = "../../Data/FrequencySynonymousChr".$i.".txt";
open (FILE,$File) or die "NO!";
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if (!$SuperMatrix[$SplitLine[0]][$SitesIdentity[$CurrentSiteNumber]]){
$SuperMatrix[$SplitLine[0]][$SitesIdentity[$CurrentSiteNumber]] = 1;
# die "NO!";
}else{
$SuperMatrix[$SplitLine[0]][$SitesIdentity[$CurrentSiteNumber]]++;
}
$CurrentSiteNumber++;
}
close(FILE);
}
# close (EXIT);
for ($i = 0; $i < ($NumberOfIndividuals*2); $i++){
for ($j = 0; $j < $NumberOfRegions; $j++){
if (!$SuperMatrix[$i][$j]){
print EXIT "0\t";
}else{
print EXIT "$SuperMatrix[$i][$j]\t";
}
}
print EXIT "\n";
}
close (EXIT);

