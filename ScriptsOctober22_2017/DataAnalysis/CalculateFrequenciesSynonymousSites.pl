$Chromosome = $ARGV[0];

### Get Sites
$SitesFile = "../../Data/UK10K_COHORTChr".$Chromosome.".20160215.sites";
@SitesNumber = ();
open (SITES,$SitesFile) or die "NO!";
$LineNumber = 0;
while (<SITES>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ($SplitLine[0] eq "synonymous"){
push(@SitesNumber,$LineNumber-1);
}
$LineNumber++;
}

close(SITES);

## Get Individuals

$IndividualsFile = "../../Data/SampleAncestry.txt";
@IndividualsNumber = ();

open (IND,$IndividualsFile) or die "NO!";
$LineNumber = 0;
while (<IND>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

if ($SplitLine[1] eq "GBR"){
push(@IndividualsNumber,$LineNumber-1);
}
$LineNumber++;
}

close(IND);

$NumberOfSites = scalar(@SitesNumber);
$NumberOfIndividuals = scalar(@IndividualsNumber);
print "Number of sites = $NumberOfSites\n";
print "Number of individuals = $NumberOfIndividuals\n";

## Open Hap file

$HaplotypesFile = "/mnt/gluster/data/external_private_supp/uk10k/_EGAZ00001017893_".$Chromosome.".UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.hap.gz";
open (HAP,"zcat $HaplotypesFile |") or die "NO!";
$FrequencyFile = "../../Data/FrequencySynonymousChr".$Chromosome.".txt";
open (FREQ,">$FrequencyFile") or die "NO";
$LineNumber = 0;
$SitesCounter = 0;
while (<HAP>){
chomp;
if ($LineNumber == $SitesNumber[$SitesCounter]){
print "Site = $SitesCounter $LineNumber\n";
$Line = $_;
# print "$Line\n";
# die "NO!\n";
@SplitLine = split(/\s+/,$Line);
$Sum = 0;
for ($i = 0; $i < @IndividualsNumber; $i++){
$Sum = $Sum + $SplitLine[$IndividualsNumber[$i]*2];
$Sum = $Sum + $SplitLine[$IndividualsNumber[$i]*2 + 1];
}
print FREQ "$Sum\n";
$SitesCounter++;
}
$LineNumber++;
}

close(HAP);



