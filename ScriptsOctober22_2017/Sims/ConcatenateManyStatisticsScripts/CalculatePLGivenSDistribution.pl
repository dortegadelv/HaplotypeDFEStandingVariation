$ExitDistribution = $ARGV[0];
$Start = $ARGV[1];
$End = $ARGV[2];
$FilesPrefix = $ARGV[3];

$CountNumber = 0;
@LDistribution = ();
for ($i = 0; $i <= 5;$i++){
$LDistribution[$i] = 0;
}

open (EXIT,">>$ExitDistribution") or die "NO!";

for ($i = $Start ; $i <= $End ; $i++ ) {
$File = $FilesPrefix.$i.".txt";
open (FILE,$File) or die "NO! $File";

while (<FILE>){
chomp;
$Line = $_;
if ($Line eq "2.0"){
$LDistribution[5]++;
}else{
$Number = int($Line * 5);
$LDistribution[$Number]++;
}
$CountNumber++;
}
close(FILE);
}

for ($i = 0; $i <= 5; $i++){
$Prob = $LDistribution[$i] / $CountNumber; 
print EXIT "$Prob\t";
}
print EXIT "\n";
close (EXIT);

