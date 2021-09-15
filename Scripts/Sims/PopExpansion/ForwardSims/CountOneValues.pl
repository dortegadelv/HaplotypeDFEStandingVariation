open (PROB,"PLGivenSTableWithRecsFirstDFE.txt") or die "NO!";

$CountOnes = 0;
while (<PROB>){
    chomp;
    $Line = $_;
    @SplitLine = split(/\s+/,$Line);
    for ($i = 0; $i < scalar(@SplitLine); $i++ ){
        
        if (($SplitLine[$i] >= 0.0) && ($SplitLine[$i] <= 1.0)) {
            
            $CountOnes++;
        }
    }
}
close (PROB);
print "Count ones = $CountOnes\n";
