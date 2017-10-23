%Annotations = ();

for ($i = 1; $i <= 22; $i++){
$File = "../../../Data/UK10K_COHORTChr".$i.".20160215.sites";
open (FILE, $File ) or die "NO!";
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
@MiniStuff = split (/\./,$SplitLine[1]);
$Key = $i.".".$MiniStuff[0];
$Annotations{$Key} = $SplitLine[0];
}
close (FILE);
print "Chromosome $i $Key\n";
}

# die "NO!";
@Chromosome = ();
@Positions = ();

$LineCounter = 0;
open (EXIT,">../../../Data/PositionsMissenseAll.txt") or die "NO!";
while (<>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
$LengthOne = length($SplitLine[3]);
$LengthTwo = length($SplitLine[4]);

# print "$Line\t$LengthOne\t$LengthTwo\n";
if ( $LineCounter == 10){
# die "Enough!\n";
}
if (($LengthOne == 1) && ($LengthTwo == 1)){
# print "$SplitLine[0]\t$SplitLine[1]\t$SplitLine[2]\n";
# push (@Chromosome,$SplitLine[0]);
# push (@Positions, $SplitLine[1]);
$Key = $SplitLine[0].".".$SplitLine[1];
print EXIT "$Key\t$Annotations{$Key}\n";
# if ( $LineCounter == 10){
# die "Enough!\n";
# }

$LineCounter++;
# die "Enough!";
}
}
close (EXIT);
