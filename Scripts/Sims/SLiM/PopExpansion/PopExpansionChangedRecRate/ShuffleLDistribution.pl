$Seed = $ARGV[0];

srand($Seed);
@NumberList = ();

$NumberOfSynFiles = `ls -l ReplicateSyn_HapLength*.txt | wc -l`;
$NumberOfNSFiles = `ls -l ReplicateNS_HapLength*.txt | wc -l`;

chomp($NumberOfSynFiles);

print "File number = $NumberOfSynFiles $NumberOfNSFiles\n";

for ($i = 1; $i <= $NumberOfSynFiles; $i++){

push (@NumberList, $i);
}

fisher_yates_shuffle( \@NumberList );    # permutes @array in place

$File = "LDistributionSynRandom".$Seed.".txt";

open (BOOT,">$File") or die "NO!";
for ($i = 1; $i <= 300; $i++){

print "File = $i\n";
$NSFile = "ReplicateSyn_HapLength".$NumberList[$i-1].".txt";

open (NSFILE,$NSFile) or die "NO! $NSFile\n";

while (<NSFILE>){
chomp;
$Line = $_;
print BOOT "$Line\n";
}
close (NSFILE);
}
close (BOOT);



sub fisher_yates_shuffle {
    my $array = shift;
    my $i;
    for ($i = @$array; --$i; ) {
        my $j = int rand ($i+1);
        next if $i == $j;
        @$array[$i,$j] = @$array[$j,$i];
    }
}


