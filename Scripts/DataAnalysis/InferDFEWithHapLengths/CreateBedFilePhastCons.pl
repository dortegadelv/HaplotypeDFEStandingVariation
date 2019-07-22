open (PHAST,"../../../Data/UCSCGenes_BStatistic/PhastCons100WayVertebrates.txt") or die "NO";
open (BEDPHAST,">../../../Data/UCSCGenes_BStatistic/PhastCons100WayVertebratesBedFile_chr1.txt") or die "NO";
$LineNumber = 0;
$CurrentChromosome = "chr1";

while (<PHAST>){
chomp;
if ($LineNumber > 0){
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ($SplitLine[1] eq "chr6_apd_hap1"){
last;
}
if ($CurrentChromosome ne $SplitLine[1]){
close (BEDPHAST);
print "$CurrentChromosome\n";
$File = "../../../Data/UCSCGenes_BStatistic/PhastCons100WayVertebratesBedFile_".$SplitLine[1].".txt";
open (BEDPHAST,">$File") or die "NO!";
$CurrentChromosome = $SplitLine[1];
}

print BEDPHAST "$SplitLine[1]\t$SplitLine[2]\t$SplitLine[3]\n";
}
$LineNumber++;
}
close (PHAST);
close (BEDPHAST);

