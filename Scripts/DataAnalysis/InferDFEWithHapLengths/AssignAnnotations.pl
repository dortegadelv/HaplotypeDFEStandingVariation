for ( $i = 1 ; $i <= 22 ; $i++ ) {

print "Chromosome $i\n";
$File = "../../../Data/UK10K_COHORTChr".$i.".20160215.sites";
open (FILE,$File) or die "NO!";
%Annotations = ();
$LineNumber = 0;
while (<FILE>){
chomp;
if ($LineNumber > 0 ){
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@MiniStuff = split(/\./,$SplitLine[1]);
$SNP = $i.".".$MiniStuff[0];
$Annotations{$SNP} = $SplitLine[0];
#print "$SNP\t$Annotations{$SNP}\n";
# die "NO!\n";
}
$LineNumber++;
}

close(FILE);

$File = "/mnt/gluster/data/external_private_supp/uk10k/_EGAZ00001017893_".$i.".UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.legend.gz";

open (FILE,"zcat $File |") or die "NO!";

%AlleleZero = ();
%AlleleOne = ();
$LineNumber = 0;

while (<FILE>){
chomp;
if ($LineNumber > 0){
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@MiniStuff = split(/\:/,$SplitLine[0]);
if ( (length($SplitLine[2]) == 1) && (length($SplitLine[3]) == 1)){
$SNP = $i.".".$SplitLine[1];
$AlleleZero{$SNP} = $SplitLine[2];
$AlleleOne{$SNP} = $SplitLine[3];
# print "$SNP\t$AlleleZero{$SNP}\t$AlleleOne{$SNP}\n";
# die "NO! $Line\n";
}
}
$LineNumber++;
}

close(FILE);

$File = "../../../Data/Plink/PlinkReduced".$i.".frq";
$ExitFile = "../../../Data/Plink/PlinkFrequencyAnnotation".$i.".frq";

open (FILE,$File) or die "NO! $File\n";
open (EXIT,">$ExitFile") or die "NO! $ExitFile\n";
$LineNumber = 0;

while (<FILE>){
chomp;
$Line = $_;
if ( $LineNumber > 0 ){
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@MiniStuff = split(/\./,$SplitLine[2]);
# print "MiniStuff = $MiniStuff[2] Split = $SplitLine[2] Line = $Line\n";
$Position = $MiniStuff[1];
# $LineToSearch="tabix ../../../Data/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf.gz $i:$Position-$Position | tail -n1";
# $TabixLine = `$LineToSearch`;
# $TabixLine =~ /AA=(.)/;
# $AncestralAllele=$1;
# print "$LineToSearch\n";
# print "$TabixLine\n";
# print "Ancestral Allele = $AncestralAllele\n";
# die "NO!\n";
}
if ( $LineNumber > 0 ){
print EXIT "$Line";
print EXIT "\t$Annotations{$SplitLine[2]}\t$AlleleZero{$SplitLine[2]}\t$AlleleOne{$SplitLine[2]}\n";
# print "$SplitLine[2]\t$Annotations{$SplitLine[2]}\n";
# die "NO!";
}else{
print EXIT "$Line\tAnnotation\tAlleleZero\tAlleleOne\n";
}
$LineNumber++;
}

close(FILE);
close(EXIT);
}

