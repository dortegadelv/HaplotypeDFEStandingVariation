$HapLengthPrefix = $ARGV[0];
$NumberOfFiles = $ARGV[1];
$UnitsOfHapLengthFile = $ARGV[2];
$FileBoundaries = $ARGV[3];
$ExitFile = $ARGV[4];

# @HapLengths = ();

@Bounds = ();
@HapLengthsCounts = ();
open (BOUNDS,$FileBoundaries) or die "NO!";
$NumberOfIntervalsToCheck = 0;
while(<BOUNDS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push (@Bounds,$SplitLine[0]);
push ( @HapLengthsCounts, 0);
$NumberOfIntervalsToCheck++;
}

close(BOUNDS);

for ($i = 1; $i <= $NumberOfFiles; $i++ ) {
print "File = $i\t";
$FileToCheck = $HapLengthPrefix.$i.".txt";
print "$FileToCheck\n";
open (FILE,$FileToCheck) or die "NO!";

while(<FILE>){
chomp;
$Line = $_;
$Variable = int($Line*$UnitsOfHapLengthFile + 0.5);

if ($Line == 2.0){
$HapLengthsCounts[5]++;
}else{

for ($j = 0; $j < $NumberOfIntervalsToCheck; $j++){
if ( ($Variable >= $Bounds[$j]) && ($Variable <= $Bounds[$j+1])){
$IntervalFlag = 1;
# print "$Variable\t$j\n";
last;
}}
# die "NO! $Line $Variable\n";
$HapLengthsCounts[$j]++;

}
}
close(FILE);
}
open (EXIT,">$ExitFile") or die "NO!";
for ($j = 0; $j < 6; $j++){
print EXIT "$HapLengthsCounts[$j]\t";
}
print EXIT "\n";
close (EXIT);
