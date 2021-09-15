$SNPNumberToTake = $ARGV[0];
$SNPNumberToTake = $SNPNumberToTake - 1;

# $ExitFile = "../../../Data/Plink/HapLengths/HapLengthSynonymousNotCpG".$SNPNumberToTake.".txt";
# open (EXIT,">$ExitFile") or die "NO!";
### Get Position and chromosome number associated

open (FILE,"../../../Data/Plink/SynonymousOnePercentCpG.frq") or die "NO!";
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

# print "$Positions[$SNPNumberToTake]\t$Chromosomes[$SNPNumberToTake]\n";
if (($AncestralAllele[$SNPNumberToTake] eq $AlleleZero[$SNPNumberToTake]) && ($MajorAllele[$SNPNumberToTake] eq "0")){
$DerivedAllele = 1;
    print "$SNPNumberToTake\t1\n";
}elsif(($AncestralAllele[$SNPNumberToTake] eq $AlleleOne[$SNPNumberToTake]) && ($MajorAllele[$SNPNumberToTake] eq "1")){
$DerivedAllele = 0;    print "$SNPNumberToTake\t1\n";

}
else{
    print "$SNPNumberToTake\t0\n";
# die "Derived allele has around 99% frequency\n";
}
## Get Lines and files from Plink tped file
