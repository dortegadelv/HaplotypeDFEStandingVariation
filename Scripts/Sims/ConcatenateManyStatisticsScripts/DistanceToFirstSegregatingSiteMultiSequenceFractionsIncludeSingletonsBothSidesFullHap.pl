$File = $ARGV[0];
$ExitFile = $ARGV[1];
$NumAncSequences = $ARGV[2];
$NumDerSequences = $ARGV[3];
$FalseNegativeRate = $ARGV[4];
$FalsePositiveRate = $ARGV[5];
$RandomNumber = $ARGV[6];
$BpNumber = $ARGV[7];
$BoundariesFile=$ARGV[8];

@Bounds = ();
open (BOUNDS,$BoundariesFile) or die "NO!";

while(<BOUNDS>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push(@Bounds,$SplitLine[0]);
}

close(BOUNDS);

@WindowCount = ();
foreach $i (@Bounds){
push(@WindowCount,0);
}

$TotalNumberOfSequences = $NumAncSequences + $NumDerSequences;
@Distances = ();

open (FILE,$File) or die "NO!";
open (EXIT,">>$ExitFile") or die "NO!\n";

$FlagSequences = 0;
$NumberOfSequences = 0;
$SelSite = 0;

while(<FILE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);

if ($FlagSequences == 1){
	push(@Sequences,$Line);
#	print "Here! $Line\n";
	$NumberOfSequences++;
if ($NumberOfSequences == $TotalNumberOfSequences ){
	$TotalSum = 0;
	@Frequencies = ();
	for ($i = $SelSite+1; $i < length($Sequences[0]); $i++){
	$Frequencies[$i] = 0;
	for ($j = $NumAncSequences; $j < $TotalNumberOfSequences; $j++){
		$Frequencies[$i] = $Frequencies[$i] + substr($Sequences[$j],$i,1);
	}
	}
	for ($j = $NumAncSequences; $j < $TotalNumberOfSequences; $j++){
		for ($k = $j+1; $k < $TotalNumberOfSequences; $k++){
			$MiniFlag = 0;
			$TotalSum = $TotalSum + 1;
#			print "$j $k $Sequences[$j] $Sequences[$k]\n";
#			@VectorOne = split("", $Sequences[$j]);
#			@VectorTwo = split("", $Sequences[$k]);
			for ($i = $SelSite+1; $i < length($Sequences[0]); $i++){
				$SubstrOne = substr($Sequences[$j],$i,1);
				$SubstrTwo = substr($Sequences[$k],$i,1);
#				$SubstrOne = $VectorOne[$i];
#				$SubstrTwo = $VectorTwo[$i];
				if (($SubstrOne ne $SubstrTwo) ){
					$Distance = $Positions[$i+1];
#					print EXIT "$Positions[$i+1]\n";
#					print EXIT "$Distance\n";
					$MiniFlag = 1;
					last;
				}
			}
			if ($MiniFlag == 0){
#				print EXIT "2.0\n";
				$Distance = 2.0;
			}
			$MiniFlag = 0;
                        for ($i = $SelSite-1; $i >= 0; $i--){
                                $SubstrOne = substr($Sequences[$j],$i,1);
                                $SubstrTwo = substr($Sequences[$k],$i,1);
                                if (($SubstrOne ne $SubstrTwo) ){
					if ($Distance != 2.0){
                                        $Distance = ($Distance - $Positions[$i+1]) * $BpNumber;
                                        $NumberOfDistances++;
					$MiniFlag = 1;
                                        for ($l = 0; $l <= scalar(@Bounds); $l++) {
                                                if ( ($Distance >= $Bounds[$l]) && ($Distance <= $Bounds[$l+1]) ){
							$WindowCount[$l]++;
                                                last;
                                        }
                                        }
                                        last;
                                }else{
				$CurrentDistance = int(($Position - $Positions[$i+1]) / 0.1 );
				$Distance = (2.0 + $CurrentDistance) * $BpNumber;
				$NumberOfDistances++;
				$MiniFlag = 1;
                                for ($l = 0; $l <= scalar(@Bounds); $l++) {
                                     if ( ($Distance >= $Bounds[$l]) && ($Distance <= $Bounds[$l+1]) ){
                                         $WindowCount[$l]++;
                                         last;
                                        }
				}
			last;
			}
			}	
			}
                        if ($MiniFlag == 0){
			    $NumberOfDistances++;
                            if ($Distance != 2.0){
				$CurrentDistance = int(($Distance - $Position) / 0.1 );
				$Distance = (7.0 + $CurrentDistance) * $BpNumber;
				} else {
                		$Distance = (12.0 ) * $BpNumber;
                		}
                                        for ($l = 0; $l <= scalar(@Bounds); $l++) {
                                                if ( ($Distance >= $Bounds[$l]) && ($Distance <= $Bounds[$l+1]) ){
                                                $WindowCount[$l]++;
                                                last;
                                        }
                                        }
                        }
		}
		$FlagSequences = 0;
	$NumberOfSequences = 0;	
}
}
}
if ($SplitLine[0] eq "selsite:"){
$SelSite = $SplitLine[1];
}
if ($SplitLine[0] eq "positions:"){

$Position = $SplitLine[$SelSite+1];
$FlagSequences = 1;
@Sequences = ();
@Positions = @SplitLine;
#	print "$Line\tF=$FlagSequences\n";
}
}
close (FILE);

for ($j = 0; $j < scalar(@WindowCount) ; $j++){
$Fraction = $WindowCount[$j]/$NumberOfDistances;
print EXIT "$Fraction\t";
}

print EXIT "\n";
close (EXIT);
