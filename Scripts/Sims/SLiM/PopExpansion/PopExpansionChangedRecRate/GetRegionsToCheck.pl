open (CENT,"annotations/CentromereTelomere.txt") or die "NO\n";
open (REGIONS,">RegionsToPrint.txt" ) or die "NO!\n";

%CentromeresBoundaries = ();
%TelomeresBoundaries = ();
%CentromeresBoundariesEnd = ();

while (<CENT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
if ($SplitLine[7] eq "centromere"){
$CentromeresBoundaries{$SplitLine[1]} = $SplitLine[2];
$CentromeresBoundariesEnd{$SplitLine[1]} = $SplitLine[3];
}
if ($SplitLine[7] eq "telomere"){
$TelomeresBoundaries{$SplitLine[1]} = $SplitLine[2];
}
}

close (CENT);

open (BOUND,"zcat annotations/hg19.recomb.boundaries.txt.gz | " ) or die "NO!";

while (<BOUND>){
chomp;
$Line = $_;
print "$Line\n";
@SplitLine = split (/\s+/, $Line);
$Begin = $SplitLine[1];
$Chromosome = $SplitLine[0];

$End = $Begin + 20000000;

while ( $End <= $CentromeresBoundaries{$Chromosome} ){

@SplitChr = split(/r/,$Chromosome);
$CurChr = $SplitChr[1];

print REGIONS "Before\t$Chromosome\t$Begin\t$End\n";
$Begin = $End + 1;
$End = $End + 20000000;

}

$Begin = $CentromeresBoundariesEnd{$Chromosome};

$End = $Begin + 20000000;

while ( $End <= $TelomeresBoundaries{$Chromosome} ){

@SplitChr = split(/r/,$Chromosome);
$CurChr = $SplitChr[1];

print REGIONS "After\t$Chromosome\t$Begin\t$End\n";
$Begin = $End + 1;
$End = $End + 20000000;

}

}
close (BOUND);

