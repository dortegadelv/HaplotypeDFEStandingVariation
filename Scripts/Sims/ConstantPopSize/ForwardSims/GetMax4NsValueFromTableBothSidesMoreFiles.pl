$InputTableLeft = $ARGV[0];
$InputTableRight = $ARGV[1];
$InputTableLeftTwo = $ARGV[2];
$InputTableRightTwo = $ARGV[3];

$ExitValues = $ARGV[4];
$Actual4NsValue = $ARGV[5];
$IntervalSpan = 2.0;

open (INPUT,$InputTableLeft) or die "NO!";

@LLMatrix = ();
$LineNumber = 0;
while(<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ($i = 0; $i < scalar(@SplitLine); $i++){
$LLMatrix[$LineNumber][$i] = $SplitLine[$i];
}
$LineNumber++;
}
close (INPUT);

open (INPUT,$InputTableLeftTwo) or die "NO!";

$LineNumber = 0;
while(<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ($i = 0; $i < scalar(@SplitLine); $i++){
$LLMatrix[$LineNumber][$i] = $LLMatrix[$LineNumber][$i] + $SplitLine[$i];
}
$LineNumber++;
}
close (INPUT);

open (INPUT,$InputTableRightTwo) or die "NO!";

$LineNumber = 0;
while(<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ($i = 0; $i < scalar(@SplitLine); $i++){
$LLMatrix[$LineNumber][$i] = $LLMatrix[$LineNumber][$i] + $SplitLine[$i];
}
$LineNumber++;
}
close (INPUT);


open (INPUT,$InputTableRight) or die "NO!";
open (OUTPUT,">$ExitValues") or die "NO!";

$LineNumber = 0;
while(<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$Max = $LLMatrix[$LineNumber][0] + $SplitLine[0];
$BestValue = 0;
for ($i = 0; $i < scalar(@SplitLine); $i++){
if (( $LLMatrix[$LineNumber][$i] + $SplitLine[$i]) > $Max){
$Max = $SplitLine[$i] + $LLMatrix[$LineNumber][$i];
$BestValue = $i;
}
}

print OUTPUT "$BestValue\t";

if ( ( $Max -  $SplitLine[$Actual4NsValue] ) <= $IntervalSpan){ 
print OUTPUT "1\n";
}else{
print OUTPUT "0\n";
}
$LineNumber++;
}

close(INPUT);
close(OUTPUT);

