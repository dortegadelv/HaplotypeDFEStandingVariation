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
push(@RecRate,"484.278");
push(@RecRate,"855.292");
push(@RecRate,"1251.886");
push(@RecRate,"1624.489");
push(@RecRate,"2164.258");
push(@RecRate,"2699.187");
push(@RecRate,"3120.820");
push(@RecRate,"3509.574");
push(@RecRate,"4083.76");
push(@RecRate,"4496.201");
push(@RecRate,"5625.89");
push(@RecRate,"6448.182");
push(@RecRate,"7504.213");
push(@RecRate,"8522.912");
push(@RecRate,"9955.981");
push(@RecRate,"10977.747");
push(@RecRate,"12265.958");
push(@RecRate,"14138.413");
push(@RecRate,"19608.766");
push(@RecRate,"38656.841");

@MutRate = ();

push(@MutRate,"LowMut");
push(@MutRate,"HighMut");


for ( $RecNumber = 10; $RecNumber <= 10 ; $RecNumber++ ) {
for ( $DirNumber = 1; $DirNumber <= 3 ; $DirNumber++ ) {
for ( $MisNumber = 0; $MisNumber <= 1 ; $MisNumber++ ) {
# for ( $RecNumber = 0; $RecNumber < 20 ; $RecNumber++ ) {

print "$FourNs[$DirNumber]\n";
$ExitFile = "../../../../Results/ResultsSelectionInferred/SelectionUK10K".$MisNumber."SmallRec".$MutRate[$MisNumber]."_".$FourNsNumber[$DirNumber].".txt";
open (EXIT,">$ExitFile") or die "NO";
for ( $RepNumber = 1; $RepNumber <= 50 ; $RepNumber++) {
# LLSimsSingleRecHighRecMssel273_"${RecRate[$RecNumber]}"_"$RepNumber".txt"
$File="../../../../Results/UK10K/ForwardSims/".$FourNs[$DirNumber]."/LLSimsSingleRecHighRec".$MutRate[$MisNumber]."Mssel273_".$RecRate[$RecNumber]."_11_".$RepNumber.".txt";

open (FILE,$File) or die "NO! $File\n";

$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
# print "$SplitLine[1]";
if ($LineNumber == 126){
$Max = $SplitLine[1];
$MaxNum = $LineNumber;
}
if (($LineNumber > 125) && ($LineNumber < 277)){
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

