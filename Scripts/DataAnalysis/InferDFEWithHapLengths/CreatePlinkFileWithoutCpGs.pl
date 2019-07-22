for ($i = 1; $i <= 22; $i++){
$File = "../../../Data/Plink/PlinkFrequencyAnnotationAncestralAlleleCpG".$i.".frq";
$Out = "../../../Data/Plink/PlinkFrequencyAnnotationAncestralAlleleNotCpG".$i.".frq";
@CpG = ();
print "Chromosome = $i\n";
open (FRQ,$File ) or die "NO!";
open (EXIT, ">$Out") or die "NO!";
$LineNumber = 0;

while (<FRQ>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
# push (@CpG, $SplitLine[12]);
if ($LineNumber == 0){
print EXIT "$Line\n";
}else{
push (@CpG, $SplitLine[12]);
if ( $SplitLine[12] eq "0"){
print EXIT "$Line\n";
}
}
$LineNumber++;
}

close (FRQ);
close (EXIT);

$InputFile = "../../../Data/Plink/Plink".$i.".tped";
$Output = "../../../Data/Plink/PlinkNotCpG".$i.".tped";
open (INPUT,$InputFile) or die "NO!\n";
open (EXIT, ">$Output") or die "NO!";
$LineNumber = 0;
while (<INPUT>){
chomp;
$Line = $_;
if ($CpG[$LineNumber] eq "0"){
print EXIT "$Line\n";
}
$LineNumber++;
}
close (INPUT);
close (EXIT);
}
