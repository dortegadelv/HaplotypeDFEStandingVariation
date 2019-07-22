@HapLengths = ();
push(@HapLengths,"1466598");
push(@HapLengths,"566434");
push(@HapLengths,"278080");
push(@HapLengths,"146893");
push(@HapLengths,"93553");
push(@HapLengths,"266718");

@ErrorRate = ();

push (@ErrorRate,"0.0");
push (@ErrorRate,"0.000005");
push (@ErrorRate,"0.0000075");
push (@ErrorRate,"0.00001");

@MutRate = ();

push (@MutRate,"0.000000012");
push (@MutRate,"0.000000015");
push (@MutRate,"0.00000002");

for ($i = 0; $i < 3; $i++){
for ($j = 0; $j < 4; $j++){
$Directory = "../../../../../Results/UK10K/ImportanceSamplingSimsErrorRate".$ErrorRate[$j]."MutRate".$MutRate[$i]."/TableToTest.txt";
open (FILE,$Directory) or die "NO! $Directory\n";
print "$i and $j\n";
$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

if ($LineNumber >= 2){
$CurrentLL = 0;
for ($CurHap = 0; $CurHap < 6; $CurHap++){
$CurrentLL = $CurrentLL + $HapLengths[$CurHap]*log($SplitLine[$CurHap+1]);
}
if ($i ==0 && $j == 0 && $LineNumber == 2){
$BestLL = $CurrentLL;
$CoordinatesBestLL = $i.".".$j.".".$LineNumber;
}
if ($CurrentLL > $BestLL){
print "Here?\n";
$BestLL = $CurrentLL;
$CoordinatesBestLL = $i.".".$j.".".$LineNumber;
}
}
$LineNumber++;
}
close (FILE);
}
}

print "BestLL = $BestLL and Coordinates = $CoordinatesBestLL\n";
