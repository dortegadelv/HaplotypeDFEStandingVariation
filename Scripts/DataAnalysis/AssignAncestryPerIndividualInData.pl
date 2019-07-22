open (TABLE,"../../Data/RandomForestResults/uk10k.votesWithHeader/votes4_perindividual.txt") or die "NO!";
%Ancestry = ();
while (<TABLE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@PartOne = split(/\"/,$SplitLine[0]);
@PartTwo = split(/\"/,$SplitLine[1]);
# print "$PartOne[1]\t$PartTwo[1]\n";
$Ancestry{$PartOne[1]} = $PartTwo[1];
}

close (TABLE);

open (LEGEND,"/mnt/gluster/data/external_private_supp/uk10k/_EGAZ00001017893_22.UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.sample") or die "NO!";
open (EXIT,">../../Data/SampleAncestry.txt") or die "NO!";
$LineNumber = 0;
while (<LEGEND>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ($LineNumber > 0){
print EXIT "$SplitLine[0]\t$Ancestry{$SplitLine[0]}\n";
}
$LineNumber++;
}

close (LEGEND);
close (EXIT);
