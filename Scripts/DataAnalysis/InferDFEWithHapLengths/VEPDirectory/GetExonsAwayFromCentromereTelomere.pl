open (CENTEL,"../../../Data/CentromereTelomere.txt") or die "NO";

@Chrs = ();
@StartPosition = ();
@EndPosition = ();
while (<CENTEL>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
if (($SplitLine[7] eq "centromere") || ($SplitLine[7] eq "telomere")){
push (@Chrs, $SplitLine[1]);
push (@StartPosition, $SplitLine[2]);
push (@EndPosition, $SplitLine[3]);
}
}
close (CENTEL);

open (INPUT, "../../../Data/UCSCGenes_BStatistic/ExonsBedUniqueFile.txt") or die "NO!";
open (OUTPUT, ">../../../Data/UCSCGenes_BStatistic/ExonsBedUniqueFileFarCentrTelom.txt") or die "NO!";

while (<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
$Flag = 0;
$ExitFlag = 0;
for ($i = 0; $i < scalar(@Chrs); $i++){
if ($Chrs[$i] eq $SplitLine[0]){
if ( ( $SplitLine[1] > ( $StartPosition[$i] - 5000000) ) && ( $SplitLine[2] < ( $EndPosition[$i] + 5000000) )){
$Flag = 1;
$ExitFlag = 1;
}
elsif ( ( $SplitLine[1] < ( $StartPosition[$i] - 5000000) ) && ( $SplitLine[2] > ( $StartPosition[$i] - 5000000) )) {
$Flag = 2;
$AltEnd = $StartPosition[$i] - 5000000;
}elsif ( ( $SplitLine[1] < ( $EndPosition[$i] + 5000000) ) && ( $SplitLine[2] > ( $EndPosition[$i] + 5000000) )){
$Flag = 3;
$AltStart = $EndPosition[$i] + 5000000;
}
if ($ExitFlag == 1){
last;
}
}
}

if ($Flag == 0){
print OUTPUT "$SplitLine[0]\t$SplitLine[1]\t$SplitLine[2]\n";
}elsif($Flag == 2){
print OUTPUT "$SplitLine[0]\t$SplitLine[1]\t$AltEnd\n";
print "2\t$SplitLine[0]\t$SplitLine[1]\t$AltEnd\n";
}elsif ($Flag == 3){
print OUTPUT "$SplitLine[0]\t$AltStart\t$SplitLine[2]\n";
print "3\t$SplitLine[0]\t$AltStart\t$SplitLine[2]\n";
}

}

close (INPUT);
close (OUTPUT);


