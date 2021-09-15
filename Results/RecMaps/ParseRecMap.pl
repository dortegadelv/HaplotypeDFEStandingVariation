open (SYN,"../../Data/Plink/SynonymousOnePercentCpG.frq") or "NO";

@Vars = ();
while (<SYN>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    
    push(@Vars,$SplitLine[2]);
    print "Var = $SplitLine[2]\n";
}
close (SYN);

open (VAR,"LeftBpRecRatePerVariantSynonymousPrintMap.txt") or die "NO";
open (VARP,">LeftBpRecRatePerVariantSynonymousNoCpGPrintMap143.txt") or die "NO";

@ArraySyn = ();

# (0..10,13..23,26..49,51..53,55..72,74..114,116..143,145..151);

open (SYN,"../../Data/Plink/CpGSynOnePercentNumberPositionsVar.txt");

while (<SYN>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    
    push(@ArraySyn,$SplitLine[0]);
    print "Var = $SplitLine[2]\n";
}
close (SYN);

while (<VAR>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    $Var = $SplitLine[0].".".$SplitLine[1];
    for ($i = 0; $i < scalar(@ArraySyn); $i++){
        if ($Vars[$ArraySyn[$i]] eq $Var){
            print VARP "$Line\n";
            # print "$i\n";
            #die;
        }
    }
}

close (VAR);
close (VARP);

open (VAR,"RightBpRecRatePerVariantSynonymousPrintMap.txt") or die "NO";
open (VARP,">RightBpRecRatePerVariantSynonymousNoCpGPrintMap143.txt") or die "NO";

@ArraySyn = ();

open (SYN,"../../Data/Plink/CpGSynOnePercentNumberPositionsVar.txt");

while (<SYN>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    
    push(@ArraySyn,$SplitLine[0]);
    print "Var = $SplitLine[2]\n";
}
close (SYN);


while (<VAR>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    $Var = $SplitLine[0].".".$SplitLine[1];
    for ($i = 0; $i < scalar(@ArraySyn); $i++){
        if ($Vars[$ArraySyn[$i]] eq $Var){
            print VARP "$Line\n";
            # print "$i\n";
            #die;
        }
    }
}

close (VAR);
close (VARP);


open (SYN,"../../Data/Plink/MissenseOnePercentCpG.frq") or die "NO";

@Vars = ();
@ArraySyn = ();

while (<SYN>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    push(@Vars,$SplitLine[2]);
}
close (SYN);

open (VAR,"LeftBpRecRatePerVariantPrintMap.txt") or die "NO";
open (VARP,">LeftBpRecRatePerVariantNoCpGPrintMap269.txt") or die "NO";

open (SYN,"../../Data/Plink/CpGMisOnePercentNumberPositionsVar.txt");

while (<SYN>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    
    push(@ArraySyn,$SplitLine[0]);
    print "Var = $SplitLine[2]\n";
}
close (SYN);


# ArrayNS <- read.table("../../Data/Plink/CpGMisOnePercentNumberPositionsVar.txt")


while (<VAR>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    $Var = $SplitLine[0].".".$SplitLine[1];
    for ($i = 0; $i < scalar(@ArraySyn); $i++){
        if ($Vars[$ArraySyn[$i]] eq $Var){
            print VARP "$Line\n";
            # print "$i\n";
            #die;
        }
    }
}

close (VAR);
close (VARP);

open (VAR,"RightBpRecRatePerVariantPrintMap.txt") or die "NO";
open (VARP,">RightBpRecRatePerVariantNoCpGPrintMap269.txt") or die "NO";

while (<VAR>){
    chomp;
    $Line = $_;
    @SplitLine = split (/\s+/, $Line);
    $Var = $SplitLine[0].".".$SplitLine[1];
    for ($i = 0; $i < scalar(@ArraySyn); $i++){
        if ($Vars[$ArraySyn[$i]] eq $Var){
            print VARP "$Line\n";
            # print "$i\n";
            #die;
        }
    }
}

close (VAR);
close (VARP);



