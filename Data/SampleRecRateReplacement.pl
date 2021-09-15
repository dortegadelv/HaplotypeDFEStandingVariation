@LeftRecRates = ();
@RightRecRates = ();

open (LEFT, "LeftBpRecRatePerVariantNoCpGSynonymous.txt") or die "NO";

while (<LEFT>){
chomp;
    $Line = $_;
    @SplitLine = split(/\s+/, $Line);
    push (@LeftRecRates, $SplitLine[0]);
}
close (LEFT);

open (LEFT, "RightBpRecRatePerVariantNoCpGSynonymous.txt") or die "NO";

while (<LEFT>){
chomp;
    $Line = $_;
    @SplitLine = split(/\s+/, $Line);
    push (@RightRecRates, $SplitLine[0]);
}
close (LEFT);

@AverageRecRates = ();

for ($i = 0; $i < scalar(@RightRecRates); $i++){
    
    $Average = ($LeftRecRates[$i] + $RightRecRates[$i])/2;
    push (@AverageRecRates, $Average);
}

open (SAMPLE, ">ResampledBpRecRatePerVariantNoCpGSynonymous.txt") or die "NO!";
for ($i = 0; $i < 150; $i++){
    
    $Rand = rand(scalar(@RightRecRates));
    print SAMPLE "$AverageRecRates[$Rand]\n";
}
