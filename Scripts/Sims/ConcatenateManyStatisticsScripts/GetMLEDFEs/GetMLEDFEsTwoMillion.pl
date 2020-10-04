$LLValues = $ARGV[0];
$LLExit = $ARGV[1];

open (EXIT,">$LLExit") or die "NO!";

for ($i = 0; $i < 25 ; $i++){

$Start = $i * 20 + 1;
$End = ( $i + 1 ) * 20;

@LLs = ();

for ($k = 0; $k < 4200 ; $k++){
$LLs[$k] = 0;
}

for ($j = $Start; $j <= $End ; $j++){
$File = $LLValues.$j.".txt";
open (FILE,$File) or die "NO! $File";

while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
for ($k = 0; $k < 4200 ; $k++){
$LLs[$k] = $LLs[$k] + $SplitLine[$k];
}

}

close(FILE);
}

for ($k = 0; $k < 4200 ; $k++){
# print "$LLs[$k]\t";
}

# die "NO!";

$Max = $LLs[0];
$MaxK = 0;
for ($k = 0; $k < 4200 ; $k++){

if ($LLs[$k] > $Max){

$Max = $LLs[$k];
$MaxK = $k;

}
}
print EXIT "$MaxK\n";

}
