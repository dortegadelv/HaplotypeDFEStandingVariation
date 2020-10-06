open (COMP,">SynComparison.txt") or die "NO\n";

print "Syn comparison\n";
for ($i = 1; $i <= 100; $i++){
for ($j = $i + 1; $j <= 100; $j++){

@LDistribution = ();

$SynLDistFile = "LDistributionBootSyn".$i.".txt";

open (LDIST,$SynLDistFile) or die "NO!\n";

$SumOne = 0;
while (<LDIST>){
chomp;
$Line = $_;
$SumOne = $SumOne + $Line;
push (@LDistribution, $Line);
}
close (LDIST);

## PART TWO

@LDistributionTwo = ();

$SynLDistFile = "LDistributionBootSyn".$j.".txt";

open (LDIST,$SynLDistFile) or die "NO!\n";

$SumTwo = 0;
while (<LDIST>){
chomp;
$Line = $_;
$SumTwo = $SumTwo + $Line;
push (@LDistributionTwo, $Line);
}
close (LDIST);

$AbsDifference = 0;
for ($k = 0; $k < scalar(@LDistribution); $k++){

$ValueOne = $LDistribution[$k] / $SumOne;
$ValueTwo = $LDistributionTwo[$k] / $SumTwo;

$AbsDifference = $AbsDifference + abs($ValueOne - $ValueTwo);
}

print COMP "$AbsDifference\n";

}
}

close (COMP);
### NS Comparison

open (COMP,">NSComparison.txt") or die "NO\n";

print "NS comparison\n";

for ($i = 1; $i <= 100; $i++){
for ($j = $i + 1; $j <= 100; $j++){

@LDistribution = ();

$SynLDistFile = "LDistributionBootNS".$i.".txt";

open (LDIST,$SynLDistFile) or die "NO!\n";

$SumOne = 0;
while (<LDIST>){
chomp;
$Line = $_;
$SumOne = $SumOne + $Line;
push (@LDistribution, $Line);
}
close (LDIST);

## PART TWO

@LDistributionTwo = ();

$SynLDistFile = "LDistributionBootNS".$j.".txt";

open (LDIST,$SynLDistFile) or die "NO!\n";

$SumTwo = 0;
while (<LDIST>){
chomp;
$Line = $_;
$SumTwo = $SumTwo + $Line;
push (@LDistributionTwo, $Line);
}
close (LDIST);
#
$AbsDifference = 0;
for ($k = 0; $k < scalar(@LDistribution); $k++){

$ValueOne = $LDistribution[$k] / $SumOne;
$ValueTwo = $LDistributionTwo[$k] / $SumTwo;

$AbsDifference = $AbsDifference + abs($ValueOne - $ValueTwo);
}

print COMP "$AbsDifference\n";

}
}
close (COMP);

## NS vs syn

print "NS vs Syn comparison\n";

open (COMP,">NSvsSynComparison.txt") or die "NO\n";

for ($i = 1; $i <= 100; $i++){
for ($j = $i + 1; $j <= 100; $j++){

@LDistribution = ();

$SynLDistFile = "LDistributionBootSyn".$i.".txt";

open (LDIST,$SynLDistFile) or die "NO!\n";

$SumOne = 0;
while (<LDIST>){
chomp;
$Line = $_;
$SumOne = $SumOne + $Line;
push (@LDistribution, $Line);
}
close (LDIST);


@LDistributionTwo = ();

$SynLDistFile = "LDistributionBootNS".$j.".txt";

open (LDIST,$SynLDistFile) or die "NO!\n";

$SumTwo = 0;
while (<LDIST>){
chomp;
$Line = $_;
$SumTwo = $SumTwo + $Line;
push (@LDistributionTwo, $Line);
}
close (LDIST);

$AbsDifference = 0;
for ($k = 0; $k < scalar(@LDistribution); $k++){

$ValueOne = $LDistribution[$k] / $SumOne;
$ValueTwo = $LDistributionTwo[$k] / $SumTwo;

$AbsDifference = $AbsDifference + abs($ValueOne - $ValueTwo);
}

print COMP "$AbsDifference\n";

}
}
close (COMP);



