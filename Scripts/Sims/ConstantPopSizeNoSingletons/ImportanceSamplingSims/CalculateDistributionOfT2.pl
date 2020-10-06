$TrajectoryFile = $ARGV[0];

$BoundsOnT2 = $ARGV[1];

$ExitLengthFile = $ARGV[2];

$RecombinationRate = 1 * (10 **(-8));
@BpBounds = ();
open (BOUNDS,$BoundsOnT2) or die "NO! $BoundsOnT2\n";

while(<BOUNDS>){
chomp;
$Line = $_;
push(@BpBounds,$Line);
}

close(BOUNDS);

open (TRAJ,$TrajectoryFile) or die "NO! $TrajectoryFile\n";
$PrintFlag = 0;

@TrajectoriesVector = ();
$TrajectoryNumber = -1;

while(<TRAJ>){

	chomp;
	$Line = $_;
	@SplitLine = split(/\s+/,$Line);
		
	if ($Line =~ /REP/){
		$PrintFlag = 1;
		$TrajectoryNumber++;
		$TrajectoryVector[$TrajectoryNumber] = "";
		$TrajectoryVector[$TrajectoryNumber] = "$Line\n";
	} elsif ($Line =~ /TOT/){
		$PrintFlag = 0;
	} elsif($PrintFlag == 1){
		@MiniSplit = split(/\s+/,$Line);
		$TrajectoryVector[$TrajectoryNumber] = $TrajectoryVector[$TrajectoryNumber]."$MiniSplit[1]\t$MiniSplit[2]\n";
	}
	
}

close(TRAJ);

open (LENGTH,">$ExitLengthFile" ) or die "NO!";

$LogOf10 = log(10);
print "log of 10 = $LogOf10\n";
$ExpectedValue = 0;
$SquareExpectedValue = 0;
print "Traj Start 0 = $TrajectoryVector[0] Traj End\n";
print "Traj Start 1 = $TrajectoryVector[1] Traj End\n";
# die "NO!\n";
for ($i = 0; $i <= $TrajectoryNumber; $i++){
@DistributionOfTimes = ();
	$ExpectedValue = 0;
	$SquareExpectedValue = 0;
	$ProbSum = 0;
	$DeltaDown = Delta($TrajectoryVector[$i],0.5,20000);
	$ExpValueDown = exp(-$DeltaDown);
	$ProbSum = 1 - $ExpValueDown;
	
	$DownProbabilities = $ProbSum;
#	print "Prob sum = $ProbSum $ExpValueDown $DeltaDown\n";
	@AllT2Probabilities = ();
	for ($j = 0; $j <  scalar(@T2Bounds); $j++){
	$AllT2Probabilities[$j] = 0;
	}
	for ($j = 1; $j <= 1000000; $j++){

		$DeltaUp = Delta($TrajectoryVector[$i],$j+.5,20000);
		$DeltaDown = Delta($TrajectoryVector[$i],$j-.5,20000);
		if ( ( $DeltaUp == 100000 ) || ( $ProbSum > 0.9999999999999) ){
			$CurrentProb = (1 - $ProbSum) ;
			print "CurrentProb = $i $j $CurrentProb\n";
			$ExpectedValue = $ExpectedValue + $j * $CurrentProb;
			$SquareExpectedValue = $SquareExpectedValue + exp(log($j)+log($j)+log($CurrentProb));
			$ProbSum = 1;
			$Variance = $SquareExpectedValue - $ExpectedValue * $ExpectedValue;
			$sd = $Variance**(1/2);
	                for ( $l = 0; $l < ( scalar(@BpBounds) - 1); $l++){
        	                $AllT2Probabilities[$l] = $AllT2Probabilities[$l] + $CurrentProb * ( (1 - exp(-2*$BpBounds[$l+1]*$RecombinationRate*$j)) - (1 - exp(-2*$BpBounds[$l]*$RecombinationRate*$j)) );
                	}
#			print "Final Delta = $j\t$CurrentProb\t$ProbSum\t$ExpectedValue\t$Variance\t$sd\n";
			print LENGTH "$ExpectedValue\t";
			for ( $l = 0; $l < ( scalar(@BpBounds) - 1); $l++){
				print LENGTH "$AllT2Probabilities[$l]\t";
			}
			print LENGTH "\n";
#			print "\n";
			last;
		}else{
		$ExpValueUp = exp(-$DeltaUp);
		$ExpValueDown = exp(-$DeltaDown);
		$CurrentProb = ( $ExpValueDown - $ExpValueUp ) ;
		$FractionUp = ($j+.5) / 40000;
		$FractionDown = ($j-.5) / 40000;
		$ProbSum = $ProbSum + $CurrentProb;
		$ExpectedValue = $ExpectedValue + $j * $CurrentProb;
		$SquareExpectedValue = $SquareExpectedValue + exp(log($j)+log($j)+log($CurrentProb));
#		print "$j $CurrentProb $ExpValueUp $DeltaUp $ExpValueDown $DeltaDown $ProbSum ";
		if ($ProbSum > 0.999999999999999){
#		print "ONE!";	
		}
#		print "\n";
#					print "Expected value = $ExpectedValue\n";
		for ( $l = 0; $l < ( scalar(@BpBounds) - 1); $l++){
			$AllT2Probabilities[$l] = $AllT2Probabilities[$l] + $CurrentProb * ( (1 - exp(-2*$BpBounds[$l+1]*$RecombinationRate*$j)) - (1 - exp(-2*$BpBounds[$l]*$RecombinationRate*$j)) );
		}
#					print "Delta = $FractionDown\t$FractionUp\t$j\t$DeltaUp\t$DeltaDown\t$ExpValueUp\t$ExpValueDown\t$CurrentProb\t$ProbSum\t$SubElements[1]\n";
		if ($CurrentProb < 0){
		die "NO!";
		}
		}
	}
#	if ($i == 100){
#	die "NO $ProbSum $ExpectedValue\n";
#	}

}

sub Delta {

	my ($Trajectory, $GenNumber, $N_2) = @_;
	#	print "$Trajectory$GenNumber\n$N_2\n";
	@NumberOfElementsInTrajectory = split(/\n/,$Trajectory);
	$ElementNumber = scalar(@NumberOfElementsInTrajectory) - 1;
	$Fraction = $GenNumber / (2*$N_2);
	#	print "Fraction = $Fraction\n";
	$CurrentDelta = 0;
	for ($k = 1; $k <= $ElementNumber; $k++){
		#		print "$GenNumber $Fraction k=$k $NumberOfElementsInTrajectory[$k] $CurrentDelta\n";
		#		print "Traj = $NumberOfElementsInTrajectory[$k]\n";		
		if ($Fraction == $NumberOfElementsInTrajectory[$k + 1]) {
			@CurrentElements = split (/\s+/,$NumberOfElementsInTrajectory[$k]);
			$CurrentDelta = $CurrentDelta + ( 1 / $CurrentElements[1] )* ( $Fraction - $CurrentElements[0])*2;
			last;
		}
		elsif ( ( $Fraction <= $NumberOfElementsInTrajectory[$k + 1] ) && ( $Fraction > $NumberOfElementsInTrajectory[$k]) ){
			@CurrentElements = split (/\s+/,$NumberOfElementsInTrajectory[$k]);
			#			print "Element = $Fraction $CurrentElements[0]\n";
			$CurrentDelta = $CurrentDelta + ( 1 / $CurrentElements[1] ) * ( $Fraction - $CurrentElements[0])*2;
			last;
		}
		@CurrentElements = split (/\s+/,$NumberOfElementsInTrajectory[$k]);
		if ($k < $ElementNumber){
		@FutureElements = split (/\s+/,$NumberOfElementsInTrajectory[$k+1]);
		$CurrentDelta = $CurrentDelta + ( 1 / $CurrentElements[1] ) * ($FutureElements[0] - $CurrentElements[0])*2;
		}else{
#			print "CurEl = $CurrentElements[0] $CurrentElements[1]\n";
			$CurrentDelta = 100000;
		}
	}
	#	print "DeltaFun = $CurrentDelta\n";
	#	print "Number of elements = $ElementNumber\n";
	return($CurrentDelta);
}
