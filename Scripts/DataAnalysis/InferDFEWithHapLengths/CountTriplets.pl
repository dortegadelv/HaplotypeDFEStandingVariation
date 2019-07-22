open (EXONS,"../../../Data/UCSCGenes_BStatistic/ExonsBedUniqueFile.txt") or die "NO!";

$Triplet = 0;
$NonTriplet = 0;

while (<EXONS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
$Difference = $SplitLine[2] - $SplitLine[1];
if ($Difference % 3 != 0){
$NonTriplet++;
}else{
$Triplet++;
}

}
close (EXONS);

print "Triplet = $Triplet Non triplet = $NonTriplet\n";
