open (GENES,"../../../Data/UCSCGenes_BStatistic/GenesExonsFromUCSCBrowser.txt") or die "NO";
open (BEDFILE,">../../../Data/UCSCGenes_BStatistic/ExonsBedFile.txt") or die "NO";
$LineNumber = 0;
while (<GENES>){
chomp;
$Line = $_;
if ($LineNumber > 0){
@SplitLine = split(/\s+/, $Line);
@ExonStart = split(/,/,$SplitLine[8]);
@ExonEnds = split(/,/,$SplitLine[9]);
for ($i = 0; $i < scalar(@ExonStart); $i++){
print BEDFILE "$SplitLine[1]\t$ExonStart[$i]\t$ExonEnds[$i]\n";
}
}
$LineNumber++;
}

close (GENES);
close (BEDFILE);
