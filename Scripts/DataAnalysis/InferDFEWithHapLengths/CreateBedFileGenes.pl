open (GENES,"../../../Data/UCSCGenes_BStatistic/GenesExonsFromUCSCBrowser.txt") or die "NO";

while (<GENES>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);

}
close (GENES);
