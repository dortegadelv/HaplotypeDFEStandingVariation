$TrajectoryFile = $ARGV[0];
$NumberOfReps = $ARGV[1];
$Ne = $ARGV[2];
$ExitLengthFile = $ARGV[3];
### Ne is the number of chromosomes


@T2Probabilities = ();
@DiscreteT2Probabilities = ();
for ($i = 1; $i <= 40000; $i++){
$T2Probabilities[$i] = 0;
$DiscreteT2Probabilities[$i] = 0;
}

for ($TrajNumber = 0; $TrajNumber < $NumberOfReps ; $TrajNumber++){
$TrajFileName = $TrajectoryFile.$TrajNumber.".dat";
print "$TrajFileName\n";
open (TRAJ,$TrajFileName) or die "NO! $TrajFileName\n";
@TrajectoryUpVector = ();
@TrajectoryDownVector = ();
@PopSizeVector = ();
@AlleleFrequencyVector = ();
@NeValuesOverTime = ();

while(<TRAJ>){

	chomp;
	$Line = $_;
	@SplitLine = split(/\s+/,$Line);
		
	push(@TrajectoryUpVector, $SplitLine[0]);
        push(@TrajectoryDownVector, $SplitLine[1]);
        push(@PopSizeVector, $SplitLine[2]);
        push(@AlleleFrequencyVector, $SplitLine[3]);

	for ( $i = int ( ( $SplitLine[0] * $Ne * 2) + 0.5); $i < int ( ( $SplitLine[1] * $Ne * 2) + 0.5); $i++ ){
		
		$CurrentNe = int ( $Ne * $SplitLine[2] * $SplitLine[3] + 0.5 );
		push (@NeValuesOverTime, $CurrentNe);
#		print "$i\t$CurrentNe\n";
		last if ( $SplitLine[1] == 999.0);
	} 
}

close(TRAJ);

$N_0 = $NeValuesOverTime[0];
$NumberOfElementsInPopSizeVector = scalar(@NeValuesOverTime);
$ProbSum = 0;
$DiscreteSummedProb = 1;
$DiscreteCumulativeProb = 0;
for ( $j = 1 ; $j <= 40000 ; $j++ ) {
#	print "Pop size = $j $NeValuesOverTime[$j] ";
#	if ($NeValuesOverTime[$j] == 0){
#	die "Here?\n";
#	last;
#	}
	if ($NeValuesOverTime[$j] != 0){
	$DiscreteT2Probabilities[$j] = $DiscreteT2Probabilities[$j] + $DiscreteSummedProb * (1/$NeValuesOverTime[$j]);
	$DiscreteCumulativeProb = $DiscreteCumulativeProb + $DiscreteSummedProb * (1/$NeValuesOverTime[$j]);
	$DiscreteSummedProb = $DiscreteSummedProb * (1 - (1/$NeValuesOverTime[$j]));
# 	$DiscreteCumulativeProb = $DiscreteCumulativeProb + $DiscreteSummedProb * (1/$NeValuesOverTime[$j]);
	}else{
#	if ($DiscreteCumulativeProb < 1){
	$DiscreteT2Probabilities[$j-1] = $DiscreteT2Probabilities[$j-1] + (1 - $DiscreteCumulativeProb);
#	}
	$DiscreteCumulativeProb = 1;
	}
	$DeltaUp = Delta(\@NeValuesOverTime,$j+.5,$N_0,$NumberOfElementsInPopSizeVector);
	$DeltaDown = Delta(\@NeValuesOverTime,$j-.5,$N_0,$NumberOfElementsInPopSizeVector);
	if ( ( $DeltaUp == 100000 ) || ( $ProbSum > 0.9999999999999) ){
	$CurrentProb = (1 - $ProbSum) ;
	$ExpectedValue = $ExpectedValue + $j * $CurrentProb;
	$ProbSum = $ProbSum + $CurrentProb;
	$T2Probabilities[$j] = $T2Probabilities[$j] + $CurrentProb;
	last;
	}else{
	$ExpValueUp = exp(-$DeltaUp);
	$ExpValueDown = exp(-$DeltaDown);
	$CurrentProb = ( $ExpValueDown - $ExpValueUp ) ;
	$FractionUp = ($j+.5) / $N_0;
	$FractionDown = ($j-.5) / $N_0;
	$ProbSum = $ProbSum + $CurrentProb;
	$T2Probabilities[$j] = $T2Probabilities[$j] + $CurrentProb;
	if ($j == 1){
	$ProbSum = $ProbSum + ( 1 - $ExpValueDown);
	}
	$ExpectedValue = $ExpectedValue + $j * $CurrentProb;
#	print "$ProbSum\n";

	}
}
}
# print "Expected value = $ExpectedValue $ProbSum\n";
# print OUT "$ExpectedValue";
open (EXIT,">$ExitLengthFile") or die "NO!\n";
for ( $l = 1; $l <= 40000; $l++){
#	print "$AllT2Probabilities[$l]\t";
	$TotalProb = $T2Probabilities[$l] / $NumberOfReps;
	$DiscreteTotalProb = $DiscreteT2Probabilities[$l] / $NumberOfReps;
	print EXIT "$l\t$TotalProb\t$DiscreteTotalProb\n";
}

close(EXIT);
sub Delta {

my ($Trajectory, $GenNumber, $N_2, $NumberOfElementsInPopSizeVector) = @_;
# die "Inside delta function. Elements in vector $NumberOfElementsInPopSizeVector\n";

$Fraction = $GenNumber;
$CurrentDelta = 0;
$CurrentDelta = $CurrentDelta + ( 1 / ( ($Trajectory->[0]) / ($Trajectory->[0])  ) )* ( 0.5 / $Trajectory->[0]);
# print "Starting Delta = $CurrentDelta $Trajectory->[0]\n";

for ($k = 1; $k <= $GenNumber; $k++){

if ($Trajectory->[$k] == 0){
$CurrentDelta = 100000;
last;
}elsif ($GenNumber == $k) {
$CurrentDelta = $CurrentDelta + ( 1 / ( ($Trajectory->[$k]) / ($Trajectory->[0])  ) )* ( 1 / $Trajectory->[0]);
last;
}
else {
$CurrentDelta = $CurrentDelta + ( 1 / ( ($Trajectory->[$k]) / ($Trajectory->[0])  ) )* ( 1 / $Trajectory->[0]);
}

}
# die "Delta value = $CurrentDelta\n";
return($CurrentDelta);
}


