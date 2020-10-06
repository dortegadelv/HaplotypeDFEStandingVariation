$MsFile = $ARGV[0];
$NumberOfHaplotypes = $ARGV[1];
$OutputFilePrefix = $ARGV[2];
$RandomSeed = $ARGV[3];
$OutputFileNumber = 0;
$PrintFlag = 0;

### Make Individual pairs

srand ($RandomSeed);

# fisher_yates_shuffle( \@array ) : 
#     # generate a random permutation of @array in place
    sub fisher_yates_shuffle {
        my $array = shift;
        my $i;
        for ($i = @$array; --$i; ) {
            my $j = int rand ($i+1);
            next if $i == $j;
            @$array[$i,$j] = @$array[$j,$i];
        }
    }



my @HapOrdering = (0..3999);
# print "$HapOrdering[0] $HapOrdering[1]\n";
# $samples = 4000;
# @NewHaps = rand_samp(4000, @HapOrdering);
fisher_yates_shuffle( \@HapOrdering );
for ($i = 0; $i < 4000; $i++){
# print "$HapOrdering[$i]\n";
}
# die "$HapOrdering[0] $HapOrdering[1] enough\n";

open (MS,$MsFile ) or die "No input file";

while (<MS>){
chomp;
$Line = $_;
@SplitLine= split (/\s+/,$Line);

if ($PrintFlag == 1){
 
$CurrentHapNumber++;

push (@HaplotypeList, $Line);
if ($CurrentHapNumber % 2 == 1){
$CurrentLine = $Line;
}else {
$PreviousLine = $Line;
}

if ( $NumberOfHaplotypes == $CurrentHapNumber){


$PrintFlag = 0;
for ($i = 1; $i < $NumberOfPositions ; $i++){
$CurrentPosition = int ($PositionNumber[$i] * 500000 + 0.5 + 1);

if ($CurrentPosition <= $PreviousPosition){
$CurrentPosition = $PreviousPosition + 1;
}

print OUT "Chr1\t$CurrentPosition\t.\tG\tA\t50\tPASS\t.\tGT";

for ($j = 0; $j < $NumberOfHaplotypes/2; $j++){
$SiteOne = substr($HaplotypeList[$HapOrdering[$j*2]],$i-1,1);
$SiteTwo = substr($HaplotypeList[$HapOrdering[$j*2+1]],$i-1,1);
$Genotype = $SiteOne."/".$SiteTwo;
print OUT "\t$Genotype";
}
print OUT "\n";
$PreviousPosition = $CurrentPosition;
}
}
}

if ($Line =~ /position/){

@HaplotypeList = ();
@PositionNumber = split (/\s+/, $Line );
$NumberOfPositions = scalar(@PositionNumber);
$CurrentOutputFile = $OutputFilePrefix.".".$OutputFileNumber.".txt";
open (OUT, ">$CurrentOutputFile" ) or die "NO! $CurrentOutputFile\n";
$PrintFlag = 1;
$OutputFileNumber++;
$CurrentHapNumber = 0;
print OUT "##fileformat=VCFv4.0\"
##FORMAT=<ID=GT,Number=1,Type=String,Description=\"Genotype\">
##contig=<ID=1,length=1000000>
#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT";

for ($i = 0; $i < $NumberOfHaplotypes/2 ; $i++){
$IndString = "Ind".$i;
print OUT "\t$IndString";
}
print OUT "\n";
}
}

close (MS);


