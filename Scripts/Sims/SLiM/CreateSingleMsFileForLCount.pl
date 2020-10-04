$InputFile=$ARGV[0];
$OutputFile=$ARGV[1];
$Position=$ARGV[2];

open (INPUT, $InputFile ) or die "NO\n";

$LineNumber = 0;
@Haps = ();
while (<INPUT>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

if ($LineNumber == 0){
$SegSites = $Line;
}
elsif ($LineNumber == 1){
@Positions = @SplitLine;
}else{
push(@Haps, $Line);
}


$LineNumber++;
}
close (INPUT);

@IndexesTaken = ();
for ($i = 0 ; $i < scalar(@Positions) ; $i++ ){
if ( ( $Positions[$i] >= ($Position - 250000) ) && ( $Positions[$i] <= ($Position + 250000) )  ){
push (@IndexesTaken, $i);
}
if ($Positions[$i] == $Position){
$IndexMainPosition = $i;
}
}

open (OUTPUT, ">$OutputFile" ) or die "NO\n";

print OUTPUT "../../../Programs/Mssel/mssel3 41 300 1 40 ../../../Results/ConstantPopSize/ForwardSims/4Ns_0/MsselFiles/ResampledTraj1.txt 250000 -r 200 499999 -t 228 -seeds 1 1 1 
1 1 1
rho: 200.000000 theta: 228.000000 N0: 10000

//
selsite: $IndexMainPosition s: 0.000000 age: 0.009025
segsites: $SegSites
positions:";
@Distances = ();
foreach $j (@IndexesTaken){
    if ($Positions[$j] <= $Position ){
        $Distance =  0.5 - ( ( $Position - $Positions[$j] ) / 500000) ;
        # push (@Distances, $Distance);
        print OUTPUT " $Distance";
        # print OUTPUT " $Positions[$j]";
    }else {
        $Distance =  ( ( $Positions[$j] - $Position) / 500000) + 0.5;
        print OUTPUT " $Distance";
        # print OUTPUT " $Positions[$j]";
    }
}
print OUTPUT "\n";
@SubHaps = ();
@ZeroIndexes = ();
@OneIndexes = ();
$HapNumber = 0;
foreach $Hap (@Haps){
$Substring = substr($Hap,$IndexesTaken[0] , scalar(@IndexesTaken));
    # print "$HapNumber $Substring\n";
    print "$HapNumber\t$Hap\n";
#     die "NO!";
push (@SubHaps,$Substring);
$ZeroOrOne = substr($Hap,$IndexMainPosition,1);
if ($ZeroOrOne eq "0"){
push (@ZeroIndexes, $HapNumber);
}else {
push (@OneIndexes, $HapNumber);
}
$HapNumber++;
}

print OUTPUT "$SubHaps[$ZeroIndexes[0]]\n";
print OUTPUT "Traca\n";
foreach $i (@OneIndexes){
print OUTPUT "$SubHaps[$OneIndexes[$i]]\n";
}

close (OUTPUT);

