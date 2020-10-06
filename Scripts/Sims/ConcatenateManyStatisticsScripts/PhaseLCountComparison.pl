@DemographicScenarios = ();
@FourNsValues = ();

push (@DemographicScenarios,"ConstantPopSize");
push (@DemographicScenarios,"PopExpansion");

push (@FourNsValues,"4Ns_0");
push (@FourNsValues,"4Ns_50");
push (@FourNsValues,"4Ns_100");
push (@FourNsValues,"4Ns_-50");
push (@FourNsValues,"4Ns_-100");

for ($i = 0; $i <= 1; $i++){
for ($j = 0; $j <= 4; $j++){

$ExitFile = "../../../Results/PhaseLDistribution/LDistributionStatPhased".$DemographicScenarios[$i]."_".$FourNsValues[$j].".txt";
open (EXIT,">$ExitFile") or die "NO!";
print "$ExitFile\n";
for ($k = 0; $k < 100; $k++){

$FileOne = "../../../Results/".$DemographicScenarios[$i]."/ForwardSims/".$FourNsValues[$j]."/HapLengths/HapLengthsLessStatPhase".$k.".txt";
open (FILE,$FileOne) or die "NO!";

@Counts = ();
for ($l = 0; $l <= 5; $l++){
$Counts[$l] = 0;
}

while (<FILE>){
chomp;
$Line = $_;
$Flag = 0;
for ($l = 0; $l < 5; $l++){
if (($Line >= ($l * 0.2)) && (  $Line <= (($l+1) * 0.2))){
$Counts[$l]++;
$Flag = 1;
break;
}
}
if ($Flag == 0){
$Counts[5]++;
}
}

close (FILE);

for ($l = 0; $l <= 5; $l++){
print EXIT "$Counts[$l]\t";
}
# print EXIT "\n";

$FileOne = "../../../Results/".$DemographicScenarios[$i]."/ForwardSims/".$FourNsValues[$j]."/HapLengths/HapLengthsLessStatPhase".$k.".txt";
$HeadLineNumber = ($k + 1 ) * 1560;
open (FILE,"head -n$HeadLineNumber ../../../Results/$DemographicScenarios[$i]/ForwardSims/$FourNsValues[$j]/HapLengths/HapLengthsLessUnphased1.txt | tail -n1560 |") or die "NO!";

@Counts = ();
for ($l = 0; $l <= 5; $l++){
$Counts[$l] = 0;
}

while (<FILE>){
chomp;
$Line = $_;
$Flag = 0;
for ($l = 0; $l < 5; $l++){
if (($Line >= ($l * 0.2)) && (  $Line <= (($l+1) * 0.2))){
$Counts[$l]++;
$Flag = 1;
break;
}
}
if ($Flag == 0){
$Counts[5]++;
}
}

close (FILE);

for ($l = 0; $l <= 5; $l++){
print EXIT "$Counts[$l]\t";
}
print EXIT "\n";

}
close (EXIT);

}
}

