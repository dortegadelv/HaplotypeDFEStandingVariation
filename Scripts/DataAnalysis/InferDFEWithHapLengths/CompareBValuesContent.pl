@SynNumbers = ();

$SynNumberFile = "../../../Data/VariantNumberToIncludeSynonymous.txt";
open (SYNN,$SynNumberFile) or die "NO!";
while(<SYNN>){
chomp;
$Line = $_;
push (@SynNumbers,$Line );
}

close(SYNN);

@MisNumbers = ();

$SynNumberFile = "../../../Data/VariantNumberToInclude.txt";
open (SYNN,$SynNumberFile) or die "NO!";
while(<SYNN>){
chomp;
$Line = $_;
push (@MisNumbers,$Line);
}

close(SYNN);

open (SYNPOS,"../../../Data/Plink/AllSynonymousOnePercent.frq") or die "NO!";
@SynChromosome = ();
@SynPosition = ();
while (<SYNPOS>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
@ImportantStuff = split (/\./,$SplitLine[2]);
push (@SynChromosome,$ImportantStuff[0]);
push (@SynPosition,$ImportantStuff[1] - 1);

}

close (SYNPOS);

open (MISPOS,"../../../Data/Plink/AllMissenseOnePercent.frq") or die "NO!";
@MisChromosome = ();
@MisPosition = ();
while (<MISPOS>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
@ImportantStuff = split (/\./,$SplitLine[2]);
push (@MisChromosome,$ImportantStuff[0]);
push (@MisPosition,$ImportantStuff[1] - 1);
}

close (MISPOS);

## Synonymous variants
open (PROP,">../../../Data/UCSCGenes_BStatistic/B_StatisticSyn.txt") or die "NO!";
foreach $i (@SynNumbers){
print "$SynChromosome[$i]\t$SynPosition[$i]\n";
$MinusPosition = $SynPosition[$i] - 250000;
$PlusPosition = $SynPosition[$i] + 250000;


$B_StatisticFile = "../../../Data/UCSCGenes_BStatistic/bkgd/bkgd/chrBed".$SynChromosome[$i]."Hg19Sorted.bed";
open (BFILE, $B_StatisticFile ) or die "NO!\n";
$FlagTakeB = 0;
$SumBValue = 0;
$TotalPositionNumber = 0;
while (<BFILE>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/, $Line);
if (($MinusPosition <= $SplitLine[2]) && ($MinusPosition >= $SplitLine[1] )){
$FlagTakeB = 1;
$SumBValue = $SumBValue + ($SplitLine[2] - $MinusPosition) * $SplitLine[3];
$TotalPositionNumber = $TotalPositionNumber + ($SplitLine[2] - $MinusPosition);
} elsif (($PlusPosition <= $SplitLine[2]) && ($PlusPosition >= $SplitLine[1] )){
$SumBValue = $SumBValue + ($PlusPosition - $SplitLine[1]) * $SplitLine[3];
$FlagTakeB = 0;
$TotalPositionNumber = $TotalPositionNumber + ($PlusPosition - $SplitLine[1]);
}elsif (($PlusPosition >= $SplitLine[2]) && ($MinusPosition <= $SplitLine[1] )){
$SumBValue = $SumBValue + ($SplitLine[2] - $SplitLine[1]) * $SplitLine[3];
$TotalPositionNumber = $TotalPositionNumber + ($SplitLine[2] - $SplitLine[1]);
# print "Here?\n";
}


}
close (BFILE);

$AverageBValue = $SumBValue / $TotalPositionNumber;
print PROP "$SynChromosome[$i]\t$SynPosition[$i]\t$AverageBValue\t$TotalPositionNumber\n";

}
close (PROP);

## Nonsynonymous variants
open (PROP,">../../../Data/UCSCGenes_BStatistic/B_StatisticMis.txt") or die "NO!";
foreach $i (@MisNumbers){
print "$MisChromosome[$i]\t$MisPosition[$i]\n";
$MinusPosition = $MisPosition[$i] - 250000;
$PlusPosition = $MisPosition[$i] + 250000;


$B_StatisticFile = "../../../Data/UCSCGenes_BStatistic/bkgd/bkgd/chrBed".$MisChromosome[$i]."Hg19Sorted.bed";
open (BFILE, $B_StatisticFile ) or die "NO!\n";
$FlagTakeB = 0;
$SumBValue = 0;
$TotalPositionNumber = 0;
while (<BFILE>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/, $Line);
if (($MinusPosition <= $SplitLine[2]) && ($MinusPosition >= $SplitLine[1] )){
$FlagTakeB = 1;
$SumBValue = $SumBValue + ($SplitLine[2] - $MinusPosition) * $SplitLine[3];
$TotalPositionNumber = $TotalPositionNumber + ($SplitLine[2] - $MinusPosition);
} elsif (($PlusPosition <= $SplitLine[2]) && ($PlusPosition >= $SplitLine[1] )){
$SumBValue = $SumBValue + ($PlusPosition - $SplitLine[1]) * $SplitLine[3];
$FlagTakeB = 0;
$TotalPositionNumber = $TotalPositionNumber + ($PlusPosition - $SplitLine[1]);
}elsif (($PlusPosition >= $SplitLine[2]) && ($MinusPosition <= $SplitLine[1] )){
$SumBValue = $SumBValue + ($SplitLine[2] - $SplitLine[1]) * $SplitLine[3];
$TotalPositionNumber = $TotalPositionNumber + ($SplitLine[2] - $SplitLine[1]);
}


}
close (BFILE);

$AverageBValue = $SumBValue / $TotalPositionNumber;
print PROP "$MisChromosome[$i]\t$MisPosition[$i]\t$AverageBValue\t$TotalPositionNumber\n";

}
close (PROP);


