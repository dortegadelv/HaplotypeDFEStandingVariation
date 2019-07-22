$UnrelatedSamples = "../../Data/UK10K_3781-samples_annotated_release_20130515.txt";

open (SAMPLES,$UnrelatedSamples) or die "NO!";
@Duplicate = ();
%DuplicateKeys = ();
@Twins = ();
%TwinsKeys = ();
$LineNumber = 0;
@ListOfSamples = ();
while(<SAMPLES>){
chomp;
if ($LineNumber > 0 ){
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# push(@ListOfSamples,$SplitLine[0]);
# print "$SplitLine[4]\t$SplitLine[5]\n";
if ($SplitLine[27] ne "no"){
push(@ListOfSamples,$SplitLine[0]);

}

# if ($SplitLine[5] ne "NA"){
# if ($TwinsKeys{$SplitLine[0]} ne $SplitLine[5] ){
# push (@Twins,$SplitLine[5]);
# $TwinsKeys{$SplitLine[5]}=$SplitLine[0];
# }
# }
}
$LineNumber++;
}
close(SAMPLES);

# $DuplicateSize = scalar(@Duplicate);
# $TwinSize = scalar(@Twins);
$NumberOfSamples = scalar(@ListOfSamples);

print "Sample size = $NumberOfSamples\n";

open (LIST,">../../Data/ListUnrelatedSamplesUK10K_3781-samples_annotated_release_20130515.txt") or die "NO!";

foreach $sample (@ListOfSamples){
# if (grep {$_ eq $sample} @Duplicate) {
#   next ;
# }
# if (grep {$_ eq $sample} @Twins) {
#   next ;
# }
print LIST "$sample $sample\n";
}

