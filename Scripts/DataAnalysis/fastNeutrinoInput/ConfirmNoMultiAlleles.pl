for ( $i = 1; $i <= 22; $i++){
print "Chromosome $i\n";
$Exit = "../../../Data/fastNeutrinoInput/UK10K_COHORTNoMultiAlleleChr".$i.".20160215.sites";
open (EXIT,$Exit) or die "NO!";
$StartPosition = 0;
$LineNumber = 0;
while (<EXIT>){
chomp;
if ($LineNumber > 0){
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@MiniStuff = split(/\./,$SplitLine[1]);
if ($MiniStuff[0] <= $StartPosition){
print "$PastLine\n$Line\n";
die "NO! GRGA $MiniStuff[0] $StartPosition\n";
}
$StartPosition = $MiniStuff[0];
}
$LineNumber++;
$PastLine = $Line;
}
close(EXIT);
}
