$InputFile = $ARGV[0];
$RepNumber = $ARGV[1];
$DirFile = $ARGV[2];
$RandomSeed = $ARGV[3];
$PopulationHistory = $ARGV[4];

$UpperLimit = 10000;
srand($RandomSeed);
@PopSize = ();
@PopTimes = ();
$PopLines = 0;

open (POPHIST,"$PopulationHistory") or die "NO!";

while(<POPHIST>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@PopSize,$SplitLine[2]);
push(@PopTimes,$SplitLine[1]);
$PopLines++;
}

close(POPHIST);


open (INPUT,$InputFile) or die "NO!";
# open (OUTPUT,">$ExitFile") or die "NO!";
@Trajectories = ();
$HeaderFlag = 0;
$Header = "";
$TrajNumber = -1;

while(<INPUT>){
chomp;
$Line = $_;
push(@File,$Line);

if ($Line =~ /age/){
$HeaderFlag = 1;
$TrajNumber++;
$Trajectories[$TrajNumber] = "";
}

if ($HeaderFlag == 0){
$Header = $Header."$Line\n";
}else{
$Trajectories[$TrajNumber] = $Trajectories[$TrajNumber]."$Line\n";
}
}

close(INPUT);

print "Number of trajectories = $TrajNumber\n";

print "Header = $Header";

# print OUTPUT "$Header";

for ($i = 1; $i <= $RepNumber ; $i++){
$RandomNumber = $i-1;
# print OUTPUT "$Trajectories[$RandomNumber]";
$MiniFileNumber = $i - 1;
$File = $DirFile."/Traj_".$MiniFileNumber.".dat";

print "File = $File\n";
@Lines = split(/\n/,$Trajectories[$RandomNumber]);
@TrajTimes = ();
@TrajFreq = ();
$FreqLines = 0;
foreach $j (@Lines){
@SplitLine = split(/\s+/,$j);
# print "Line = $i\n";
if ($SplitLine[1] eq "0.000000"){
push(@TrajTimes,$SplitLine[0]);
push(@TrajFreq,$SplitLine[1]);
$FreqLines++;
last;
}else{
push(@TrajTimes,$SplitLine[0]);
push(@TrajFreq,$SplitLine[1]);
$FreqLines++;
}
}

# print "Traj = $Trajectories[$RandomNumber]\nEND\n";
# die "NO!";

open (OUTPUT,">$File") or die "NO!";

$CurPopLine = 0;

for ($j = 1; $j < ( $FreqLines - 1) ; $j++){
if (( $CurPopLine + 1 ) == $PopLines){
print OUTPUT "$TrajTimes[$j]\t$TrajTimes[$j+1]\t$PopSize[$CurPopLine]\t$TrajFreq[$j]\n";
}else{
if ( ( $PopTimes[$CurPopLine+1] >= $TrajTimes[$j]) && ( $PopTimes[$CurPopLine+1] <= $TrajTimes[$j + 1]) ) {
while ( ( $PopTimes[$CurPopLine+1] >= $TrajTimes[$j]) && ( $PopTimes[$CurPopLine+1] <= $TrajTimes[$j + 1]) ){
if ($PopTimes[$CurPopLine+1] != $TrajTimes[$j+1]){
print OUTPUT "$TrajTimes[$j]\t$PopTimes[$CurPopLine+1]\t$PopSize[$CurPopLine]\t$TrajFreq[$j]\n";
print OUTPUT "$PopTimes[$CurPopLine+1]\t$TrajTimes[$j+1]\t$PopSize[$CurPopLine+1]\t$TrajFreq[$j]\n";
}else{
print OUTPUT "$TrajTimes[$j]\t$TrajTimes[$j+1]\t$PopSize[$CurPopLine]\t$TrajFreq[$j]\n";
}
$CurPopLine++;
if (($CurPopLine + 1) == $PopLines){
last;
}
}
}else{
print OUTPUT "$TrajTimes[$j]\t$TrajTimes[$j+1]\t$PopSize[$CurPopLine]\t$TrajFreq[$j]\n";
}
}
}

print OUTPUT "$TrajTimes[$j]\t999.0\t$PopSize[$CurPopLine]\t$TrajFreq[$j]\n";
close (OUTPUT);
# die "NO!\n";
}



