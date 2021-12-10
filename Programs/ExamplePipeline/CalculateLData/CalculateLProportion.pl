$SNPNumberToTake=$ARGV[0];
$LBreaksFile=$ARGV[1];

open (LBREAK,$LBreaksFile) or die "NO!";

@Breaks = ();
while (<LBREAK>){
    chomp;
    $Line = $_;
    push(@Breaks,$Line);
}
close (LBREAK);

$SNPNumberToTake = $SNPNumberToTake - 1;

@LProportions = ();
for ($i = 0; $i <= scalar(@Breaks);$i++){
    $LProportions[$i] = 0;
}

$File = "../Results/HapLengthOnlyLeft".$SNPNumberToTake.".txt";

open (FILE,$File) or die "NO!";
$NumberOfElements = 0;
while (<FILE>){
    chomp;
    $Line = $_;
    $Flag = 0;
    for ($i = 0; $i < (scalar(@Breaks) - 1) ;$i++){
        if ( ($Line >= $Breaks[$i] ) && ($Line <= $Breaks[$i+1] ) ){
            $LProportions[$i]++;
            $NumberOfElements++;
            $Flag = 1;
            last;
        }
    }
    if ($Flag == 0){
        $LProportions[scalar(@Breaks)]++;
        $NumberOfElements++;
    }
}

close (FILE);

$File = "../Results/HapLengthOnlyRight".$SNPNumberToTake.".txt";

open (FILE,$File) or die "NO!";

while (<FILE>){
    chomp;
    $Line = $_;
    $Flag = 0;
    for ($i = 0; $i < (scalar(@Breaks) - 1);$i++){
        if ( ($Line >= $Breaks[$i] ) && ($Line <= $Breaks[$i+1] ) ){
            $LProportions[$i]++;
            $NumberOfElements++;
            $Flag = 1;
            last;
        }
    }
    if ($Flag == 0){
        $LProportions[scalar(@Breaks)]++;
        $NumberOfElements++;
    }
}

close (FILE);

for ($i = 0; $i <= scalar(@Breaks);$i++){
    $LProportions[$i] = $LProportions[$i]/$NumberOfElements;
}




$ExitFile = "../Results/LProportion".$SNPNumberToTake.".txt";
open (PROPORTIONS, ">$ExitFile") or die "NO";

for ($i = 0; $i < (scalar(@Breaks) - 1);$i++){
    print PROPORTIONS "$LProportions[$i]\t";
}
$ElementNumber = scalar(@Breaks);
print PROPORTIONS "$LProportions[$ElementNumber]\n";
