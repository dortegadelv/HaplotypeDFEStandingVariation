$Chromosome = $ARGV[0];

%Annotations = ();
$Flag = 0;
$StartChr = 1;
$File = "../../Data/UK10K_COHORT.20160215.sites.vcf.gz";

open (POSITIONS,"zcat $File |") or die "NO!";

while (<POSITIONS>){
chomp;
$Line = $_;
# print "$_\n";
@SplitLine = split(/\s+/,$Line);
# die "NO!";
if ($StartChr != $SplitLine[0]){
$StartChr = $SplitLine[0];
print "Chromosome $StartChr\n";
}

if ($Flag ==1 && ($Chromosome eq $SplitLine[0])){
$Key=$SplitLine[1].".".$SplitLine[3].".".$SplitLine[4];
$Annotations{$Key} = 1;
# print "$Key\n";
# die "NO!";
if (index($Line, "synonymous") != -1){

if ( ( index($Line, "missense_variant") == -1 )){
$Annotations{$Key} = "synonymous";
}else{
$Annotations{$Key} = "other";
}
}
elsif(index($Line, "missense") != -1){

$Annotations{$Key} = "missense";
#}else{
#$Annotations{$Key} = "other";
#}
}else{
$Annotations{$Key} = "other";
}
#die "$Key $Annotations{$Key} NO!\n";
}
if ($SplitLine[0] eq "#CHROM"){
$Flag = 1;
}
}

close(POSITIONS);
$File = "/mnt/gluster/data/external_private_supp/uk10k/_EGAZ00001017893_".$Chromosome.".UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.legend.gz";
$PositionExit="../../Data/UK10K_COHORTLaxAnnotationChr".$Chromosome.".20160215.sites";
open (FILE,"zcat $File |") or die "NO!";
open (EXIT,">$PositionExit") or die "NO!";
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$Key = $SplitLine[1].".".$SplitLine[2].".".$SplitLine[3];
print EXIT "$Annotations{$Key}\t$Key\n";
}

close(FILE);
