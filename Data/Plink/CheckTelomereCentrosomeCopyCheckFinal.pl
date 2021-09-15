$VariantNumber = 0;
@SynVarsChr = ();
@SynVarsPos = ();

open (SYN, "SynonymousOnePercentCpG.frq") or die "NO!";
# open (POS, ">CpGSynOnePercentNumberPositionsVar.txt") or die "NO";
open (TELMIS, ">CenTelMissingSyn.txt") or die "NO!";
open (NONE, ">DerMissingSyn.txt") or die "NO";

while (<SYN>){
    chomp;
    $VarNumber = 0;
    $Line = $_;
    @SplitLine = split(/\s+/,$Line);
    push (@SynVarsChr,$SplitLine[1]);
    @Check = split(/\./,$SplitLine[2]);
    push (@SynVarsPos,$Check[1]);
#   print "Si = $Check[1] $SplitLine[1] $SplitLine[2]\n";
    
}


close (SYN);

for ($i = 0; $i < scalar(@SynVarsChr); $i++){

open (CEN,"CentromereTelomere.txt") or die "NO";
    $Flag = 0;

while (<CEN>){
    chomp;
    $Line = $_;
    @SplitLine = split(/\s+/,$Line);
    $Num = "chr".$SynVarsChr[$i];
#    print "$Num\t$SynVarsPos[$i]\n";
    if ($Num eq $SplitLine[1]){
        if ($SynVarsPos[$i] > ($SplitLine[2] + 1 - 5000000) && ($SynVarsPos[$i] < ($SplitLine[2] + 1))){
            $Flag = 1;
            $Low = $SplitLine[2] - 5000000;
            # print "$i\t$Num\t$SplitLine[2]\t$SynVarsPos[$i]\t$Low\n";
            print TELMIS "$i\t$Num\t$Low\t$SynVarsPos[$i]\t$SplitLine[2]\tLOW\n";
        }
        if (($SynVarsPos[$i] < ($SplitLine[3] + 5000000) && ($SynVarsPos[$i] > $SplitLine[3]))){
            $Flag = 1;
            $Up = $SplitLine[3] + 5000000;
            # print "$i\t$Num\t$SplitLine[3]\t$SynVarsPos[$i]\t$Up\n";
            print TELMIS "$i\t$Num\t$SplitLine[3]\t$SynVarsPos[$i]\t$Up\tUP\n";
        }
    }
    if ($Flag == 1){
        last;
    }
}
close (CEN);

#    die;
    if ($Flag == 0){
        $LineNumber = `wc -l HapLengths/HapLengthSynonymousNotCpG$i.txt | awk '{print $1}'`;
        if ($LineNumber > 0){
        # print POS "$i\n";
        $VariantNumber++,
        }else {
            print NONE "$i\n";
        }
    }
}
close (NONE);
close (TELMIS);
print "Variant Number = $VariantNumber\n";

# close (POS);

$VariantNumber = 0;
@SynVarsChr = ();
@SynVarsPos = ();

open (SYN, "MissenseOnePercentCpG.frq") or die "NO!";
# open (POS, ">CpGMisOnePercentNumberPositionsVar.txt") or die "NO";
open (TELMIS, ">CenTelMissingMis.txt") or die "NO!";
open (NONE, ">DerMissingMis.txt") or die "NO";

while (<SYN>){
    chomp;
    $VarNumber = 0;
    $Line = $_;
    @SplitLine = split(/\s+/,$Line);
    push (@SynVarsChr,$SplitLine[1]);
    @Check = split(/\./,$SplitLine[2]);
    push (@SynVarsPos,$Check[1]);
#   print "Si = $Check[1] $SplitLine[1] $SplitLine[2]\n";
    
}


close (SYN);

for ($i = 0; $i < scalar(@SynVarsChr); $i++){

open (CEN,"CentromereTelomere.txt") or die "NO";
    $Flag = 0;

while (<CEN>){
    chomp;
    $Line = $_;
    @SplitLine = split(/\s+/,$Line);
    $Num = "chr".$SynVarsChr[$i];
#    print "$Num\t$SynVarsPos[$i]\n";
    if ($Num eq $SplitLine[1]){
        if ($SynVarsPos[$i] > ($SplitLine[2] + 1 - 5000000) && ($SynVarsPos[$i] < ($SplitLine[2] + 1))){
            $Flag = 1;
            $Low = $SplitLine[2] - 5000000;
            print TELMIS "$i\t$Num\t$Low\t$SynVarsPos[$i]\t$SplitLine[2]\tLOW\n";
        }
        if (($SynVarsPos[$i] < ($SplitLine[3] + 5000000) && ($SynVarsPos[$i] > $SplitLine[3]))){
            $Flag = 1;
            $Up = $SplitLine[3] + 5000000;
            print TELMIS "$i\t$Num\t$SplitLine[3]\t$SynVarsPos[$i]\t$Up\tUP\n";
        }
    }
    if ($Flag == 1){
        last;
    }
}
close (CEN);


#    die;

    if ($Flag == 0){
        $LineNumber = `wc -l HapLengths/HapLengthOnlyCpG$i.txt | awk '{print $1}'`;
        if ($LineNumber > 0){
#         print POS "$i\n";
        $VariantNumber++,
        }else {
            print NONE "$i\n";
        }
    }
}
close (NONE);
close (TELMIS);
print "Variant Number = $VariantNumber\n";
