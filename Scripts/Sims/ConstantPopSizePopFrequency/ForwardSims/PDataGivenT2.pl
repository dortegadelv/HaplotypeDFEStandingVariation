### I am testing a function which will return the value of P(D2 | T2 ) given a set of haplotypes
# containing both the derived and the ancestral allele


@DummyHaplotypes = ();
push(@DummyHaplotypes,"100110");
push(@DummyHaplotypes,"101100");
push(@DummyHaplotypes,"110100");
push(@DummyHaplotypes,"110110");
push(@DummyHaplotypes,"001111");
push(@DummyHaplotypes,"001101");

@Positions = ();
push(@Positions,"10000");
push(@Positions,"20000");
push(@Positions,"30000");
push(@Positions,"40000");
push(@Positions,"50000");
push(@Positions,"60000");

$T2 = 100;
$r = 0.00000001;
$u = 0.00000001;
$NumberOfAncestralHaplotypes = 4;
$NumberOfDerivedHaplotypes = 4;

@Ps = CalculateP2 (\@DummyHaplotypes,$NumberOfAncestralHaplotypes);

$NumberOfP_Elements = scalar(@Ps);
print "Here! $NumberOfP_Elements\n";
$Counter = 0;
foreach $i (@Ps){

print "$Counter\t$i\n";
$Counter++;
}

$Probability = DataProb(\@DummyHaplotypes,$NumberOfAncestralHaplotypes,$NumberOfDerivedHaplotypes,$T2,$r,$u,\@Ps,\@Positions);

print "Prob $Probability\n";

sub DataProb {

my ($s_Haplotypes,$s_NancestralHaps,$s_NDerivedHaps,$s_T2,$s_r,$s_u,$sP2,$sPPos) = @_;

@States = ();

for ($j = 0; $j < 2; $j++){
$States[$j] = 0;
}

$NumberOfSites= length($s_Haplotypes->[0]);
$HaplotypeOne = $s_Haplotypes->[$NumberOfAncestralHaplotypes];
$HaplotypeTwo = $s_Haplotypes->[$NumberOfAncestralHaplotypes+1];
for ($i = 1; $i < $NumberOfSites; $i++){
$PositionForward = $sPPos ->[$i];
$PositionBefore = $sPPos ->[$i-1];
$Distances = $PositionForward - $PositionBefore;
print "Position = $PositionForward $PositionBefore\n";
# $HaplotypeOne = $s_Haplotypes->[$NumberOfAncestralHaplotypes];
# $HaplotypeTwo = $s_Haplotypes->[$NumberOfAncestralHaplotypes+1];
$SiteOne = substr($HaplotypeOne,$i,1);
$SiteTwo = substr($HaplotypeTwo,$i,1);
if ($i == 1){

if (($SiteOne eq $SiteTwo) && ($j == 0)){
$TransitionOne = log($States[0]) + log(exp(-2*$s_r*$Distances*$s_T2)) + log(exp(-2*$s_u*$s_T2));
$TransitionTwo = log($States[1]) + log( 1 - exp(-2*$s_r*$Distances*$s_T2)) + log(exp(-2*$s_u*$s_T2));
}elsif(($SiteOne eq $SiteTwo) && ($j == 1)){

}elsif(($SiteOne ne $SiteTwo) && ($j == 0)){

}elsif(($SiteOne ne $SiteTwo) && ($j == 1)){

}

}else{

for ($j = 0; $j < 2; $j++){
if (($SiteOne eq $SiteTwo) && ($j == 0)){
$TransitionOne = log($States[0]) + log(exp(-2*$s_r*$Distances*$s_T2)) + log(exp(-2*$s_u*$s_T2));
$TransitionTwo = log($States[1]) + log( 1 - exp(-2*$s_r*$Distances*$s_T2)) + log(exp(-2*$s_u*$s_T2));
}elsif(($SiteOne eq $SiteTwo) && ($j == 1)){

}elsif(($SiteOne ne $SiteTwo) && ($j == 0)){

}elsif(($SiteOne ne $SiteTwo) && ($j == 1)){

}
}
}}

return 0;
}

sub CalculateP2 {

my ($s_Haplotypes,$s_NancestralHaps) = @_;

@P2Values = ();

$NumberOfSites= length($s_Haplotypes->[0]);

print "Number of sites = $NumberOfSites\n";

for ($j = 0; $j < $NumberOfSites; $j++){
$CurrentNumberOfDerivedSites = 0;
for ($i = 0; $i < $s_NancestralHaps; $i++){

$CurrentNumberOfDerivedSites = $CurrentNumberOfDerivedSites + substr($s_Haplotypes->[$i],$j,1);

}
$P2Values[$j] = $CurrentNumberOfDerivedSites / $s_NancestralHaps;
}

return @P2Values;
}
