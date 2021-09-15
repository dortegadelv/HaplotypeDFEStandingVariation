open (FILE,"CpGMisOnePercentNumberPositions.frq") or die "NO";

while (<FILE>){

    chomp;
    $Line = $_;
    $File = "HapLengths/HapLength".$Line.".txt";
    system("wc -l $File | awk \{\'print $2\'\}");
}
close (FILE);

