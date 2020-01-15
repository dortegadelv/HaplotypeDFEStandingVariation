$FrequencyDown = $ARGV[0];
$FrequencyUp =  $ARGV[1];
$File = $ARGV[2];
$ExitFile = $ARGV[3];
open (FILE,$File) or die "NO!";
open (EXIT,">$ExitFile") or die "NO!";

$NumberOfAlleles = 0;

while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

# print "$SplitLine[2]\n";
$MiniVariable = $SplitLine[2] + 1;
# print "Freq = $FrequencyDown $FrequencyUp\n";
#print "MiniVar = $MiniVariable\n";
# die "NO!";
if ( ( $SplitLine[2] >= $FrequencyDown ) && ( $SplitLine[2] <= $FrequencyUp ) ){
print "$SplitLine[2]\n";
print EXIT "$SplitLine[5]";
$NumberOfAlleles++;

print EXIT "\n";
}
# die "NO!\n";
}
# $AgeAverage = $AgeAverage / $NumberOfAlleles;
# print "Average = $AgeAverage\n";
close(FILE);
close(EXIT);
