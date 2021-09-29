@FourNs = ();

$FourNs[1]="4Ns_0";
$FourNs[2]="4Ns_-25";
$FourNs[3]="4Ns_-50";
$FourNs[4]="4Ns_25";
$FourNs[5]="4Ns_50";

@FourNsNumber = ();

$FourNsNumber[1]="0";
$FourNsNumber[2]="-25";
$FourNsNumber[3]="-50";
$FourNsNumber[4]="25";
$FourNsNumber[5]="50";

@RecRate = ();

push(@RecRate,"0");
push(@RecRate,"191.352");
push(@RecRate,"495.326");
push(@RecRate,"783.562");
push(@RecRate,"1079.2");
push(@RecRate,"1370.047");
push(@RecRate,"1888.974");
push(@RecRate,"2244.487");
push(@RecRate,"2512.65");
push(@RecRate,"2881.44");
push(@RecRate,"3391.733");
push(@RecRate,"3977.678");
push(@RecRate,"4614.348");
push(@RecRate,"5215.098");
push(@RecRate,"5869.541");
push(@RecRate,"6966.051");
push(@RecRate,"7767.025");
push(@RecRate,"8498.236");
push(@RecRate,"10215.751");
push(@RecRate,"12984.294");
push(@RecRate,"23003.3");


@MutRate = ();

push(@MutRate,"LowMut");
push(@MutRate,"HighMut");
push(@MutRate,"LowerMut");
push(@MutRate,"HigherMut");


for ( $RecNumber = 10; $RecNumber <= 10 ; $RecNumber++ ) {
for ( $DirNumber = 1; $DirNumber <= 5 ; $DirNumber++ ) {
for ( $MisNumber = 0; $MisNumber <= 3 ; $MisNumber++ ) {
# for ( $RecNumber = 0; $RecNumber < 20 ; $RecNumber++ ) {

print "$FourNs[$DirNumber]\n";
$ExitFile = "../../../../Results/ResultsSelectionInferred/SelectionUK10K".$MisNumber."SmallRec".$MutRate[$MisNumber]."_".$FourNsNumber[$DirNumber].".txt";
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 100 ; $RepNumber++) {
# LLSimsSingleRecHighRecMssel273_"${RecRate[$RecNumber]}"_"$RepNumber".txt"
$File="../../../../Results/UK10K/ForwardSims/".$FourNs[$DirNumber]."/LLSimsSingleRecHighRec".$MutRate[$MisNumber]."Mssel273_".$RecRate[$RecNumber]."_11_".$RepNumber.".txt";

open (FILE,$File) or die "NO! $File\n";

$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# print "$SplitLine[1]";
if ($LineNumber == 123){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
if (($LineNumber > 123) && ($LineNumber < 294)){
if ($SplitLine[1] > $Max ){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
}
# print "\t$MaxNum\n";
$LineNumber++;
}

close (FILE);
$SelValue = $MaxNum - 201;
print EXIT "$SelValue\n";
}
close (EXIT);
}
}
}

