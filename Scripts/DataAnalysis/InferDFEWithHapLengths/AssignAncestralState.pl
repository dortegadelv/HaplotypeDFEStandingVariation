$i = $ARGV[0];
print "Chromosome $i\n";

$File = "../../../Data/Plink/PlinkFrequencyAnnotation".$i.".frq";
$ExitFile = "../../../Data/Plink/PlinkFrequencyAnnotationAncestralAllele".$i.".frq";
open (FILE,$File) or die "NO! $File\n";
open (EXIT,">$ExitFile") or die "NO! $ExitFile";
$LineNumber = 0;
while (<FILE>){
chomp;

if ($LineNumber % 1000 == 0){
print "$LineNumber\n";
}
if ($LineNumber == 0){
$Line = $_;
print EXIT "$Line\tAncestralAllele\tReferenceAllele\n";
}else{
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$AncestralAllele="N";
$ReferenceAllele="N";
if ( ( $Line =~ /miss/ ) || ( $Line =~ /syno/ ) ) {
# print "$Line\n";
@Position = split(/\./,$SplitLine[2]);
$CurrentPos = $Position[1];
print "CurPos = $CurrentPos\n";
$LineToSearch="tabix ../../../Data/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf.gz $i:$CurrentPos-$CurrentPos";
$TabixLine = `$LineToSearch`;
@LinesOfTabix = split(/\n/,$TabixLine);
for $MiniLine (@LinesOfTabix){
@CurrentSplit = split(/\s+/,$MiniLine);
print "$CurrentPos\t$CurrentSplit[1]\t$CurrentSplit[3]\t$CurrentSplit[4]\n";

if ($CurrentSplit[1] eq $CurrentPos && length($CurrentSplit[3]) == 1 && $MiniLine =~ /VT=SNP/){
$MiniLine =~ /AA=(.)/;
@TabixLineParts = split(/\s+/,$MiniLine);
if ($TabixLineParts[1] ne $CurrentPos){
die "NO! $TabixLineParts[1] $CurrentPos TL=$TabixLine\n";
}
# die "NO!";
# die "NO!\n";
$ReferenceAllele = $TabixLineParts[3];
$AncestralAllele=$1;
if ($AncestralAllele eq ""){
$AncestralAllele=".";
}
}
}
# print "$LineToSearch\n";
# print "$TabixLine\n";
# print "Ancestral Allele = $AncestralAllele\n";
#die "NO!";
}
print EXIT "$Line\t$AncestralAllele\t$ReferenceAllele\n";
}

$LineNumber++;
}
close(EXIT);
close(FILE);
