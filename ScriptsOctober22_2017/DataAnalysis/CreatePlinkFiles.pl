$Chromosome = $ARGV[0];

$File = "../../Data/Plink/Plink".$Chromosome.".tped";
open (TPED,">$File") or die "NO!";

$SitesFile = "/mnt/gluster/data/external_private_supp/uk10k/_EGAZ00001017893_".$Chromosome.".UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.legend.gz";
$LineNumber = 0;
@SitesList = ();
@SNPInformation = ();
open (SITES,"zcat $SitesFile |") or die "NO!";
while(<SITES>){
chomp;
if ($LineNumber > 0){
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ( (length($SplitLine[2]) == 1) && ( length($SplitLine[3]) == 1) ){
push(@SitesList,$LineNumber-1);
$SiteIdentifier=$Chromosome.".".$SplitLine[1];
$SiteInfo = "$Chromosome\t$SiteIdentifier\t0\t$SplitLine[1]";
push(@SNPInformation,$SiteInfo);
}
}
$LineNumber++;
}
close(SITES);

$SiteNumber = scalar(@SitesList);
print "Number of sites = $SiteNumber\n";

$HapFile = "/mnt/gluster/data/external_private_supp/uk10k/_EGAZ00001017893_".$Chromosome.".UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.hap.gz";
$SiteCounter = 0;
$LineNumber = 0; 
open (HAP,"zcat $HapFile |" ) or die "NO!";

while (<HAP>){
chomp;
if ($LineNumber == $SitesList[$SiteCounter]){

if ($SiteCounter % 10000 == 0){
print "$LineNumber\n";
}
$Line = $_;
@SplitLine = split(/\s+/,$Line);
print TPED "$SNPInformation[$SiteCounter]\t$Line\n";
$SiteCounter++;
}
$LineNumber++;
}

close(HAP);
# die "NO!";
