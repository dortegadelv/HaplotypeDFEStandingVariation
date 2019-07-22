$LowerBound = $ARGV[0];
$UpperBound = $ARGV[1];
$File = $ARGV[2];
$ExitFile = $ARGV[3];

$OtherLowerBound = 1 - $UpperBound;
$OtherUpperBound = 1 - $LowerBound;

open (FILE,$File) or die "NO!";
open (EXIT,">$ExitFile") or die "NO!";
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

if (/missense/){
if ( ( $SplitLine[5] >= $LowerBound ) && ( $SplitLine[5] <= $UpperBound) ){

if ($SplitLine[10] eq "N"){
next;
}
if ($SplitLine[10] eq "."){
next;
}
if ( ( $SplitLine[10] ne $SplitLine[9] ) && ( $SplitLine[10] ne $SplitLine[8] )){
next;
}
print EXIT "$Line\n";
}elsif (( $SplitLine[5] >= $OtherLowerBound ) && ( $SplitLine[5] <= $OtherUpperBound)){

if ($SplitLine[10] eq "N"){
next;
}
if ($SplitLine[10] eq "."){
next;
}

if ( ( $SplitLine[10] ne $SplitLine[9] ) && ( $SplitLine[10] ne $SplitLine[8] )){
next;
}
print EXIT "$Line\n";
}
}
}
close(FILE);
