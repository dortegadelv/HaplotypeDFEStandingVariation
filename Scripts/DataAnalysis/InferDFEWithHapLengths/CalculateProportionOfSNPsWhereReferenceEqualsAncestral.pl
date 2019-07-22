$File = "../../../Data/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf.gz";

open (FILE,"../../../Data/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf") or die "NO! cant open pipe to file";
$NumberOfSNPs = 0;
$NumberOfReferenceAncestralMatches = 0;
while (<FILE>){
chomp;
$Line = $_;
if ($Line =~ /VT=SNP/){
$Line =~ /AA=(.)/;
@TabixLineParts = split(/\s+/,$Line);
$ReferenceAllele = $TabixLineParts[3];
$AncestralAllele=uc($1);
if ($ReferenceAllele eq $AncestralAllele){
$NumberOfReferenceAncestralMatches++;
}
$NumberOfSNPs++;
if ($NumberOfSNPs % 100000 == 0){
print "$NumberOfSNPs\n";
}

}
}

close(FILE);

$Fraction = $NumberOfReferenceAncestralMatches / $NumberOfSNPs;
print "$Fraction $NumberOfReferenceAncestralMatches $NumberOfSNPs";
