$InputTable = $ARGV[0];
$ExitValues = $ARGV[1];
$Actual4NsValue = $ARGV[2];
$IntervalSpan = 2.0;

open (INPUT,$InputTable) or die "NO!";
open (OUTPUT,">$ExitValues") or die "NO!";

while(<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$Max = $SplitLine[0];
$BestValue = 0;
for ($i = 0; $i < 204; $i++){
if ($SplitLine[$i] > $Max){
$Max = $SplitLine[$i];
$BestValue = $i;
}
}

print OUTPUT "$BestValue\t";

if ( ( $Max -  $SplitLine[$Actual4NsValue] ) <= $IntervalSpan){ 
print OUTPUT "1\n";
}else{
print OUTPUT "0\n";
}

}

close(INPUT);
close(OUTPUT);

