$FileToOpen = $ARGV[0];
$FileToPrintTrajectories = $ARGV[1];
$RowToTake = $ARGV[2];

open (FILE, $FileToOpen ) or die "NO!";
open (EXIT, ">$FileToPrintTrajectories" ) or die "NO!";

while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

if ( $SplitLine[0] eq "TOT" ) {
$PrintFlag = 0;
}

if ( $PrintFlag == 1 ){
print EXIT "$SplitLine[1]\t$SplitLine[2]\n";

}

if ( $SplitLine[0] eq "REP" ) {
if ( $SplitLine[1] eq $RowToTake ) {
$PrintFlag = 1;
}
} 
}

close (FILE);
close (EXIT);
