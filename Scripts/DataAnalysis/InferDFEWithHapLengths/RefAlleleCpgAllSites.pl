$ChromosomeToCheck = $ARGV[0];

for ($i = $ChromosomeToCheck; $i <= $ChromosomeToCheck; $i++){
$File = "../../../Data/Plink/PlinkReduced".$i.".frq";

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
@MiniStuff = split(/\./,$SplitLine[2]);
push (@Positions,$MiniStuff[1]);
push (@Chromosomes, $MiniStuff[0]);
# print "$MiniStuff[0]\t$MiniStuff[1]\n";
# die "NO!\n";
}

close (FILE);
}

print "Finished reading stuff\n";

open (FILE,"zcat ../../../Data/ReferenceGenomehg19/human_g1k_v37.fasta.gz.1 |") or die "NO\n";

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
$File = "../../../Data/Plink/CpGSites".$CurrentChromosome.".frq";
open (OUT,">$File") or die "NO!\n";
}
}

if ($NextStuffFlag == 1){
$PostCharacter = substr($Line, 0, 1);
$CpGFlag = 0;
if ( ($PreCharacter59 eq "C") || ( $PostCharacter eq "G" ) ){
$CpGFlag = 1;
}
print OUT "$Positions[$ThingToCheck-1]\t$CpGFlag\n";
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
}
print OUT "$Positions[$ThingToCheck]\t$CpGFlag\n";
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
}
print OUT "$Positions[$ThingToCheck]\t$CpGFlag\n";
}
$ThingToCheck++;
}

$PreCharacter = substr($Line, 59, 1);
$StartingPosition = $StartingPosition + 60;
}
close (FILE);

