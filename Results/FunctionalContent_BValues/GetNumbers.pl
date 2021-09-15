open (SYNSITES,"../../Data/Plink/SynonymousOnePercentCpG.frq") or die "NO!";

@Components = ();
while (<SYNSITES>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line );
    $MiniComponent = $SplitLine[2];
    push (@Components, $MiniComponent);
}

close (SYNSITES);
open (LINPR,">LineToPrintSyn.txt") or die "NO!";


foreach $i (@Components){
    print "$i\n";
open (BSTAT,"B_StatisticSyn.txt") or die "NO!";
# @Components = ();
$LineNumber = 0;
while (<BSTAT>){
chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    $Number = $SplitLine[1] + 1;
    $MiniComponent = $SplitLine[0].".".$Number;
    
    if ($MiniComponent eq $i ){
        print "Si\n";
        print LINPR "$LineNumber\n";
    }
    $LineNumber++;
    # push (@Components, $MiniComponent);
}
close (BSTAT);
}

open (SYNSITES,"../../Data/Plink/MissenseOnePercentCpG.frq") or die "NO!";

@Components = ();
while (<SYNSITES>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line );
    $MiniComponent = $SplitLine[2];
    push (@Components, $MiniComponent);
}

close (SYNSITES);
open (LINPR,">LineToPrintMis.txt") or die "NO!";


foreach $i (@Components){
    print "$i\n";
open (BSTAT,"B_StatisticMis.txt") or die "NO!";
# @Components = ();
$LineNumber = 0;
while (<BSTAT>){
chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    $Number = $SplitLine[1] + 1;
    $MiniComponent = $SplitLine[0].".".$Number;
    
    if ($MiniComponent eq $i ){
        print "Si\n";
        print LINPR "$LineNumber\n";
    }
    $LineNumber++;
    # push (@Components, $MiniComponent);
}
close (BSTAT);
}
