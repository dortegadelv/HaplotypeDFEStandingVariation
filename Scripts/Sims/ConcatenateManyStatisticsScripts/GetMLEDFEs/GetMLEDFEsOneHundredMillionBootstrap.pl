$LLValues = $ARGV[0];
$LLExit = $ARGV[1];
@FullLLMatrix = $ARGV[2];
open (EXIT,">$LLExit") or die "NO!";

for ($i = 0; $i < 1 ; $i++){

$Start = $i * 10000 + 1;
$End = ( $i + 1 ) * 10000;

@LLs = ();

for ($k = 0; $k < 2100 ; $k++){
$LLs[$k] = 0;
}

for ($j = $Start; $j <= $End ; $j++){
$File = $LLValues.$j.".txt";
open (FILE,$File) or die "NO! $File";

while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ($k = 0; $k < 2100 ; $k++){
$LLs[$k] = $LLs[$k] + $SplitLine[$k];
}
}
for ($k = 0; $k < 2100 ; $k++){
$FullLLMatrix[$j][$k] = $LLs[$k];
}
close(FILE);
}
# die "Enough!\n";
for ($k = 0; $k < 2100 ; $k++){
# print "$LLs[$k]\t";
}
$Max = $LLs[0];
$MaxK = 0;
for ($k = 0; $k < 2100 ; $k++){
if ($LLs[$k] > $Max){
$Max = $LLs[$k];
$MaxK = $k;
}
}
print EXIT "$MaxK\n";
}


for ($i = 0; $i < 100 ; $i++){
print "Bootstrap replicate = $i\n";
@LLs = ();

for ($k = 0; $k < 2100 ; $k++){
$LLs[$k] = 0;
}

for ($j = 0; $j < 10000; $j++){
$RandomFileNumber = int(rand(10000)) + 1;
for ($k = 0; $k < 2100 ; $k++){
$LLs[$k] = $LLs[$k] + $FullLLMatrix[$RandomFileNumber][$k];
}
}
$Max = $LLs[0];
$MaxK = 0;
for ($k = 0; $k < 2100 ; $k++){
if ($LLs[$k] > $Max){
$Max = $LLs[$k];
$MaxK = $k;
}
}
print EXIT "$MaxK\n";

}
close (EXIT);
