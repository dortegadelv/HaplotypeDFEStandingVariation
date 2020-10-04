open ( QUANT,"QuantileToPrint.txt") or die "NO!";
@Quantiles = ();
$QuantileNumber = 0;
while (<QUANT>){
chomp;
$Line = $_;
push(@Quantiles, $Line );
}
close (QUANT);

@RecRates = ();

open (FILE,"RecRateMissenseOnePercentRightNoCpG.txt") or die "NO!";

while (<FILE>){
chomp;
$Line = $_;
push (@RecRates, $Line);
}
close (FILE);

open (FILE,"RecRateMissenseOnePercentLeftNoCpG.txt") or die "NO!";

while (<FILE>){
chomp;
$Line = $_;
push (@RecRates, $Line);
}
close (FILE);

open (QUANTILE,"../../UK10K_PointTwoPercenters/ForwardSims/MissenseOnePercentNoCpG.txt") or die "NO Q$QuantilesFile\n";

@QuantileRec = ();
while (<QUANTILE>){
chomp;
$Line = $_;
push (@QuantileRec, $Line );
}

close (QUANTILE);

print "Finished getting data\n";

@Distances = ();
for ( $QuantTest = 0 ; $QuantTest < 21 ; $QuantTest++ ){
for ( $Window = 0 ; $Window < 6 ; $Window++ ){
$Distances[$QuantTest][$Window] = 0;
}
}

for ($i = 1; $i <= 500; $i++){
$QuantileNumber = 0;
$File = "../../../../Results/UK10K/ForwardSims/4Ns_-50/SimDistancesMssel273_".$i.".txt";
print "$File\n";
open (FILE, $File) or die "NO!";
$LineNumber = 0;
$PrintFlag = 0;
while (<FILE>){
chomp;
$Line = $_;

$IntervalFlag = 0;
for ($j = 0; $j < 5; $j++){
if ( ($Line >= ( 0.2 * $j )) && ($Line <= (0.2 * ($j + 1)) )){
$IntervalFlag = 1;
last;
}
}

if ($IntervalFlag == 0){
$j = 5;
}

if ($LineNumber % 2556 == 0){
$RecNum = int ($LineNumber / 2556 + 0.5);
# print "Rec num = $RecNum\t";
$CurrentRec = $RecRates[$RecNum];

# $RecRate = $CurrentRec * .01 * 4*$LastPopSize*250000;
$RecRate = $CurrentRec;
# print "rec rate = $RecRate\n";
# $QuantileLeft = $Quantiles[$QuantileNumber];
# $QuantileNumber++;

for ( $QuantTest = 0 ; $QuantTest < 20 ; $QuantTest++ ){
$MidPoint = ( $QuantileRec[$QuantTest+1] - $QuantileRec[$QuantTest]) / 2 + $QuantileRec[$QuantTest] ;
if ( ( $RecRate <= ($MidPoint)) && ($RecRate >= $QuantileRec[$QuantTest]  )){
$QuantileLeft = $QuantTest;
}
if ( ( $RecRate > ($MidPoint)) && ($RecRate <= $QuantileRec[$QuantTest+1]  )){
$QuantileLeft = $QuantTest + 1;
}
}
$QuantileLeft = $Quantiles[$QuantileNumber] - 1;
$QuantileNumber++;
# print "QL = $QuantileLeft Q = $QuantileRec[$QuantileLeft] Recrate = $RecRate\n";
# die "NO\n";
if ($QuantileRec[$QuantileLeft] == 0){
$DifCheck = abs($RecRate - $QuantileRec[$QuantileLeft]);
}else{
$DifCheck = abs($RecRate - $QuantileRec[$QuantileLeft])/$QuantileRec[$QuantileLeft];
}
if (abs($DifCheck) < 0.0000001){
$PrintFlag = 1;
}else{
$PrintFlag = 0;
}

# $QuantileLeft = $Quantiles[$QuantileNumber];
# $QuantileNumber++;

# print "Q left = $QuantileLeft\n";
}
# if ($PrintFlag == 1){
$Distances[$QuantileLeft][$j]++;
# }
$LineNumber++;
}
# die "NO!\n";
close (FILE);
}

for ( $QuantTest = 0 ; $QuantTest < 21 ; $QuantTest++ ){
for ( $Window = 0 ; $Window < 6 ; $Window++ ){
print "$Distances[$QuantTest][$Window]\t";
}
print "\n";
}


