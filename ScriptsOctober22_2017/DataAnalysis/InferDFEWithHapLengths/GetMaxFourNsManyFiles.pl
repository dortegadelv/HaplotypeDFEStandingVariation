@MutRate = ();
@ErrorRate = ();
@RecRate = ();

push (@MutRate,"0.000000012");
push (@MutRate,"0.000000015");
push (@MutRate,"0.00000002");

push (@ErrorRate,"0.0");
push (@ErrorRate,"0.000005");
push (@ErrorRate,"0.0000075");
push (@ErrorRate,"0.00001");

push (@RecRate,"0.0000000025");
push (@RecRate,"0.0000000075");
push (@RecRate,"0.0000000125");
push (@RecRate,"0.0000000234");

$Max = -99999999999999999999;
for ($i = 0; $i < 3; $i++){

for ($j = 0; $j < 4; $j++){

for ($k = 0; $k < 4; $k++){
if ( $k == 0 ){
$Number = $k;
$File = "../../../Results/UK10K/ImportanceSamplingSimsErrorRate".$ErrorRate[$j]."MutRate".$MutRate[$i]."RecRate".$RecRate[$k]."/ExitFileGroup".$Number.".txt";
@SumLLs = ();
open (FILE,$File) or die "NO! $File\n";
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$Count = 0;
foreach $Element (@SplitLine){
push (@SumLLs, $Element);
}}

close (FILE);
}else{
$Number = $k;
$File = "../../../Results/UK10K/ImportanceSamplingSimsErrorRate".$ErrorRate[$j]."MutRate".$MutRate[$i]."RecRate".$RecRate[$k]."/ExitFileGroup".$Number.".txt";
# @SumLLs = ();
open (FILE,$File) or die "NO! $File\n";
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$Count = 0;
for ($Element = 0; $Element < scalar(@SplitLine); $Element++){
$SumLLs[$Element] = $SumLLs[$Element] + $SplitLine[$Element];
$Count++;
}
}
close (FILE);
}}
# die "NO!";
for ($Element = 0; $Element < scalar(@SplitLine); $Element++){
if ($SumLLs[$Element] > $Max){
$Max = $SumLLs[$Element];
$MaxI = $i;
$MaxJ = $j;
$MaxCount = $Element;
}
}

}}

print "$Max $MaxI $MaxJ $MaxCount\n";

