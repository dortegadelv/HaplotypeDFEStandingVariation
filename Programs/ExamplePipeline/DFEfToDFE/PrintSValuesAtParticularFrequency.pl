$FrequencyFile = $ARGV[0];
$ExitSFile = $ARGV[1];
$Prefix = $ARGV[2];
$NumberOfFiles = $ARGV[3];

open (FREQ,$FrequencyFile) or die "NO!";

@FrequencyValues = ();
while(<FREQ>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@FrequencyValues,$SplitLine[0]);
print "$SplitLine[0]\n";
}

close(FREQ);

open (OUT,">$ExitSFile") or die "NO!";

for ($i = 1; $i<= $NumberOfFiles; $i++){

$File = $Prefix.$i.".full_out.txt";
print "$File\n";
open (FILE,$File) or die "NO! $File\n";
while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$Scalar = scalar(@FrequencyValues);
# print "Scalar = $Scalar\n";
for ($j = 0; $j < scalar(@FrequencyValues) ; $j++){
# print "$FrequencyValues[$j]\n";
# die "NO!\n";
if ( $SplitLine[1] eq $FrequencyValues[$j] ){
$CurrentS = $SplitLine[2];
print OUT "$FrequencyValues[$j]\t$CurrentS\n";
}}}

close(FILE);
}
close(OUT);

