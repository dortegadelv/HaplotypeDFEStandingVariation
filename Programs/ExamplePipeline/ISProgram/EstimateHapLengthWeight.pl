$WeightFile = $ARGV[0];
$HapFile = $ARGV[1];
$ExpectedValuesFile = $ARGV[2];
$SDFile = $ARGV[3];


open (FILE,$WeightFile) or die "Cannot open file $WeightFile";

@Weights = ();
@HapLengths = ();

while (<FILE>){

	chomp;
	$Line = $_;
	push(@Weights, $Line);
}

close(FILE);

# die "NO!";

open (HAP,$HapFile) or die "NO!";

while(<HAP>){
chomp;
$Line = $_;
push(@HapLengths,$Line);
}

close(HAP);


@ExpectedValuesHapLengths = ();
@ExpectedSquaredValuesHapLengths = ();
@WeightSums = ();
@TestLineOne = split(/\s+/,$Weights[0]);
@TestLineTwo = split(/\s+/,$HapLengths[0]);

for ( $i = 0; $i < scalar(@TestLineOne) ; $i++){
$WeightSums[$i] = 0;
}

for ( $i = 0; $i < scalar(@TestLineOne) ; $i++){
for ( $j = 0; $j < scalar(@TestLineTwo) ; $j++){
$ExpectedValuesHapLengths[$i][$j] = 0;
$ExpectedSquaredValuesHapLengths[$i][$j] = 0;
}
}

for ($Row = 0; $Row < scalar(@Weights); $Row++){

@LineOfWeightsSplitted = split(/\s+/,$Weights[$Row]);
@LineOfHapLengthsSplitted = split(/\s+/,$HapLengths[$Row]);

for ($i = 0; $i < scalar(@LineOfWeightsSplitted); $i++){
$WeightSums[$i] = $WeightSums[$i] + $LineOfWeightsSplitted[$i];
for ($j = 0; $j < scalar(@LineOfHapLengthsSplitted); $j++){
$ExpectedValuesHapLengths[$i][$j] = $ExpectedValuesHapLengths[$i][$j] + $LineOfWeightsSplitted[$i]*$LineOfHapLengthsSplitted[$j];
$ExpectedSquaredValuesHapLengths[$i][$j] = $ExpectedSquaredValuesHapLengths[$i][$j] + $LineOfWeightsSplitted[$i]*$LineOfHapLengthsSplitted[$j]*$LineOfHapLengthsSplitted[$j];
}
}
}

open (EXIT,">$ExpectedValuesFile") or die "Cannot create file $ExpectedValuesFile";

for ($i = 0; $i < scalar(@LineOfWeightsSplitted); $i++){
for ($j = 0; $j < scalar(@LineOfHapLengthsSplitted); $j++){
$ExpectedValuesHapLengths[$i][$j] = $ExpectedValuesHapLengths[$i][$j] / $WeightSums[$i];
$ExpectedSquaredValuesHapLengths[$i][$j] = $ExpectedSquaredValuesHapLengths[$i][$j] / $WeightSums[$i];
if ($j < ( scalar(@LineOfHapLengthsSplitted) - 1 )){
print EXIT "$ExpectedValuesHapLengths[$i][$j]\t";
}else{
print EXIT "$ExpectedValuesHapLengths[$i][$j]";
}
}
print EXIT "\n";
}
close(EXIT);

open (EXIT,">$SDFile") or die "Cannot create file $SDFile\n";

@SD = ();
for ($i = 0; $i < scalar(@LineOfWeightsSplitted); $i++){
for ($j = 0; $j < scalar(@LineOfHapLengthsSplitted); $j++){
$SD[$i][$j] = ( $ExpectedSquaredValuesHapLengths[$i][$j] - $ExpectedValuesHapLengths[$i][$j]*$ExpectedValuesHapLengths[$i][$j]) ** (1/2);

if ($j < ( scalar(@LineOfHapLengthsSplitted) - 1 )){
print EXIT "$SD[$i][$j]\t";
}else{
print EXIT "$SD[$i][$j]";
}
}
print EXIT "\n";
}


