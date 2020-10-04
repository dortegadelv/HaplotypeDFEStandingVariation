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
$SegsitesInPlace = 0;
for ($i = 0 ; $i < scalar(@Positions) ; $i++ ){
if ( ( $Positions[$i] >= ($Position - 250000) ) && ( $Positions[$i] <= ($Position + 250000) )  ){
    if (scalar(@IndexesTaken) == 0){
        $FirstPositionToTake = $i;
    }
push (@IndexesTaken, $i);
    $SegsitesInPlace++;
}
if ($Positions[$i] == $Position){
    $IndexMainPosition = $SegsitesInPlace - 1;
    print "Index to look at $i $IndexMainPosition $Position $Positions[$i]\n";
}
}

open (OUTPUT, ">$OutputFile" ) or die "NO\n";

print OUTPUT "../../../Programs/Mssel/mssel3 41 300 1 40 ../../../Results/ConstantPopSize/ForwardSims/4Ns_0/MsselFiles/ResampledTraj1.txt 250000 -r 200 499999 -t 228 -seeds 1 1 1 
1 1 1
rho: 200.000000 theta: 228.000000 N0: 10000

//
selsite: $IndexMainPosition s: 0.000000 age: 0.009025
segsites: $SegsitesInPlace
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

@ZeroHaps = ();
@OneHaps = ();

foreach $Hap (@Haps){
$Substring = substr($Hap,$FirstPositionToTake , scalar(@IndexesTaken));
    # print "$HapNumber $Substring\n";
#     print "$HapNumber\t$Hap\n";
#     die "NO!";
push (@SubHaps,$Substring);
$ZeroOrOne = substr($Substring,$IndexMainPosition,1);
if ($ZeroOrOne eq "0"){
push (@ZeroIndexes, $HapNumber);
push (@ZeroHaps, $Substring);
}elsif ($ZeroOrOne eq "1"){
push (@OneIndexes, $HapNumber);
push (@OneHaps, $Substring);
}
$HapNumber++;
}

$NumDerivedAlleles = scalar(@OneIndexes);
$NumAncestralAlleles = scalar(@ZeroIndexes);
print "The number of alleles is equal to $NumDerivedAlleles ancestral alleles $NumAncestralAlleles\n";
print "Segsites in place $SegsitesInPlace\n";
print "The index main position is $IndexMainPosition\n";
print OUTPUT "$ZeroHaps[0]\n";
# print OUTPUT "Traca\n";

$TotalNumberOfHaps = scalar(@SubHaps);
print "The total number of haps is $TotalNumberOfHaps\n";

foreach $i (@ZeroHaps){
    $ZeroOrOne = substr($i,$IndexMainPosition,1);
    print "$ZeroOrOne";
}
print "\n";

foreach $i (@OneHaps){
    $ZeroOrOne = substr($i,$IndexMainPosition,1);
    print "$ZeroOrOne";
print OUTPUT "$i\n";
}
print "\n";
close (OUTPUT);

