$File = "../../../Data/GenesInMaskVCFTabixReadyBed.bed";

open (FILE,$File) or die "NO!";
$SumBases = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line );
$SumBases = $SumBases + ($SplitLine[2] - $SplitLine[1] - 1);
}
print "Sum bases = $SumBases\n";
close (FILE);
