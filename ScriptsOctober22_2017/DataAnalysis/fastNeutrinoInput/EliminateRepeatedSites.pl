for ( $i = 1; $i <= 22; $i++){

print "Chromosome = $i\n";
$File = "../../../Data/fastNeutrinoInput/UK10K_COHORTChr".$i.".20160215.sites";
open (FILE,$File) or die "NO!";
@RepeatedPositions = ();
$PastPosition = 0;
$FlagFirstRepetition = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@Part = split(/\./,$SplitLine[1]);
if ( ( $Part[0] eq $PastPosition ) && ( $FlagFirstRepetition == 0) ){
push(@RepeatedPositions,$PastPosition);
push(@RepeatedPositions,$PastPosition);
$FlagFirstRepetition = 1;
}elsif ( ( $Part[0] eq $PastPosition ) && ( $FlagFirstRepetition == 1) ){
push(@RepeatedPositions,$PastPosition);
}else{
$FlagFirstRepetition = 0;
}
$PastPosition = $Part[0];
}

close(FILE);
$File = "../../../Data/fastNeutrinoInput/UK10K_COHORTChr".$i.".20160215.sites";
open (FILE,$File) or die "NO!";
$Exit = ">../../../Data/fastNeutrinoInput/UK10K_COHORTNoMultiAlleleChr".$i.".20160215.sites";
open (EXIT,$Exit) or die "NO!";
$StartPosition = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@Part = split(/\./,$SplitLine[1]);
if ( $Part[0] eq $RepeatedPositions[$StartPosition]) {
$StartPosition++;
}else{
print EXIT "$Line\n";
}
}
close(EXIT);
close(FILE);

}
