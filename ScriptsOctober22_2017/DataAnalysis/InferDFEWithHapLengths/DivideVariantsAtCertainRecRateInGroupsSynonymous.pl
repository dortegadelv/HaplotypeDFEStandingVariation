open (INCVAR,"../../../Data/VariantNumberToIncludeSynonymous.txt") or die "NO!";
%VariantsToInclude = ();
$LineNumber = 0;
while (<INCVAR>){
chomp;
$Line = $_;
$VariantsToInclude{$LineNumber} = $Line;
$LineNumber++;
}

close (INCVAR);

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
@Groups = ();
for ($i = 0; $i < (scalar( @FrequencyBounds ) - 1 ); $i++){
$FrequencyCounts[$i] = 0;
$MeanValues[$i] = 0;
$Groups[$i] = "";
}

open (RECDATA,"../../../Data/BpRecRatePerVariantSynonymous.txt") or die "NO!";

$LineNumber = 0;
while (<RECDATA>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ($i = 0; $i < (scalar( @FrequencyBounds ) - 1 ); $i++){
if ( ( $Line >= $FrequencyBounds[$i] ) && ( $Line <= $FrequencyBounds[$i+1]  ) ){
$FrequencyCounts[$i]++;
$MeanValues[$i] = $MeanValues[$i] + $Line;
$Groups[$i] = $Groups[$i]." $LineNumber";
}
}
# print "$Line\n";
$LineNumber++;
}

close (RECDATA);

for ($i = 0; $i < (scalar( @FrequencyBounds ) - 1 ); $i++){

$MeanValues[$i] = $MeanValues[$i] / $FrequencyCounts[$i];
print "$FrequencyBounds[$i]\t$FrequencyBounds[$i+1]\t$FrequencyCounts[$i]\t$MeanValues[$i]\n";
@AllElements = split(/\s+/,$Groups[$i]);
print "The number of elements is $Length\n";
$Groups = "../../../Data/GroupsPerRecRateSynonymous".$i.".txt";
open (GROUP,">$Groups") or die "NO!";
foreach $Element (@AllElements){
print GROUP "$Element\t$VariantsToInclude{$Element}\n";
}
close (GROUP);
}

