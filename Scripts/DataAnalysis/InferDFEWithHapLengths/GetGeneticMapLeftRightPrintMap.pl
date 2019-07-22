
open (EXCLUSION,"../../../Data/VariantNumber.txt") or die "NO!";
open (PERRECVAR,">../../../Data/LeftBpRecRatePerVariantPrintMap.txt") or die "NO!";

@VariantsToExclude = ();

while (<EXCLUSION>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@VariantsToExclude,$Line);
}

close(EXCLUSION);

$TotalLineNumber = -1;
for ($i = 1; $i <= 22; $i++){

$GeneticMapFile = "../../../Data/Plink/MissenseOnePercent".$i.".frq";

open (MAP,$GeneticMapFile) or die "NO!";

while (<MAP>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
@Position = split(/\./,$SplitLine[2]);
# print "$Position[1]\n";
$ActualMap = "../../../Data/maps_b37/maps_chr.$i";

$LowerPosition = $Position[1] - 250000;
$UpperPosition = $Position[1];

# print "$i $LowerPosition\t$Position[1]\t$UpperPosition\n";

$GenMapSum = 0;
$FirstPositionFlag = 0;
$TotalLineNumber++;
$Flag = 0;
foreach $Var (@VariantsToExclude){
if ($Var eq $TotalLineNumber){
$Flag = 1;
last;
}
}
if ($Flag == 1){
next;
}

$SomethingThereFlag = 0;
open (ACTMAP,$ActualMap) or die "NO!";
$ACTMAPLineNumber = 0;
while (<ACTMAP>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ( ( $SplitLine[0] >= $LowerPosition ) && ( $SplitLine[0] <= $UpperPosition ) ){
$GenMapSum = $GenMapSum + $SplitLine[1];
$SomethingThereFlag = 1;
if ($FirstPositionFlag == 0){
$FirstPosition = $SplitLine[1];
$FirstPositionFlag = 1;
$FirstPositionACTMAP = $ACTMAPLineNumber;
}else{
$LastPosition = $SplitLine[1];
$LastPositionACTMAP = $ACTMAPLineNumber;
}
# print "$Position[1]\t$Line\n";
}
$ACTMAPLineNumber++;
}
close (ACTMAP);
$GenMapLastPart = 0;
$GenMapFirstPart = 0;
if ( $SomethingThereFlag == 1){
# print "Lower and Upper position $LowerPosition $UpperPosition\n";
# print "ACTMAP = $FirstPositionACTMAP\t$LastPositionACTMAP\n";
open (ACTMAP,$ActualMap) or die "NO!";
$ACTMAPLineNumber = 0;
while (<ACTMAP>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ( $ACTMAPLineNumber == ( $FirstPositionACTMAP - 1 ) ){
$PreRegionPosition = $SplitLine[0];
$PreRegionGenMap = $SplitLine[1];
# print "$Line\n";
}
if ( $ACTMAPLineNumber == ( $FirstPositionACTMAP ) ){
$CurRegionPosition = $SplitLine[0];
$CurRegionGenMap = $SplitLine[1];
$GenMapRate = ($CurRegionGenMap - $PreRegionGenMap) / ($CurRegionPosition - $PreRegionPosition);
$GenMapFirstPart = $GenMapRate * ( $CurRegionPosition - $LowerPosition)  ;
print PERRECVAR "$i\t$UpperPosition\t$LowerPosition\t$CurRegionPosition\t$GenMapRate\n";
# print "$Line $GenMapRate $GenMapFirstPart $CurRegionPosition $LowerPosition\n";
}
if ( ( $ACTMAPLineNumber > ( $FirstPositionACTMAP )) && ( $ACTMAPLineNumber < ( $LastPositionACTMAP + 1 ) ) ){
$PreRegionPosition = $CurRegionPosition;
$CurRegionPosition = $SplitLine[0];
$PastGenMap = $CurRegionGenMap;
$CurRegionGenMap = $SplitLine[1];
$GenMapRate = ($CurRegionGenMap - $PastGenMap) / ($CurRegionPosition - $PreRegionPosition);
print PERRECVAR "$i\t$UpperPosition\t$PreRegionPosition\t$CurRegionPosition\t$GenMapRate\n";
# print "$Line\n";
}
if ( $ACTMAPLineNumber == ( $LastPositionACTMAP + 1 ) ){
$PostRegionPosition = $SplitLine[0];
$PostRegionGenMap = $SplitLine[1];
$GenMapRate = ($PostRegionGenMap - $CurRegionGenMap) / ($PostRegionPosition - $CurRegionPosition);
$GenMapLastPart = $GenMapRate * ( $UpperPosition - $CurRegionPosition)  ;
print PERRECVAR "$i\t$UpperPosition\t$CurRegionPosition\t$UpperPosition\t$GenMapRate\n";
# print "$Line $GenMapRate\n";
}

# print "Gen map = $GenMapFirstPart\t$GenMapLastPart\n";
$ACTMAPLineNumber++;
}
close (ACTMAP);

# print "Gen map = $GenMapFirstPart\t$GenMapLastPart\n";

if ( $GenMapFirstPart < 0) {
die "WEIRD!";
}

if ( $GenMapLastPart < 0) {
die "WEIRD!";
}
}

$TotalRecRate = ($LastPosition - $FirstPosition + $GenMapFirstPart + $GenMapLastPart ) / 250000;
print "$FirstPosition\t$LastPosition\t$TotalRecRate\t$GenMapFirstPart\t$GenMapLastPart\n";
# print PERRECVAR "$TotalRecRate\n";
# die "No!\n";
close (ACTMAP);
#print "$GenMapSum\n";
# die "NO!";
}

close (MAP);

}
close(PERRECVAR);

open (PERRECVAR,">../../../Data/RightBpRecRatePerVariantPrintMap.txt") or die "NO!";

$TotalLineNumber = -1;
for ($i = 1; $i <= 22; $i++){

$GeneticMapFile = "../../../Data/Plink/MissenseOnePercent".$i.".frq";

open (MAP,$GeneticMapFile) or die "NO!";

while (<MAP>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
@Position = split(/\./,$SplitLine[2]);
# print "$Position[1]\n";
$ActualMap = "../../../Data/maps_b37/maps_chr.$i";

$LowerPosition = $Position[1];
$UpperPosition = $Position[1] + 250000;

# print "$i $LowerPosition\t$Position[1]\t$UpperPosition\n";

$GenMapSum = 0;
$FirstPositionFlag = 0;
$TotalLineNumber++;
$Flag = 0;
foreach $Var (@VariantsToExclude){
if ($Var eq $TotalLineNumber){
$Flag = 1;
last;
}
}
if ($Flag == 1){
next;
}

$SomethingThereFlag = 0;
open (ACTMAP,$ActualMap) or die "NO!";
$ACTMAPLineNumber = 0;
while (<ACTMAP>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ( ( $SplitLine[0] >= $LowerPosition ) && ( $SplitLine[0] <= $UpperPosition ) ){
$GenMapSum = $GenMapSum + $SplitLine[1];
$SomethingThereFlag = 1;
if ($FirstPositionFlag == 0){
$FirstPosition = $SplitLine[1];
$FirstPositionFlag = 1;
$FirstPositionACTMAP = $ACTMAPLineNumber;
}else{
$LastPosition = $SplitLine[1];
$LastPositionACTMAP = $ACTMAPLineNumber;
}
# print "$Position[1]\t$Line\n";
}
$ACTMAPLineNumber++;
}
close (ACTMAP);
$GenMapLastPart = 0;
$GenMapFirstPart = 0;
if ( $SomethingThereFlag == 1){
# print "Lower and Upper position $LowerPosition $UpperPosition\n";
# print "ACTMAP = $FirstPositionACTMAP\t$LastPositionACTMAP\n";
open (ACTMAP,$ActualMap) or die "NO!";
$ACTMAPLineNumber = 0;
while (<ACTMAP>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ( $ACTMAPLineNumber == ( $FirstPositionACTMAP - 1 ) ){
$PreRegionPosition = $SplitLine[0];
$PreRegionGenMap = $SplitLine[1];
# print "$Line\n";
}
if ( $ACTMAPLineNumber == ( $FirstPositionACTMAP ) ){
$CurRegionPosition = $SplitLine[0];
$CurRegionGenMap = $SplitLine[1];
$GenMapRate = ($CurRegionGenMap - $PreRegionGenMap) / ($CurRegionPosition - $PreRegionPosition);
$GenMapFirstPart = $GenMapRate * ( $CurRegionPosition - $LowerPosition)  ;
print PERRECVAR "$i\t$LowerPosition\t$LowerPosition\t$CurRegionPosition\t$GenMapRate\n";
# print PERRECVAR "$i\t$UpperPosition\t$LowerPosition\t$CurRegionPosition\t$GenMapRate\n";
# print "$Line $GenMapRate $GenMapFirstPart $CurRegionPosition $LowerPosition\n";
}
if ( ( $ACTMAPLineNumber > ( $FirstPositionACTMAP )) && ( $ACTMAPLineNumber < ( $LastPositionACTMAP + 1 ) ) ){
$PreRegionPosition = $CurRegionPosition;
$CurRegionPosition = $SplitLine[0];
$PastGenMap = $CurRegionGenMap;
$CurRegionGenMap = $SplitLine[1];
$GenMapRate = ($CurRegionGenMap - $PastGenMap) / ($CurRegionPosition - $PreRegionPosition);
print PERRECVAR "$i\t$LowerPosition\t$PreRegionPosition\t$CurRegionPosition\t$GenMapRate\n";

}

if ( $ACTMAPLineNumber == ( $LastPositionACTMAP + 1 ) ){
$PostRegionPosition = $SplitLine[0];
$PostRegionGenMap = $SplitLine[1];
$GenMapRate = ($PostRegionGenMap - $CurRegionGenMap) / ($PostRegionPosition - $CurRegionPosition);
$GenMapLastPart = $GenMapRate * ( $UpperPosition - $CurRegionPosition)  ;
# print "$Line $GenMapRate\n";
print PERRECVAR "$i\t$LowerPosition\t$CurRegionPosition\t$UpperPosition\t$GenMapRate\n";
}

# print "Gen map = $GenMapFirstPart\t$GenMapLastPart\n";
$ACTMAPLineNumber++;
}
close (ACTMAP);

# print "Gen map = $GenMapFirstPart\t$GenMapLastPart\n";

if ( $GenMapFirstPart < 0) {
die "WEIRD!";
}

if ( $GenMapLastPart < 0) {
die "WEIRD!";
}
}

$TotalRecRate = ($LastPosition - $FirstPosition + $GenMapFirstPart + $GenMapLastPart ) / 250000;
print "$FirstPosition\t$LastPosition\t$TotalRecRate\t$GenMapFirstPart\t$GenMapLastPart\n";
# print PERRECVAR "$TotalRecRate\n";
# die "No!\n";
close (ACTMAP);
#print "$GenMapSum\n";
# die "NO!";
}

close (MAP);

}

close (PERRECVAR);

