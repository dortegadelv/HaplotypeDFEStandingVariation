$SampleFile = "/mnt/gluster/data/external_private_supp/uk10k/_EGAZ00001017893_22.UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.sample";
open (TFAM,">../../Data/Plink/PlinkAll.tfam") or die "NO!";
open (SAMPLE,$SampleFile) or die "NO!";
while (<SAMPLE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
print TFAM "$SplitLine[0]\t$SplitLine[0]\t0\t0\t0\t1\n";
}
close (TFAM);
close (SAMPLE);
