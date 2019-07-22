$Chromosome = $ARGV[0];

%Annotations = ();
$Flag = 0;
$StartChr = 1;
$File = "../../../Data/UK10K_COHORT.20160215.sites.vcf.gz";

open (POSITIONS,"zcat $File |") or die "NO!";
$PositionExit="../../../Data/fastNeutrinoInput/UK10K_COHORTChr".$Chromosome.".20160215.sites";
open (EXIT,">$PositionExit") or die "NO!";
print EXIT "	position.a0.a1\n";
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

if ( ( index($Line, "transcript_ablation") == -1 ) && ( index($Line, "splice_acceptor_variant") == -1 ) && ( index($Line, "splice_donor_variant") == -1 ) && ( index($Line, "stop_gained") == -1 ) && ( index($Line, "frameshift_variant") == -1 ) && ( index($Line, "stop_lost") == -1 ) && ( index($Line, "start_lost") == -1 ) && ( index($Line, "transcript_amplification") == -1 ) && ( index($Line, "inframe_insertion") == -1 ) && ( index($Line, "inframe_deletion") == -1 ) && ( index($Line, "missense_variant") == -1 ) && ( index($Line, "protein_altering_variant") == -1 )){
$Annotations{$Key} = "synonymous";
print EXIT "synonymous\t$Key\t";
$Line =~ /AC_TWINSUK_NODUP\=(\w+)\;/;
$ACTwins = $1;
$Line =~ /AN\=(\w+)\;/;
$TotalAN = $1;
$Line =~ /AC_ALSPAC\=(\w+)\;/;
$ACALSPAC = $1;
$TotalAlleleCount = $ACTwins + $ACALSPAC;
print EXIT "$TotalAlleleCount\n";
if ($TotalAN != 7562){
die "NO!Count = $TotalAN\n";
}
}else{
$Annotations{$Key} = "other";
print EXIT "other\t$Key\t";
$Line =~ /AC_TWINSUK_NODUP\=(\w+)\;/;
$ACTwins = $1;
$Line =~ /AN\=(\w+)\;/;
$TotalAN = $1;
$Line =~ /AC_ALSPAC\=(\w+)\;/;
$ACALSPAC = $1;
$TotalAlleleCount = $ACTwins + $ACALSPAC;
print EXIT "$TotalAlleleCount\n";
if ($TotalAN != 7562){
die "NO!Count = $TotalAN\n";
}
}
}
elsif(index($Line, "missense") != -1){
if ( ( index($Line, "transcript_ablation") == -1 ) && ( index($Line, "splice_acceptor_variant") == -1 ) && ( index($Line, "splice_donor_variant") == -1 ) && ( index($Line, "stop_gained") == -1 ) && ( index($Line, "frameshift_variant") == -1 ) && ( index($Line, "stop_lost") == -1 ) && ( index($Line, "start_lost") == -1 ) && ( index($Line, "transcript_amplification") == -1 ) && ( index($Line, "inframe_insertion") == -1 ) && ( index($Line, "inframe_deletion") == -1 ) && ( index($Line, "protein_altering_variant") == -1 )){

$Annotations{$Key} = "missense";
print EXIT "missense\t$Key\t";
$Line =~ /AC_TWINSUK_NODUP\=(\w+)\;/;
$ACTwins = $1;
$Line =~ /AN\=(\w+)\;/;
$TotalAN = $1;
$Line =~ /AC_ALSPAC\=(\w+)\;/;
$ACALSPAC = $1;
$TotalAlleleCount = $ACTwins + $ACALSPAC;
print EXIT "$TotalAlleleCount\n";
if ($TotalAN != 7562){
die "NO!Count = $TotalAN\n";
}
}else{
$Annotations{$Key} = "other";
print EXIT "other\t$Key\t";
$Line =~ /AC_TWINSUK_NODUP\=(\w+)\;/;
$ACTwins = $1;
$Line =~ /AN\=(\w+)\;/;
$TotalAN = $1;
$Line =~ /AC_ALSPAC\=(\w+)\;/;
$ACALSPAC = $1;
$TotalAlleleCount = $ACTwins + $ACALSPAC;
print EXIT "$TotalAlleleCount\n";
if ($TotalAN != 7562){
die "NO!Count = $TotalAN\n";
}

}
}else{
$Annotations{$Key} = "other";
print EXIT "other\t$Key\t";
$Line =~ /AC_TWINSUK_NODUP\=(\w+)\;/;
$ACTwins = $1;
$Line =~ /AN\=(\w+)\;/;
$TotalAN = $1;
$Line =~ /AC_ALSPAC\=(\w+)\;/;
$ACALSPAC = $1;
$TotalAlleleCount = $ACTwins + $ACALSPAC;
print EXIT "$TotalAlleleCount\n";
if ($TotalAN != 7562){
die "NO!Count = $TotalAN\n";
}

}
#die "$Key $Annotations{$Key} NO!\n";
}
if ($SplitLine[0] eq "#CHROM"){
$Flag = 1;
}
}

close (POSITIONS);
close (EXIT);
