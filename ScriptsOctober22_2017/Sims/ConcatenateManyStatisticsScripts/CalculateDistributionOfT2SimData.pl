$TTwoPrefix = $ARGV[0];
$Ne_0 = $ARGV[1];
$Repetitions = $ARGV[2];
$ExitFile = $ARGV[3];

%T2_Distribution = ();

for ($i = 0; $i <= 40000; $i++){
$T2_Distribution{$i} = 0;
}

for ($j = 1; $j <= $Repetitions; $j++){
$InputFile = $TTwoPrefix.$j.".txt";
open (INPUT,$InputFile) or die "NO!";
while (<INPUT>){
chomp;
$Line = $_;
$T2 = int ($Line * $Ne_0*2 + 0.5);
$T2_Distribution{$T2}++;
# print "$Line\t$T2\n";
# die "NO!";
}

close(INPUT);
}

open (EXIT,">$ExitFile") or die "NO! $ExitFile";

for ($i = 0; $i <= 40000; $i++){
$Fraction = $T2_Distribution{$i} / ($Repetitions*10000);
print EXIT "$i\t$Fraction\n";
}
close (EXIT);
