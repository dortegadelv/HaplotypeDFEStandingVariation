$ListOfFiles = `ls RecRate[0-9]*.txt`;
$LowerLimit = 0;
$UpperLimit = 1.2e-12;
@FileSplit = split(/\s+/, $ListOfFiles);
$NSCounter = 1;
$HapFileNumber = 0;
foreach $i (@FileSplit){
print "$i\n";
$i =~/RecRate(\d+)_(\d+).txt/;
print "$1\t$2\n";
$NumberOne = $1;
$NumberTwo = $2;
$RecRateFile = "RecRate".$NumberOne."_".$NumberTwo.".txt";
$HapLengthFile="HapLengthsExit".$NumberOne."_".$NumberTwo.".txt";
print "Here?\n";
$CommandToExecute = "wc -l ".$HapLengthFile." | awk \'\{print \$1\}\'";
print "Command = $CommandToExecute\n";
$LineNumber = `$CommandToExecute`;
print "Line number = $LineNumber\n";
if ($LineNumber == 0){
next;
}

open (FILE, $RecRateFile) or die "NO!\n";
$FlagLeft = 0;
$FlagRight = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
if ( ( $SplitLine[2] >= $LowerLimit) && ( $SplitLine[2] <= $UpperLimit ) ){
$FlagLeft = 1;
$HapFileNumber++;
$RepFile = "ReplicateNS_HapLengthCopy".$HapFileNumber.".txt";
open (HAPFILEL,">$RepFile");
}
if ( ( $SplitLine[3] >= $LowerLimit) && ( $SplitLine[3] <= $UpperLimit ) ){
$FlagRight = 1;
$HapFileNumber++;
$RepFile = "ReplicateNS_HapLengthCopy".$HapFileNumber.".txt";
open (HAPFILER,">$RepFile");
}
}
close (FILE);
$HapLengthFile="HapLengthsExit".$NumberOne."_".$NumberTwo.".txt";
open (FILE, $HapLengthFile) or die "NO!\n";
$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
if ( ($LineNumber % 2 == 0 ) && ($FlagRight == 1 ) ){
print HAPFILER "$Line\n";
}
if ( ($LineNumber % 2 == 1 ) && ($FlagLeft == 1 ) ){
print HAPFILEL "$Line\n";
}
$LineNumber++;
}
close (FILE);

if ($FlagRight == 1 ){
close (HAPFILER);
}
if ($FlagLeft == 1 ){
close (HAPFILEL);
}

}

###### Syn
$ListOfFiles = `ls RecRateSyn[0-9]*.txt`;
$LowerLimit = 0;
$UpperLimit = 1.2e-12;
@FileSplit = split(/\s+/, $ListOfFiles);
$NSCounter = 1;
$HapFileNumber = 0;
foreach $i (@FileSplit){
print "$i\n";
$i =~/RecRateSyn(\d+)_(\d+).txt/;
print "$1\t$2\n";
$NumberOne = $1;
$NumberTwo = $2;
$RecRateFile = "RecRateSyn".$NumberOne."_".$NumberTwo.".txt";
$HapLengthFile="HapLengthsSynExit".$NumberOne."_".$NumberTwo.".txt";
print "Here?\n";
$CommandToExecute = "wc -l ".$HapLengthFile." | awk \'\{print \$1\}\'";
print "Command = $CommandToExecute\n";
$LineNumber = `$CommandToExecute`;
print "Line number = $LineNumber\n";
if ($LineNumber == 0){
next;
}


open (FILE, $RecRateFile) or die "NO!\n";
$FlagLeft = 0;
$FlagRight = 0;
while (<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);
if ( ( $SplitLine[2] >= $LowerLimit) && ( $SplitLine[2] <= $UpperLimit ) ){
$FlagLeft = 1;
$HapFileNumber++;
$RepFile = "ReplicateSyn_HapLengthCopy".$HapFileNumber.".txt";
open (HAPFILEL,">$RepFile");
}
if ( ( $SplitLine[3] >= $LowerLimit) && ( $SplitLine[3] <= $UpperLimit ) ){
$FlagRight = 1;
$HapFileNumber++;
$RepFile = "ReplicateSyn_HapLengthCopy".$HapFileNumber.".txt";
open (HAPFILER,">$RepFile");
}
}
close (FILE);
$HapLengthFile="HapLengthsSynExit".$NumberOne."_".$NumberTwo.".txt";
open (FILE, $HapLengthFile) or die "NO!\n";
$LineNumber = 0;
while (<FILE>){
chomp;
$Line = $_;
if ( ($LineNumber % 2 == 0 ) && ($FlagRight == 1 ) ){
print HAPFILER "$Line\n";
}
if ( ($LineNumber % 2 == 1 ) && ($FlagLeft == 1 ) ){
print HAPFILEL "$Line\n";
}
$LineNumber++;
}
close (FILE);

if ($FlagRight == 1 ){
close (HAPFILER);
}
if ($FlagLeft == 1 ){
close (HAPFILEL);
}

}
