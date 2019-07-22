for ($i = 1; $i <= 22; $i++){

$File = "../../../Data/UCSCGenes_BStatistic/bkgd/chr".$i.".bkgd";
open (BS,$File) or die "NO!";
$ExitFile = "../../../Data/UCSCGenes_BStatistic/bkgd/chrBed".$i.".bkgd";
open (BSEXIT,">$ExitFile") or die "NO!";
$StartPosition = 0;
while (<BS>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/, $Line);
$EndPosition = $StartPosition + $SplitLine[1];
print BSEXIT "chr$i\t$StartPosition\t$EndPosition\t$SplitLine[0]\n";
$StartPosition = $StartPosition + $SplitLine[1];
}
close (BS);
}


