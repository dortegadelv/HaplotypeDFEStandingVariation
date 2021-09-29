open (FILE,"LDistributionOnePercentSynSites_NotCpG.txt") or die "NO";
@LDistData = ();

while (<FILE>){
chomp;
$Line = $_;
@LDistData = split(/\s+/,$Line);
print "Line = $Line $LDistData[0] $LDistData[1]\n";
}
close (FILE);
foreach $j (@LDistData){
print "$j\t";
}
print "\n";

@DifThresholds = (0.0075, 0.01, 0.0125, 0.015, 0.0175 , 0.02, 0.0225, 0.025, 0.0275, 0.03);

$ExitFile = "../../../../Results/ABCAnalysis/ParametersAndStatisticsDifThresholds.txt";
open (EXIT,">$ExitFile") or die "NO";

foreach $Threshold (@DifThresholds){

@LDistSims = ();

@Averages = (0,0,0,0,0,0);
$File = "../../../../Results/ABCAnalysis/ParametersAndStatisticsNotCpG50000.txt";
open (FILE,$File) or die "NO";

@NeOne = ();
@NeTwo = ();
@DivTime = ();
@LValues = ();

while (<FILE>){
chomp;
$Line = $_;
@LDistSims = split(/\s+/,$Line);
$MismatchStatistic = 0;
$Flag = 0;
for ($j = 0; $j < 6; $j++){
$Difference = abs($LDistData[$j] - $LDistSims[$j+5]);
if ($Difference > $Threshold){
$Flag = 1;
}
}

if ($Flag == 1){
next;
}

push (@LValues, $Line);
for ($i = 5; $i <= 10; $i++){
$Averages[$i - 5] =  $Averages[$i - 5] + $LDistSims[$i];
}

push (@NeOne, $LDistSims[1]);
push (@NeTwo, $LDistSims[2]);
push (@DivTime, $LDistSims[3]);
}
close (FILE);

$ElementsRetained = scalar(@NeOne) ;

print EXIT "$Threshold";
my $median;
my $mid = int @NeOne/2;
my @sorted_values = sort {$a <=> $b} @NeOne;
if (@sorted_values % 2) {
    $median = $sorted_values[ $mid ];
} else {
    $median = ($sorted_values[$mid-1] + $sorted_values[$mid])/2;
}
$median = $median / 5; 
print EXIT "\t$ElementsRetained\t$median";

my $median;
my $mid = int @NeTwo/2;
my @sorted_values = sort {$a <=> $b} @NeTwo;
if (@sorted_values % 2) {
    $median = $sorted_values[ $mid ];
} else {
    $median = ($sorted_values[$mid-1] + $sorted_values[$mid])/2;
} 
$median = $median / 5;

print EXIT "\t$median";

my $median;
my $mid = int @DivTime/2;
my @sorted_values = sort {$a <=> $b} @DivTime;
if (@sorted_values % 2) {
    $median = $sorted_values[ $mid ];
} else {
    $median = ($sorted_values[$mid-1] + $sorted_values[$mid])/2;
}
$median = $median / 5;
print EXIT "\t$median";

my $total = 0;
    foreach $i (@NeOne) # iterate over the local copy ...
    { 
        $total += $i; # ...and sum up
    }
    $mean = $total / (5 * scalar(@NeOne));
    print EXIT "\t$mean";
my $total = 0;
    foreach $i (@NeTwo) # iterate over the local copy ...
    { 
        $total += $i; # ...and sum up
    }
    $mean = $total / (5 * scalar(@NeTwo));
    print EXIT "\t$mean";
my $total = 0;
    foreach $i (@DivTime) # iterate over the local copy ...
    { 
        $total += $i; # ...and sum up
    }
    $mean = $total / (5 * scalar(@DivTime));
    print EXIT "\t$mean";
for ($i = 5; $i <= 10; $i++){
$Averages[$i - 5] =  $Averages[$i - 5] / scalar(@DivTime);
print EXIT "\t$Averages[$i - 5]";
}
for ($i = 5; $i <= 10; $i++){
@Vector = ();
foreach $k (@LValues){
@SplitLine = split (/\s+/,$k);
push (@Vector, $SplitLine[$i]);
}
my @sorted_values = sort {$a <=> $b} @Vector;
if (@sorted_values % 2) {
    $median = $sorted_values[ $mid ];
} else {
    $median = ($sorted_values[$mid-1] + $sorted_values[$mid])/2;
}
 print EXIT "\t$median";
}
print EXIT "\n";
}


print EXIT "\n";

@DifThresholds = (0.1, 0.125, 0.15, 0.175, 0.2, 0.225 , 0.25, 0.275, 0.3);

foreach $Threshold (@DifThresholds){
print "$Threshold\n";
@LDistSims = ();
$File = "../../../../Results/ABCAnalysis/ParametersAndStatisticsNotCpG50000.txt";
@Averages = (0,0,0,0,0,0);

open (FILE,$File) or die "NO";

@NeOne = ();
@NeTwo = ();
@DivTime = ();
@LValues = ();

while (<FILE>){
chomp;
$Line = $_;
@LDistSims = split(/\s+/,$Line);
$MismatchStatistic = 0;
$Flag = 0;
for ($j = 0; $j < 6; $j++){
$Difference = abs($LDistData[$j] - $LDistSims[$j+5])/$LDistData[$j];
if ($Difference > $Threshold){
$Flag = 1;
}
}

if ($Flag == 1){
next;
}

push (@LValues, $Line);
for ($i = 5; $i <= 10; $i++){
$Averages[$i - 5] =  $Averages[$i - 5] + $LDistSims[$i];
}

push (@NeOne, $LDistSims[1]);
push (@NeTwo, $LDistSims[2]);
push (@DivTime, $LDistSims[3]);
}
close (FILE);

$ElementsRetained = scalar(@NeOne) ;

print EXIT "$Threshold";
my $median;
my $mid = int @NeOne/2;
my @sorted_values = sort {$a <=> $b} @NeOne;
if (@sorted_values % 2) {
    $median = $sorted_values[ $mid ];
} else {
    $median = ($sorted_values[$mid-1] + $sorted_values[$mid])/2;
}
$median = $median / 5;
print EXIT "\t$ElementsRetained\t$median";

my $median;
my $mid = int @NeTwo/2;
my @sorted_values = sort {$a <=> $b} @NeTwo;
if (@sorted_values % 2) {
    $median = $sorted_values[ $mid ];
} else {
    $median = ($sorted_values[$mid-1] + $sorted_values[$mid])/2;
}
$median = $median / 5;

print EXIT "\t$median";

my $median;
my $mid = int @DivTime/2;
my @sorted_values = sort {$a <=> $b} @DivTime;
if (@sorted_values % 2) {
    $median = $sorted_values[ $mid ];
} else {
    $median = ($sorted_values[$mid-1] + $sorted_values[$mid])/2;
}
$median = $median / 5;
print EXIT "\t$median";

my $total = 0;
    foreach $i (@NeOne) # iterate over the local copy ...
    { 
        $total += $i; # ...and sum up
    }
    $mean = $total / (5 * scalar(@NeOne));
    print EXIT "\t$mean";
my $total = 0;
    foreach $i (@NeTwo) # iterate over the local copy ...
    {
        $total += $i; # ...and sum up
    }
    $mean = $total / (5 * scalar(@NeTwo));
    print EXIT "\t$mean";
my $total = 0;
    foreach $i (@DivTime) # iterate over the local copy ...
    {
        $total += $i; # ...and sum up
    }
    $mean = $total / (5 * scalar(@DivTime));
    print EXIT "\t$mean";
for ($i = 5; $i <= 10; $i++){
$Averages[$i - 5] =  $Averages[$i - 5] / scalar(@DivTime);
print EXIT "\t$Averages[$i - 5]";
}
for ($i = 5; $i <= 10; $i++){
@Vector = ();
foreach $k (@LValues){
@SplitLine = split (/\s+/,$k);
push (@Vector, $SplitLine[$i]);
}
my @sorted_values = sort {$a <=> $b} @Vector;
if (@sorted_values % 2) {
    $median = $sorted_values[ $mid ];
} else {
    $median = ($sorted_values[$mid-1] + $sorted_values[$mid])/2;
}
 print EXIT "\t$median";
}
print EXIT "\n";

}

close (EXIT);
