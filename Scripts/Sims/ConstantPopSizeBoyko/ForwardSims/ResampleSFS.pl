@Directories = ();

$Directories[0] = "/scratch/midway2/diegoortega/ConstantPopSizeBoyko/";
$Directories[1] = "/scratch/midway2/diegoortega/ConstantPopSizeMouse/";
$Directories[2] = "/scratch/midway2/diegoortega/PopExpansionBoyko/";
$Directories[3] = "/scratch/midway2/diegoortega/PopExpansionMouse/";

for ($i = 0; $i <= 3; $i++){
print "$Directories[$i]\n";
$RandomNumber = 1;
for ($j = 1; $j <= 100 ; $j++){
$OnePercentSites = 0;
print "$j\n";

@StartingSFS = ();
for ($k = 0; $k < 3999; $k++){
$StartingSFS[$k] = 0;
}
$FileNumber = 0;
while ($OnePercentSites < 300){
$FileNumber++;
# $RandomNumber = int(rand(300) + 1);
$InputFile = $Directories[$i]."Output.".$RandomNumber.".sfs.txt";
$RandomNumber++;
# print "Input File = $InputFile\n";
open (INPUT,$InputFile) or die "NO!";
while (<INPUT>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/, $Line);

for ($l = 0; $l < 3999; $l++){
$StartingSFS[$l] = $StartingSFS[$l] + $SplitLine[$l];
}
$OnePercentSites = $OnePercentSites + $SplitLine[39];
}
close (INPUT);
}

# $OnePercentites = $OnePercentSites + $SplitLine[39];
# print "One percent = $OnePercentSites $StartingSFS[39]\n";

$OutputResampled = $Directories[$i]."Output.".$j.".resampledsfs.txt";
$OutputFileNumber = $Directories[$i]."Output.".$j.".numberfileresampledsfs.txt";
open (OUTPUT, ">$OutputResampled") or die "NO!";
open (OUTPUTTWO, ">$OutputFileNumber") or die "NO!";
print OUTPUT "4001 unfolded\n";
print OUTPUT "0 $StartingSFS[0]";
$SumSites = $StartingSFS[0];
@NewSFS = ();
$NewSFS[0] = 0;
for ($k = 1; $k < 3999; $k++){
$SumSites = $SumSites + $StartingSFS[$k];
$NewSFS[$k] = 0;
print OUTPUT " $StartingSFS[$k]";
}
print OUTPUT " 0\n";
print OUTPUT "1";
for ($k = 0; $k < 4000; $k++){
print OUTPUT " 0";
}
print OUTPUT " 1\n";
close (OUTPUT);
print OUTPUTTWO "$FileNumber\n";
close (OUTPUTTWO);

}
}

