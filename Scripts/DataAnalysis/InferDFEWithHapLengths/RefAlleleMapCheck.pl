$File = "../../../Data/Plink/AllMissenseOnePercent.frq";

open (FILE,$File) or die "NO!\n";

while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@MiniStuff = split(/\./,$SplitLine[2]);
push (@Positions,$MiniStuff[1]);
push (@Chromosomes, $MiniStuff[0]);
push (@AncestralAllele,$SplitLine[10]);
push (@AlleleZero,$SplitLine[8]);
push (@AlleleOne,$SplitLine[9]);
push (@MinorAllele,$SplitLine[3]);
push (@MajorAllele,$SplitLine[4]);
}

close (FILE);

open (FILE,"zcat ../../../Data/ReferenceGenomehg19/human_g1k_v37.fasta.gz.1 |") or die "NO\n";

$StartingPosition = -59;
$CurrentChromosome = 1;
$ThingToCheck = 0;
while (<FILE>){
chomp;
$Line = $_;
if ($Line =~ /(\d+) dna:chromosome/){
$CurrentChromosome = $1;
print "Previous chromosome approximate size = $StartingPosition\n";
print "Chromosome = $CurrentChromosome\n";
$StartingPosition = -59;
}

while (($CurrentChromosome eq $Chromosomes[$ThingToCheck ]) && ( ($StartingPosition + 60) > $Positions[$ThingToCheck] )){
$PartToCheck = $Positions[$ThingToCheck] - $StartingPosition ;
$Character = substr($Line,$PartToCheck,1);
print "$Positions[$ThingToCheck]\t$StartingPosition\t$PartToCheck\t$AlleleZero[$ThingToCheck]\t$Character\t$AlleleOne[$ThingToCheck]\n";
$ThingToCheck++;

}
$StartingPosition = $StartingPosition + 60;
}
close (FILE);

