$MsselInputFile=$ARGV[0];
$PhasedDataOutput=$ARGV[1];
$MsselPhasedOutFile=$ARGV[2];
$SimNumber = $ARGV[3];

print "Zero pass\n";

open (MS, $MsselInputFile ) or die "NO!";
$HeaderLine = "";
$FirstFourLinesFlag = 0;
@MsHeaderVector = ();
$SimDetails = "";

while(<MS>){
chomp;
$Line = $_;
if ($LineCounter < 4){
$HeaderLine = $HeaderLine.$Line."\n";
}else{
if ( $Line =~ /\/\//){
$FirstFourLinesFlag = 1;
$FirstFourLinesCounter = 0;
$SimDetails = "";
}
if ( $FirstFourLinesFlag == 1) {
if ($FirstFourLinesCounter <= 3){
$SimDetails = $SimDetails.$Line."\n";
}
if ($FirstFourLinesCounter == 3){
$FirstFourLinesFlag = 0;
push (@MsHeaderVector,$SimDetails);
}
$FirstFourLinesCounter++;
}
}
$LineCounter++;
}
close (MS);

print "First pass\n";

open (PHASED, $PhasedDataOutput) or die "NO";

@MatrixPhased = ();
$LineNumber = 0;
while (<PHASED>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
for ($i = 0; $i < scalar(@SplitLine); $i++){
$MatrixPhased[$LineNumber][$i] = $SplitLine[$i];
}
$NumberOfElementsInLine = scalar(@SplitLine);
$LineNumber++;
}
close (PHASED);

print "Second pass\n";

open (OUTPUT,">$MsselPhasedOutFile") or die "NO!";

print OUTPUT "$HeaderLine";

print OUTPUT "$MsHeaderVector[$SimNumber]";

@SimHeader = split (/\n/,$MsHeaderVector[$SimNumber]);
@SelSitesLine = split (/\s+/,$SimHeader[1]);
$SelSiteNumber = $SelSitesLine[1];

@NumbersToTake = ();
@OtherNumbers = ();
for ($i = 5; $i < $NumberOfElementsInLine; $i++){
if ($MatrixPhased[$SelSiteNumber][$i] == 1){
push (@NumbersToTake, $i);
} else {
push (@OtherNumbers,$i);
}
}
$TotalElementsTaken = scalar(@NumbersToTake) ;
print "Numbers to take = $TotalElementsTaken\n";
for ($i = 0; $i < $LineNumber ; $i++){
print OUTPUT "$MatrixPhased[$i][$OtherNumbers[0]]";
}
print OUTPUT "\n";

for ($j = 0; $j < scalar(@NumbersToTake) ; $j++){
for ($i = 0; $i < $LineNumber ; $i++){
print OUTPUT "$MatrixPhased[$i][$NumbersToTake[$j]]";
}
print OUTPUT "\n";
}
# print "sel site number = $SelSiteNumber\n";

close (OUTPUT);



