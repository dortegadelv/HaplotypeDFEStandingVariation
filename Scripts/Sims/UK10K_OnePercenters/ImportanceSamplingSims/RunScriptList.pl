open (FILE,">RunScriptList.txt") or die "NO\n";
for ($i = 2; $i <= 100 ; $i++){

$StartScript = ($i - 1) * 100 + 21;
$EndScript = ($i - 1) * 100 + 30;

$Line = "qsub -t $StartScript"."-"."$EndScript RunMsselCalculateDistanceWithRecombination10000NoSingleton.sh";
print FILE "$Line\n";

}

close (FILE);

