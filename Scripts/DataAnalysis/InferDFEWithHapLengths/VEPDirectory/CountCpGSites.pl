$ChromosomeToCheck = $ARGV[0];
@Positions = ();
@Chromosomes = ();
$TotalNumberOfBases = 0;
$TotalCpGSiteNumber = 0;
# for ($i = $ChromosomeToCheck; $i <= $ChromosomeToCheck; $i++){
$File = "../../../Data/UCSCGenes_BStatistic/ExonsBedUniqueFileFarCentrTelom.txt";

open (FILE,$File) or die "NO!\n";
$LineNumber = 0;
while (<FILE>){
chomp;

if ($LineNumber == 0){
$LineNumber++;
next;
}
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if (length($SplitLine[0]) <= 5){
$SplitLine[0] =~ /chr(\d+)/;
$CurrentChromosome = $1;
if ($CurrentChromosome eq $ChromosomeToCheck){
# $TotalNumberOfBases++;
for ($Position = $SplitLine[1]; $Position < $SplitLine[2]; $Position++){
$TotalNumberOfBases++;
push (@Positions, $Position);
push (@Chromosomes, $CurrentChromosome);
}
}
}
# print "$MiniStuff[0]\t$MiniStuff[1]\n";
# die "NO!\n";
}

close (FILE);
# }

%PossibleVariants = ();
$PossibleVariants{'A'}{0} = 'C';
$PossibleVariants{'A'}{1} = 'G';
$PossibleVariants{'A'}{2} = 'T';
$PossibleVariants{'C'}{0} = 'A';
$PossibleVariants{'C'}{1} = 'G';
$PossibleVariants{'C'}{2} = 'T';
$PossibleVariants{'G'}{0} = 'A';
$PossibleVariants{'G'}{1} = 'C';
$PossibleVariants{'G'}{2} = 'T';
$PossibleVariants{'T'}{0} = 'A';
$PossibleVariants{'T'}{1} = 'C';
$PossibleVariants{'T'}{2} = 'G';



print "Finished reading stuff\n";
open (EXITLIST, ">../../../Data/Plink/CpGSiteList".$ChromosomeToCheck.".txt") or die "NO!\n";
# die "NO!\n";
open (FILE,"zcat ../../../Data/ReferenceGenomehg19/human_g1k_v37.fasta.gz.1 |") or die "NO\n";
print EXITLIST "##fileformat=VCFv4.0
#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\n";
$StartingPosition = -59;
$CurrentChromosome = 1;
$ThingToCheck = 0;
$NextStuffFlag = 0;
while (<FILE>){
chomp;
$Line = $_;
if ($Line =~ /(\d+) dna:chromosome/){
$CurrentChromosome = $1;
print "Previous chromosome approximate size = $StartingPosition\n";
print "Chromosome = $CurrentChromosome\n";
$StartingPosition = -59;
if ($CurrentChromosome eq $ChromosomeToCheck){
$File = "../../../Data/Plink/CpGSiteNumberSites".$CurrentChromosome.".frq";
open (OUT,">$File") or die "NO!\n";
}
}

if ($NextStuffFlag == 1){
$PostCharacter = substr($Line, 0, 1);
$CpGFlag = 0;
if ( ($PreCharacter59 eq "C") || ( $PostCharacter eq "G" ) ){
$CpGFlag = 1;
}else{
print EXITLIST "$CurrentChromosome\t$Positions[$ThingToCheck]\trs1\t$Character\t$PossibleVariants{$Character}{0}\t.\t.\t.\n";
print EXITLIST "$CurrentChromosome\t$Positions[$ThingToCheck]\trs1\t$Character\t$PossibleVariants{$Character}{1}\t.\t.\t.\n";
print EXITLIST "$CurrentChromosome\t$Positions[$ThingToCheck]\trs1\t$Character\t$PossibleVariants{$Character}{2}\t.\t.\t.\n";
}
$TotalCpGSiteNumber = $TotalCpGSiteNumber + $CpGFlag;
# print OUT "$Positions[$ThingToCheck-1]\t$CpGFlag\n";
$NextStuffFlag = 0;
}
while (($CurrentChromosome eq $Chromosomes[$ThingToCheck ]) && ( ($StartingPosition + 60) > $Positions[$ThingToCheck] )){
$PartToCheck = $Positions[$ThingToCheck] - $StartingPosition ;
$Character = substr($Line,$PartToCheck,1);
if ($PartToCheck == 0){
$PostCharacter = substr($Line, $PartToCheck + 1, 1);
$CpGFlag = 0;
if ( ($PreCharacter eq "C") || ( $PostCharacter eq "G" ) ){
$CpGFlag = 1;
}else{
print EXITLIST "$CurrentChromosome\t$Positions[$ThingToCheck]\trs1\t$Character\t$PossibleVariants{$Character}{0}\t.\t.\t.\n";
print EXITLIST "$CurrentChromosome\t$Positions[$ThingToCheck]\trs1\t$Character\t$PossibleVariants{$Character}{1}\t.\t.\t.\n";
print EXITLIST "$CurrentChromosome\t$Positions[$ThingToCheck]\trs1\t$Character\t$PossibleVariants{$Character}{2}\t.\t.\t.\n";
}
$TotalCpGSiteNumber = $TotalCpGSiteNumber + $CpGFlag;
# print OUT "$Positions[$ThingToCheck]\t$CpGFlag\n";
}elsif ($PartToCheck == 59){
$CpGFlag = 0;
$PreCharacter59 = substr($Line,$PartToCheck - 1,1);
$NextStuffFlag = 1;
}else {
$CpGFlag = 0;
$PreCharacter = substr($Line,$PartToCheck - 1,1);
$PostCharacter = substr($Line, $PartToCheck + 1, 1);
if ( ($PreCharacter eq "C") || ( $PostCharacter eq "G" ) ){
$CpGFlag = 1;
}else{
print EXITLIST "$CurrentChromosome\t$Positions[$ThingToCheck]\trs1\t$Character\t$PossibleVariants{$Character}{0}\t.\t.\t.\n";
print EXITLIST "$CurrentChromosome\t$Positions[$ThingToCheck]\trs1\t$Character\t$PossibleVariants{$Character}{1}\t.\t.\t.\n";
print EXITLIST "$CurrentChromosome\t$Positions[$ThingToCheck]\trs1\t$Character\t$PossibleVariants{$Character}{2}\t.\t.\t.\n";
}
$TotalCpGSiteNumber = $TotalCpGSiteNumber + $CpGFlag;
# print OUT "$Positions[$ThingToCheck]\t$CpGFlag\n";
}
$ThingToCheck++;
}

$PreCharacter = substr($Line, 59, 1);
$StartingPosition = $StartingPosition + 60;
}
close (FILE);
close (EXITLIST);
$NonCpGSiteNumber = $TotalNumberOfBases - $TotalCpGSiteNumber;
print OUT "Total_site_number\t$TotalNumberOfBases\tTotal_CpG_site_number\t$TotalCpGSiteNumber\tNonCpG_site_number\t$NonCpGSiteNumber\n";

