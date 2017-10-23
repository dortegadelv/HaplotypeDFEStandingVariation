open (TELO,"../../../Data/CentromereTelomere.txt") or die "NO!";

@Chromosome = ();
@CentTeloStart = ();
@CentTeloEnd = ();

while (<TELO>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
$Line =~ /chr(\d+)/;
$ChromosomeNumber = $1;
push (@Chromosome,$ChromosomeNumber);
push (@CentTeloStart, $SplitLine[2]);
push (@CentTeloEnd, $SplitLine[3]);
}

close(TELO);

open (FREQ,"../../../Data/Plink/AllSynonymousOnePercent.frq") or die "NO!";
open (NUM,">../../../Data/VariantNumberSynonymous.txt") or die "NO!";
open (INC,">../../../Data/VariantNumberToIncludeSynonymous.txt") or die "NO!";

$VariantNumber = 0;
$LineNumber = 0;
while (<FREQ>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@MiniStuff = split(/\./,$SplitLine[2]);

$Flag = 0;
for ($i = 0; $i < scalar(@Chromosome); $i++){
if ( ( $Chromosome[$i] eq $MiniStuff[0] ) && ( $MiniStuff[1] >= ( $CentTeloStart[$i] - 5000000 ) ) && ( $MiniStuff[1] <= ( $CentTeloEnd[$i] + 5000000 ))){
$Flag = 1;
print "$Chromosome[$i]\t$MiniStuff[0]\t$MiniStuff[1]\t$CentTeloStart[$i]\t$CentTeloEnd[$i]\n";
last;
}
}

if ($Flag == 1){
$VariantNumber++;
print NUM "$LineNumber\n";
print "$Line\n";
}else{
print INC "$LineNumber\n";
}
$LineNumber++;
}

close (FREQ);
close (NUM);
close (INC);
print "Variant number = $VariantNumber\n";
