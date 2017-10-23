open (RECRATEFREQ,"RecRateFreq.txt") or die "NO!";

@FrequencyBounds = ();
while (<RECRATEFREQ>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@FrequencyBounds,$Line);
print "$Line\n";
}

close (RECRATEFREQ);

@FrequencyCounts = ();
@MeanValues = ();
for ($i = 0; $i < (scalar( @FrequencyBounds ) - 1 ); $i++){
$FrequencyCounts[$i] = 0;
$MeanValues[$i] = 0;
}

open (RECDATA,"../../../Data/BpRecRatePerVariant.txt") or die "NO!";

while (<RECDATA>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ($i = 0; $i < (scalar( @FrequencyBounds ) - 1 ); $i++){
if ( ( $Line >= $FrequencyBounds[$i] ) && ( $Line <= $FrequencyBounds[$i+1]  ) ){
$FrequencyCounts[$i]++;
$MeanValues[$i] = $MeanValues[$i] + $Line;
}
}
# print "$Line\n";
}

close (RECDATA);

for ($i = 0; $i < (scalar( @FrequencyBounds ) - 1 ); $i++){

$MeanValues[$i] = $MeanValues[$i] / $FrequencyCounts[$i];
print "$FrequencyBounds[$i]\t$FrequencyBounds[$i+1]\t$FrequencyCounts[$i]\t$MeanValues[$i]\n";
}

