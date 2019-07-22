for ($i = 1; $i <= 22; $i++){
$CpGFile = "../../../Data/Plink/CpGSites".$i.".frq";
@CpG = ();
print "Chromosome $i\n";
open (CPG,$CpGFile) or die "NO!\n";

while (<CPG>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
push (@CpG,$SplitLine[1]);
}
close (CPG);
$AnnotatedFile = "../../../Data/Plink/PlinkFrequencyAnnotationAncestralAllele".$i.".frq";
$AnnotatedCpGFile = "../../../Data/Plink/PlinkFrequencyAnnotationAncestralAlleleCpG".$i.".frq";
open (FILE,$AnnotatedFile ) or die "NO\n";
open (EXIT,">$AnnotatedCpGFile" ) or die "NO!\n";
$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
if ($LineNumber == 0){
print EXIT "$Line\tCpGStatus\n";
}else{
print EXIT "$Line\t$CpG[$LineNumber-1]\n";
}
$LineNumber++;
}
close (FILE);
close (EXIT);
}
