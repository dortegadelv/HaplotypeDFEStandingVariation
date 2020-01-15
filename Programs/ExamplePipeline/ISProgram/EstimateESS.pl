$FileName = $ARGV[0];

open (FILE,$FileName) or die "NO!";
$TotalAge = 0;
$MaximumWeight = 0;
$SumW = 0;
$WrongMeanAge = 0;
$LineNumber = 0;
$StrangeAge = 0;

@AllAges = ();
@AllAgesSq = ();
@SumsOfW = ();
@AllBigW = ();
@AllMaximumW = ();
@ESS = ();

while(<FILE>){
    chomp;
    $Line = $_;
    @Ages = split(/\t/,$Line);
	$ElementsInLine = scalar(@Ages);	
	if (scalar(@Ages) > 1){
		if ($LineNumber == 0){
			$MaximumWeight = $Ages[1];
			$StrangeAge = $Ages[0];
			for ($i = 2; $i < $ElementsInLine; $i++){
				$AllAges[$i-2] = 0;
				$AllAgesSq[$i-2] = 0;
				$SumsOfW[$i-2] = 0;
				$AllMaximumW[$i-2] = $Ages[$i];
			}
		}
    $TotalAge = $TotalAge + $Ages[0]* $Ages[1];
	#    $iHHd = $iHHd +$Ages[2]*$Ages[2];
	#    $EHHTilZeroDotTwo = $EHHTilZeroDotTwo + $Ages[3]*$Ages[2];
    $SumW = $SumW + $Ages[1];
    $WrongMeanAge = $WrongMeanAge + $Ages[0];
    if ( $Ages[1] > $MaximumWeight){
    $MaximumWeight = $Ages[1];
    $StrangeAge = $Ages[0];
    }
	for ($i = 2; $i < $ElementsInLine; $i++){
		$AllAges[$i-2] = $AllAges[$i-2] + $Ages[$i]*$Ages[0];
		$AllAgesSq[$i-2] = $AllAgesSq[$i-2] + $Ages[$i]*$Ages[0]*$Ages[0];
		$SumsOfW[$i-2] = $SumsOfW[$i-2] + $Ages[$i];
		if ($Ages[$i] > $AllMaximumW[$i-2]){
			$AllMaximumW[$i-2] = $Ages[$i];
		}
		$AllBigW[$i-2] = 0;
	}
	}
	$LineNumber++;
}
print "Maximum W = $MaximumWeight\n";
print "Strange Age = $StrangeAge\n";

$EstimatedAge = $TotalAge / $SumW;

close(FILE);

@EstimatedAges = ();
@EstimatedAgesSq = ();
for ($i = 2; $i < $ElementsInLine; $i++){
$EstimatedAges[$i-2] = $AllAges[$i-2] / $SumsOfW[$i-2];
$EstimatedAgesSq[$i-2] = $AllAgesSq[$i-2] / $SumsOfW[$i-2];
}

$EstimatedAgeSq = $EstimatedAgeSq / $SumW;

open (FILE,$FileName) or die "NO!";
$ESSDenominator = 0;
# $W = 0;
$AltVariance = 0;
$Elements = 0;
$SumW2 = 0;

while(<FILE>){
    chomp;
    $Line = $_;
    @Ages = split(/\t/,$Line);
#    $W = $W + exp($Ages[1] - $MaximumWeight);
	for ($i = 2; $i < $ElementsInLine; $i++){
		$AllBigW[$i-2] = $AllBigW[$i-2] + $Ages[$i]/$AllMaximumW[$i-2];
		$ESS[$i-2] = $ESS[$i-2] + ( $Ages[$i] / $SumsOfW[$i-2]) * ( $Ages[$i] / $SumsOfW[$i-2]) ;
	}
    $TempW = $Ages[1] / $SumW;
    $ESSDenominator = $ESSDenominator + $TempW * $TempW;
    $AltVariance = $AltVariance + (($Ages[1]*$Ages[1]) *(($Ages[0] - $EstimatedAge)**2));
    $Elements = $Elements + 1;
    $SumW2 = $SumW2 + ($Ages[1]*$Ages[1]);
}
$AltVariance = $AltVariance / $SumW2;
$ESS = 1 / $ESSDenominator;

for ($i = 2; $i < $ElementsInLine; $i++){
$ESS[$i-2] = 1 / $ESS[$i-2] ;
}
$ExitFile = ">>FinalStats.txt";
open (EXIT,$ExitFile) or die "NO!";

#print EXIT "File\tW\tAge_IS\tAge_4Ngen_IS\tAge_MeanPath\tAge_4Ngen_MeanPath\n";
print "Big W = $SumW\n";
print "Elements in Line = $ElementsInLine\n";
print EXIT "$FileName";
for ($i = 2; $i < $ElementsInLine; $i++){
print EXIT "\t$ESS[$i-2]";
}
for ($i = 2; $i < $ElementsInLine; $i++){
print EXIT "\t$EstimatedAges[$i-2]";
}
for ($i = 2; $i < $ElementsInLine; $i++){
$SD = ( $EstimatedAgesSq[$i-2] - $EstimatedAges[$i-2]*$EstimatedAges[$i-2] ) ** ( 1 / 2) ; 
print EXIT "\t$SD";
}

print EXIT "\n";
close (FILE);
close (EXIT);

