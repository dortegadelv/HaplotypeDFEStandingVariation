$File = $ARGV[0];

$ExpectedValue = 0;
$ExpectedValueTwo = 0;
$ProbSum = 0;
$ProbSum2 = 0;

open (FILE,$File) or die "NO!";

while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$ExpectedValue = $ExpectedValue + $SplitLine[0]*$SplitLine[1];
$ProbSum = $ProbSum + $SplitLine[1];
if ($SplitLine[2]){
$ExpectedValueTwo = $ExpectedValueTwo + $SplitLine[0]*$SplitLine[2];
$ProbSum2 = $ProbSum2 + $SplitLine[2];
}
}

close(FILE);
print "Expected value = $ExpectedValue $ExpectedValueTwo $ProbSum $ProbSum2\n";

