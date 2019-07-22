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

open (PROP,">../../../Data/UCSCGenes_BStatistic/ProportionMis.txt") or die "NO!";
foreach $i (@MisNumbers){
print "$MisChromosome[$i]\t$MisPosition[$i]\n";
$MinusPosition = $MisPosition[$i] - 250000;
$PlusPosition = $MisPosition[$i] + 250000;
open (BEDFILE,">../../../Results/Data/BedFilePositionMis.bed") or die "NO!";
print BEDFILE "chr$MisChromosome[$i]\t$MinusPosition\t$PlusPosition\n";
close (BEDFILE);
$PhastConsFile = "../../../Data/UCSCGenes_BStatistic/PhastCons100WayVertebratesBedFileUnique_chr".$MisChromosome[$i].".txt";
system ("bedtools intersect -a ../../../Results/Data/BedFilePositionMis.bed -b ../../../Data/UCSCGenes_BStatistic/ExonsBedUniqueFile.txt > ../../../Data/UCSCGenes_BStatistic/FuncionalPositionsMis.txt");
system ("bedtools intersect -a ../../../Results/Data/BedFilePositionMis.bed -b $PhastConsFile > ../../../Data/UCSCGenes_BStatistic/FuncionalPositionsPhastConsMis.txt");
system ("cat ../../../Data/UCSCGenes_BStatistic/FuncionalPositionsMis.txt ../../../Data/UCSCGenes_BStatistic/FuncionalPositionsPhastConsMis.txt > ../../../Data/UCSCGenes_BStatistic/MergedPhastConsPosFilesMis.txt");
system ("sort -k1,1 -k2,2n ../../../Data/UCSCGenes_BStatistic/MergedPhastConsPosFilesMis.txt > ../../../Data/UCSCGenes_BStatistic/SortedPhastConsPosFilesMis.txt");
system ("bedtools merge -i ../../../Data/UCSCGenes_BStatistic/SortedPhastConsPosFilesMis.txt > ../../../Data/UCSCGenes_BStatistic/FuncionalPositionsPhastConsExonsMis.txt");
# system ("bedtools intersect -a ../../../Data/UCSCGenes_BStatistic/FuncionalPositionsPhastConsSyn.txt -b ../../../Data/UCSCGenes_BStatistic/FuncionalPositionsSyn.txt > ../../../Data/UCSCGenes_BStatistic/FuncionalPositionsPhastConsExons.txt");

$ProportionExons = 0;
open (EXONS,"../../../Data/UCSCGenes_BStatistic/FuncionalPositionsMis.txt") or die "NO";
while (<EXONS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$ProportionExons = $ProportionExons + ($SplitLine[2] - $SplitLine[1]);
}
print "Exon proportion = $ProportionExons\n";

$ProportionPhastCons = 0;
open (EXONS,"../../../Data/UCSCGenes_BStatistic/FuncionalPositionsPhastConsMis.txt") or die "NO";
while (<EXONS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$ProportionPhastCons = $ProportionPhastCons + ($SplitLine[2] - $SplitLine[1]);
}
print "PhastCons proportion = $ProportionPhastCons\n";

$ProportionPhastConsExons = 0;
open (EXONS,"../../../Data/UCSCGenes_BStatistic/FuncionalPositionsPhastConsExonsMis.txt") or die "NO";
while (<EXONS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$ProportionPhastConsExons = $ProportionPhastConsExons + ($SplitLine[2] - $SplitLine[1]);
}
print "PhastCons exons proportion = $ProportionPhastConsExons\n";
print PROP "$ProportionExons\t$ProportionPhastCons\t$ProportionPhastConsExons\n";

}
close (PROP);



