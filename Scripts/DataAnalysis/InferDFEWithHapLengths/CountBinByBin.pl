$VariantsHere = 0;

@BinCount = ();

for ($i = 0; $i < 6 ; $i++){
push(@BinCount,"0");
}

for ($i = 0; $i <= 628 ; $i++){
$VariantsHere++;
$File = "../../../Data/Plink/HapLengths/HapLength".$i.".txt";
open (FILE,$File) or die "NO! $File";
while (<FILE>){
chomp;
$Line = $_;
if ( ( $Line >= 0 ) && ( $Line <= 50000) ){
$BinCount[0]++;
}
elsif ( ( $Line >= 50000 ) && ( $Line <= 100000) ){
$BinCount[1]++;
}
elsif ( ( $Line >= 100000 ) && ( $Line <= 150000) ){
$BinCount[2]++;
}
elsif ( ( $Line >= 150000 ) && ( $Line <= 200000) ){
$BinCount[3]++;
}
elsif ( ( $Line >= 200000 ) && ( $Line <= 250000) ){
$BinCount[4]++;
}
elsif ( ( $Line >= 250000 ) ){
$BinCount[5]++;
}

}

close (FILE);
}

$TotalFrequency = 0;

for ($i = 0; $i < 6 ; $i++){
$TotalFrequency= $TotalFrequency + $BinCount[$i];
}
print "Using all lengths $VariantsHere\n";
for ($i = 0; $i < 6 ; $i++){
$BinFrequency = $BinCount[$i] / $TotalFrequency;
print "$i\t$BinFrequency\n";
}
for ($i = 0; $i < 6 ; $i++){
$BinFrequency = $BinCount[$i] / $TotalFrequency;
print "$BinFrequency\t";
}
print "\n";
###
$VariantsHere = 0;
open (EXCLUSION,"../../../Data/VariantNumber.txt") or die "NO!";
@VariantsToExclude = ();

while (<EXCLUSION>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@VariantsToExclude,$Line);
}

close(EXCLUSION);

@BinCount = ();

for ($i = 0; $i < 6 ; $i++){
push(@BinCount,"0");
}

for ($i = 0; $i <= 628 ; $i++){

$Flag = 0;

foreach $Var (@VariantsToExclude){
if ($Var eq $i){
$Flag = 1;
last;
}
}
if ($Flag == 1){
next;
}
$VariantsHere++;
$File = "../../../Data/Plink/HapLengths/HapLength".$i.".txt";
open (FILE,$File) or die "NO!";
while (<FILE>){
chomp;
$Line = $_;
if ( ( $Line >= 0 ) && ( $Line <= 50000) ){
$BinCount[0]++;
}
elsif ( ( $Line >= 50000 ) && ( $Line <= 100000) ){
$BinCount[1]++;
}
elsif ( ( $Line >= 100000 ) && ( $Line <= 150000) ){
$BinCount[2]++;
}
elsif ( ( $Line >= 150000 ) && ( $Line <= 200000) ){
$BinCount[3]++;
}
elsif ( ( $Line >= 200000 ) && ( $Line <= 250000) ){
$BinCount[4]++;
}
elsif ( ( $Line >= 250000 ) ){
$BinCount[5]++;
}

}

close (FILE);
}

$TotalFrequency = 0;

for ($i = 0; $i < 6 ; $i++){
$TotalFrequency= $TotalFrequency + $BinCount[$i];
}
print "Using good site lengths $VariantsHere\n";
for ($i = 0; $i < 6 ; $i++){
$BinFrequency = $BinCount[$i] / $TotalFrequency;
print "$i\t$BinFrequency\t$BinCount[$i]\n";
}
for ($i = 0; $i < 6 ; $i++){
$BinFrequency = $BinCount[$i] / $TotalFrequency;
print "$BinFrequency\t";
}
print "\n";

### Low Rec rate

$VariantsHere = 0;
open (EXCLUSION,"../../../Data/VariantNumber.txt") or die "NO!";
@VariantsToExclude = ();

while (<EXCLUSION>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@VariantsToExclude,$Line);
}

close(EXCLUSION);

open (RECRATE,"../../../Data/BpRecRatePerVariant.txt") or die "NO!";
@RecRatePerBp = ();
$CurVarCount = -1;
while ( <RECRATE>){
chomp;
$Line = $_;
push (@RecRatePerBp,$Line);
}

close (RECRATE);

@BinCount = ();

for ($i = 0; $i < 6 ; $i++){
push(@BinCount,"0");
}

for ($i = 0; $i <= 628 ; $i++){

$Flag = 0;

foreach $Var (@VariantsToExclude){
if ($Var eq $i){
$Flag = 1;
last;
}
}
if ($Flag == 1){
next;
}
$CurVarCount++;
if ($RecRatePerBp[$CurVarCount] > 0.0000005){
next;
}
$VariantsHere++;
$File = "../../../Data/Plink/HapLengths/HapLength".$i.".txt";
open (FILE,$File) or die "NO!";
while (<FILE>){
chomp;
$Line = $_;
if ( ( $Line >= 0 ) && ( $Line <= 50000) ){
$BinCount[0]++;
}
elsif ( ( $Line >= 50000 ) && ( $Line <= 100000) ){
$BinCount[1]++;
}
elsif ( ( $Line >= 100000 ) && ( $Line <= 150000) ){
$BinCount[2]++;
}
elsif ( ( $Line >= 150000 ) && ( $Line <= 200000) ){
$BinCount[3]++;
}
elsif ( ( $Line >= 200000 ) && ( $Line <= 250000) ){
$BinCount[4]++;
}
elsif ( ( $Line >= 250000 ) ){
$BinCount[5]++;
}

}

close (FILE);
}

$TotalFrequency = 0;

for ($i = 0; $i < 6 ; $i++){
$TotalFrequency= $TotalFrequency + $BinCount[$i];
}
print "Using good site lengths Rec Rate < 5e-7 $VariantsHere\n";
for ($i = 0; $i < 6 ; $i++){
$BinFrequency = $BinCount[$i] / $TotalFrequency;
print "$i\t$BinFrequency\t$BinCount[$i]\n";
}
for ($i = 0; $i < 6 ; $i++){
$BinFrequency = $BinCount[$i] / $TotalFrequency;
print "$BinFrequency\t";
}
print "\n";

### High Rec rate


open (EXCLUSION,"../../../Data/VariantNumber.txt") or die "NO!";
@VariantsToExclude = ();
$VariantsHere = 0;
while (<EXCLUSION>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@VariantsToExclude,$Line);
}

close(EXCLUSION);

open (RECRATE,"../../../Data/BpRecRatePerVariant.txt") or die "NO!";
@RecRatePerBp = ();
$CurVarCount = -1;
while ( <RECRATE>){
chomp;
$Line = $_;
push (@RecRatePerBp,$Line);
}

close (RECRATE);

@BinCount = ();

for ($i = 0; $i < 6 ; $i++){
push(@BinCount,"0");
}

for ($i = 0; $i <= 628 ; $i++){

$Flag = 0;

foreach $Var (@VariantsToExclude){
if ($Var eq $i){
$Flag = 1;
last;
}
}
if ($Flag == 1){
next;
}
$CurVarCount++;
if ($RecRatePerBp[$CurVarCount] < 0.000002){
next;
}
$VariantsHere++;
$File = "../../../Data/Plink/HapLengths/HapLength".$i.".txt";
open (FILE,$File) or die "NO!";
while (<FILE>){
chomp;
$Line = $_;
if ( ( $Line >= 0 ) && ( $Line <= 50000) ){
$BinCount[0]++;
}
elsif ( ( $Line >= 50000 ) && ( $Line <= 100000) ){
$BinCount[1]++;
}
elsif ( ( $Line >= 100000 ) && ( $Line <= 150000) ){
$BinCount[2]++;
}
elsif ( ( $Line >= 150000 ) && ( $Line <= 200000) ){
$BinCount[3]++;
}
elsif ( ( $Line >= 200000 ) && ( $Line <= 250000) ){
$BinCount[4]++;
}
elsif ( ( $Line >= 250000 ) ){
$BinCount[5]++;
}

}

close (FILE);
}

$TotalFrequency = 0;

for ($i = 0; $i < 6 ; $i++){
$TotalFrequency= $TotalFrequency + $BinCount[$i];
}
print "Using good site lengths Rec rate > 2e-6 $VariantsHere\n";
for ($i = 0; $i < 6 ; $i++){
$BinFrequency = $BinCount[$i] / $TotalFrequency;
print "$i\t$BinFrequency\t$BinCount[$i]\n";
}
for ($i = 0; $i < 6 ; $i++){
$BinFrequency = $BinCount[$i] / $TotalFrequency;
print "$BinFrequency\t";
}
print "\n";


### Low Rec rate

$VariantsHere = 0;
open (EXCLUSION,"../../../Data/VariantNumber.txt") or die "NO!";
@VariantsToExclude = ();

while (<EXCLUSION>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@VariantsToExclude,$Line);
}

close(EXCLUSION);

open (RECRATE,"../../../Data/BpRecRatePerVariant.txt") or die "NO!";
@RecRatePerBp = ();
$CurVarCount = -1;
while ( <RECRATE>){
chomp;
$Line = $_;
push (@RecRatePerBp,$Line);
}

close (RECRATE);

@BinCount = ();

for ($i = 0; $i < 6 ; $i++){
push(@BinCount,"0");
}

for ($i = 0; $i <= 628 ; $i++){

$Flag = 0;

foreach $Var (@VariantsToExclude){
if ($Var eq $i){
$Flag = 1;
last;
}
}
if ($Flag == 1){
next;
}
$CurVarCount++;
if ($RecRatePerBp[$CurVarCount] > 0.00000025){
next;
}
$VariantsHere++;
$File = "../../../Data/Plink/HapLengths/HapLength".$i.".txt";
open (FILE,$File) or die "NO!";
while (<FILE>){
chomp;
$Line = $_;
if ( ( $Line >= 0 ) && ( $Line <= 50000) ){
$BinCount[0]++;
}
elsif ( ( $Line >= 50000 ) && ( $Line <= 100000) ){
$BinCount[1]++;
}
elsif ( ( $Line >= 100000 ) && ( $Line <= 150000) ){
$BinCount[2]++;
}
elsif ( ( $Line >= 150000 ) && ( $Line <= 200000) ){
$BinCount[3]++;
}
elsif ( ( $Line >= 200000 ) && ( $Line <= 250000) ){
$BinCount[4]++;
}
elsif ( ( $Line >= 250000 ) ){
$BinCount[5]++;
}

}

close (FILE);
}

$TotalFrequency = 0;

for ($i = 0; $i < 6 ; $i++){
$TotalFrequency= $TotalFrequency + $BinCount[$i];
}
print "Using good site lengths Rec Rate < 2.5e-7 $VariantsHere\n";
for ($i = 0; $i < 6 ; $i++){
$BinFrequency = $BinCount[$i] / $TotalFrequency;
print "$i\t$BinFrequency\t$BinCount[$i]\n";
}

for ($i = 0; $i < 6 ; $i++){
$BinFrequency = $BinCount[$i] / $TotalFrequency;
print "$BinFrequency\t";
}
print "\n";

