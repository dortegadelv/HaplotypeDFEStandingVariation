$PrefixOfFiles = $ARGV[0];
$NumberOfFiles = $ARGV[1];
$NGen = $ARGV[2];

$TotalNumberOfVariants = 0;
$TotalNumberOfOnePercenters = 0;
$OnePercentersInRange = 0;
$TotalNumberOfAllelesInRange = 0;

for ($i = 1; $i <= $NumberOfFiles; $i++){

$File = $PrefixOfFiles.$i.".full_out.txt";
print "File = $File\n";
open (FILE,$File) or die "NO!";
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$TotalNumberOfVariants++;

$TwoNs = 2000 * $SplitLine[3]/2;

if ($SplitLine[2] == 0.01){
$TotalNumberOfOnePercenters++;

if ( ($TwoNs >= 0) && ($TwoNs <= 5) ){
$OnePercentersInRange++;
$TotalNumberOfAllelesInRange++;
}
}else{
if ( ($TwoNs >= 0) && ($TwoNs <= 5) ){
$TotalNumberOfAllelesInRange++;
}

}
}
close(FILE);
}

$TotalNumberOfVariants = 1000 * $NGen * $NumberOfFiles;
$TotalNumberOfAllelesInRange = 1000 * $NGen * $NumberOfFiles * 0.5031;
print "Total Number Of Variants = $TotalNumberOfVariants\n";
print "Total Number Of One Percenters = $TotalNumberOfOnePercenters\n";

$P_f_given_C = $TotalNumberOfOnePercenters / $TotalNumberOfVariants;
print "P(Alleles has 1% f | C) = $P_f_given_C\n";

$P_AlleleAtRange = $OnePercentersInRange/ $TotalNumberOfOnePercenters;
print "P(Alleles has 2Ns = [0,5] | 1%, C) = $P_AlleleAtRange\n";

$P_alleleInOnePercentGivenRange = $OnePercentersInRange / $TotalNumberOfAllelesInRange;
print "P(Alleles has 1% f | Alleles has 2Ns = [0,5], Demography) = $P_alleleInOnePercentGivenRange\n";

$FinalEstimate = $P_AlleleAtRange * $P_f_given_C / $P_alleleInOnePercentGivenRange;
print "Final estimate = $FinalEstimate\n";
