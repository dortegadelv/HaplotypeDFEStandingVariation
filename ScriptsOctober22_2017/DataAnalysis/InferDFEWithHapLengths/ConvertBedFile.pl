$File = "../../../Data/GenesInMask.bed";
$ExitFile = "../../../Data/GenesInMaskVCFTabixReadyBed.bed";
open (FILE, $File) or die "NO!";
open (EXIT, ">$ExitFile") or die "NO!";

while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split (/\t/,$Line);
$ColumnOne = $SplitLine[1];
$ColumnTwo = $SplitLine[2];
$SplitLine[0] =~ /chr(\d+)/;
if ($1 && ($SplitLine[3] eq "2")){
print EXIT "$1\t$ColumnOne\t$ColumnTwo\n";
}
}

close (EXIT);
close (FILE);
