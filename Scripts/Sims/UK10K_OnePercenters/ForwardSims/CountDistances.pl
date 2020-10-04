$DistanceFile = $ARGV[0];
$CountExitFile = $ARGV[1];

open (FILE,">$CountExitFile") or die "NO!";

$Line = "awk \'\$1 >= 0.0 \&\& \$1 <= 0.2 {print \$1}\' $DistanceFile | wc -l | awk \'{print \$1}\'";

# print $Line;
$FirstBin = `$Line`;
chomp($FirstBin);

$Line = "awk \'\$1 > 0.2 \&\& \$1 <= 0.4 {print \$1}\' $DistanceFile | wc -l | awk \'{print \$1}\'";

# print $Line;
$SecondBin = `$Line`;
chomp($SecondBin);

$Line = "awk \'\$1 > 0.4 \&\& \$1 <= 0.6 {print \$1}\' $DistanceFile | wc -l | awk \'{print \$1}\'";

# print $Line;
$ThirdBin = `$Line`;
chomp($ThirdBin);

$Line = "awk \'\$1 > 0.6 \&\& \$1 <= 0.8 {print \$1}\' $DistanceFile | wc -l | awk \'{print \$1}\'";

# print $Line;
$FourthBin = `$Line`;
chomp($FourthBin);

$Line = "awk \'\$1 > 0.8 \&\& \$1 <= 1.0 {print \$1}\' $DistanceFile | wc -l | awk \'{print \$1}\'";

# print $Line;
$FifthBin = `$Line`;
chomp($FifthBin);

$Line = "awk \'\$1 > 1.0 {print \$1}\' $DistanceFile | wc -l | awk \'{print \$1}\'";

# print $Line;
$SixthBin = `$Line`;
chomp ($SixthBin);

print FILE "$FirstBin\t$SecondBin\t$ThirdBin\t$FourthBin\t$FifthBin\t$SixthBin\n";

close (FILE);

