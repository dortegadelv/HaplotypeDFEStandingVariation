$PositionsFilePrefix = $ARGV[0];
$SNPNumberToTake = $ARGV[2];
$FrequencyFile = $ARGV[1];
$PlinkTpedFilePrefix = $ARGV[3];
$PlinkTfamFilePrefix = $ARGV[4];
$IndividualsToTake = $ARGV[5];
$HapLengthToTake = $ARGV[6];

$HapLengthPlusOne = $HapLengthToTake + 1;

$SNPNumberToTake = $SNPNumberToTake - 1;

$ExitFile = "../Results/HapLengthOnlyLeft".$SNPNumberToTake.".txt";
open (EXITLEFT,">$ExitFile") or die "NO!";
$ExitFile = "../Results/HapLengthOnlyRight".$SNPNumberToTake.".txt";
open (EXITRIGHT,">$ExitFile") or die "NO!";

### Get Position and chromosome number associated

open (FILE,$FrequencyFile) or die "Cannot open file $FrequencyFile";
@Positions = ();
@Chromosomes = ();
@AncestralAllele = ();
@AlleleZero = ();
@AlleleOne = ();
@MinorAllele = ();
@MajorAllele = ();
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@MiniStuff = split(/\./,$SplitLine[2]);
push (@Positions,$MiniStuff[1]);
push (@Chromosomes, $MiniStuff[0]);
push (@AncestralAllele,$SplitLine[10]);
push (@AlleleZero,$SplitLine[8]);
push (@AlleleOne,$SplitLine[9]);
push (@MinorAllele,$SplitLine[3]);
push (@MajorAllele,$SplitLine[4]);
}
close (FILE);

print "$Positions[$SNPNumberToTake]\t$Chromosomes[$SNPNumberToTake]\n";
if (($AncestralAllele[$SNPNumberToTake] eq $AlleleZero[$SNPNumberToTake]) && ($MajorAllele[$SNPNumberToTake] eq "0")){
$DerivedAllele = 1;
}elsif(($AncestralAllele[$SNPNumberToTake] eq $AlleleOne[$SNPNumberToTake]) && ($MajorAllele[$SNPNumberToTake] eq "1")){
$DerivedAllele = 0;
}
else{
die "Derived allele has around 99% frequency\n";
}

## Get Lines and files from Plink tped file

$PositionFile=$PositionsFilePrefix.$Chromosomes[$SNPNumberToTake].".txt";
open (POS,$PositionFile) or die "Cannot open $PositionFile";
$PosNumber = 1;
@LineNumberToTake = ();
while(<POS>){
chomp;
$Line = $_;
$CurPosNumber = $Line;

if ( ($CurPosNumber <= ($Positions[$SNPNumberToTake] + $HapLengthToTake)) && ($CurPosNumber >= ($Positions[$SNPNumberToTake] - $HapLengthToTake))){
push(@LineNumberToTake,$PosNumber);
}
if ($CurPosNumber == $Positions[$SNPNumberToTake]){
$FocalSNP = scalar(@LineNumberToTake) - 1;
}
$PosNumber++;
}

close(POS);

$LinesToTake = scalar(@LineNumberToTake);
print "Lines to take = $LinesToTake $LineNumberToTake[0] $LineNumberToTake[$LinesToTake-1]\n";

$Difference = $LineNumberToTake[$LinesToTake-1] - $LineNumberToTake[0] + 1;
$FirstNumber = $LineNumberToTake[$LinesToTake-1];
$PlinkTpedFile = $PlinkTpedFilePrefix.$Chromosomes[$SNPNumberToTake].".tped";
$UnixCommandLine = "head -n$FirstNumber $PlinkTpedFile | tail -n$Difference";
$DataToTake = `$UnixCommandLine`;
@AllLines = split(/\n/,$DataToTake);
$NumberOfLines = scalar(@AllLines);
print "Number of lines = $NumberOfLines\n";
print "Focal SNP = $FocalSNP $AllLines[$FocalSNP]\n";

### Get Individuals to take

open (LIST,$IndividualsToTake) or die "NO";

@IndividualsList = ();

while(<LIST>){
chomp;
$List = $_;
@SplitLine = split(/\s+/,$List);
push(@IndividualsList,$SplitLine[0]);
}

close(LIST);
$TFam = $PlinkTfamFilePrefix.$Chromosomes[$SNPNumberToTake].".tfam";
open (TFAM,$TFam) or die "Cannot open $TFam";

$IndividualNumber = 0;
@IndividualsToTake = ();
while (<TFAM>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if (grep {$_ eq $SplitLine[0]} @IndividualsList) {
  push(@IndividualsToTake,$IndividualNumber);
}
$IndividualNumber++;
}

close(TFAM);

$NumberOfIndividualsInVector = scalar(@IndividualsToTake);
print "Individuals to take = $NumberOfIndividualsInVector $IndividualsToTake[0]\n";

# die "NO!\n";
### Do four-way comparisons
$NumberOfComparisons = 0;
$NumberOfThingsPrinted = 0;
for ($IndOne = 0; $IndOne < scalar(@IndividualsToTake); $IndOne++){
$IndividualOne = $IndividualsToTake[$IndOne];
$AlleleOne = $FocalSiteChecked[($IndividualOne)*2+0+4];
$OtherAlleleOne = $FocalSiteChecked[($IndividualOne)*2+1+4];
print "Calculating... $IndividualOne\t$FocalSiteChecked[1]\t$AlleleOne\t$OtherAlleleOne\n";

@FocalSiteChecked = split(/\s+/,$AllLines[$FocalSNP]);

for ($IndTwo = $IndOne; $IndTwo < scalar(@IndividualsToTake); $IndTwo++){
$IndividualTwo = $IndividualsToTake[$IndTwo];
# print "Ind one = $IndOne $IndividualOne and Ind two = $IndTwo $IndividualTwo\n";
for ($i = 0; $i < 2; $i++){
for ($j = 0; $j < 2; $j++){

if (($IndividualOne eq $IndividualTwo) && ($i eq $j) ){
next;
}
if (($IndividualOne eq $IndividualTwo) && ($i == 1) ){
next;
}
#    print "Here?";
# @SiteChecked = split(/\s+/,$AllLines[$FocalSNP]);
$AlleleOne = $FocalSiteChecked[($IndividualOne)*2+$i+4];
$AlleleTwo = $FocalSiteChecked[($IndividualTwo)*2+$j+4];
if ($AlleleOne ne $DerivedAllele){
#   print "$AlleleOne\t$DerivedAllele\n";
next;
}
if ($AlleleTwo ne $DerivedAllele){
next;
}

print "IndividualOne = $IndividualOne IndividualTwo = $IndividualTwo i=$i j=$j AlleleOne=$AlleleOne AlleleTwo=$AlleleTwo\n";
## Left side 
$Flag = 0;
$NumberOfComparisons++;
for ($Site = $FocalSNP - 1 ; $Site >= 0 ; $Site-- ){

@SiteChecked = split(/\s+/,$AllLines[$Site]);
$AlleleOne = $SiteChecked[($IndividualOne)*2+$i+4];
$AlleleTwo = $SiteChecked[($IndividualTwo)*2+$j+4];
if ($AlleleOne ne $AlleleTwo ){
$Difference = $Positions[$SNPNumberToTake] - $SiteChecked[3];
$Flag = 1;
last;
}}

if ($Flag == 1){
print EXITLEFT "$Difference\n";
$NumberOfThingsPrinted++;
#    print "Dif =$Difference\n";
}else{
print EXITLEFT "$HapLengthPlusOne\n";
#        print "Dif =$HapLengthPlusOne\n";
$NumberOfThingsPrinted++;
}
print "Number of comparisons = $NumberOfComparisons\n";
## Right side
$Flag = 0;

    #close(EXIT);

    
for ($Site = $FocalSNP + 1 ; $Site < $NumberOfLines ; $Site++ ){

@SiteChecked = split(/\s+/,$AllLines[$Site]);
$AlleleOne = $SiteChecked[($IndividualOne)*2+$i+4];
$AlleleTwo = $SiteChecked[($IndividualTwo)*2+$j+4];
if ($AlleleOne ne $AlleleTwo ){
$Difference = $SiteChecked[3] - $Positions[$SNPNumberToTake];
$Flag = 1;
last;
}}
if ($Flag == 1){
print EXITRIGHT "$Difference\n";
$NumberOfThingsPrinted++;
}else{
print EXITRIGHT "$HapLengthPlusOne\n";
$NumberOfThingsPrinted++;
}

print "Number of things printed = $NumberOfThingsPrinted\n";
# die "NO!\n";
}}
# die "NO!\n";
}



}

close (EXITLEFT);
close (EXITRIGHT);
