@Directories = ();

$Directories[0] = "/scratch/midway2/diegoortega/ConstantPopSizeBoyko/";
$Directories[1] = "/scratch/midway2/diegoortega/ConstantPopSizeMouse/";
$Directories[2] = "/scratch/midway2/diegoortega/PopExpansionBoyko/";
$Directories[3] = "/scratch/midway2/diegoortega/PopExpansionMouse/";

for ($i = 0; $i <= 3; $i++){
print "$Directories[0]\n";

for ($j = 1; $j <= 3000; $j++){

# print "$Directories[0]\n";


@StartingSFS = ();
for ($k = 1; $k < 4000; $k++){
$StartingSFS[$k] = 0;
}
$InputFile = $Directories[$i]."Output.".$j.".full_out.txt";
$OutputFile = $Directories[$i]."Output.".$j.".sfs.txt";

open (OUTPUT,">$OutputFile") or die "NO! $OutputFile\n";
open (INPUT,$InputFile) or die "NO! $InputFile\n";
while (<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$Frequency = int($SplitLine[2] * 4000 + 0.5);
$StartingSFS[$Frequency]++;
}

close (INPUT);

print OUTPUT "$StartingSFS[1]";
for ($k = 2; $k < 4000; $k++){
print OUTPUT "\t$StartingSFS[$k]";
}
close (OUTPUT);
}
}

