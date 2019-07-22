$File = $ARGV[0];
$ExitFile = $ARGV[1];
$NumAncSequences = $ARGV[2];
$NumDerSequences = $ARGV[3];

$TotalNumberOfSequences = $NumAncSequences + $NumDerSequences;

open (FILE,$File) or die "NO!";
open (EXIT,">$ExitFile") or die "NO!\n";

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
	for ($j = $NumAncSequences; $j < $TotalNumberOfSequences; $j++){
		for ($k = $j+1; $k < $TotalNumberOfSequences; $k++){
			$MiniFlag = 0;
			$TotalSum = $TotalSum + 1;
#			print "$j $k $Sequences[$j] $Sequences[$k]\n";
			for ($i = $SelSite+1; $i < length($Sequences[0]); $i++){
				$SubstrOne = substr($Sequences[$j],$i,1);
				$SubstrTwo = substr($Sequences[$k],$i,1);
				if ($SubstrOne ne $SubstrTwo){
					$Distance = $Positions[$i+1] - $Position;
#					print EXIT "$Positions[$i+1]\n";
					print EXIT "$Distance\n";
					$MiniFlag = 1;
					last;
				}
			}
			if ($MiniFlag == 0){
				print EXIT "2.0\n";
			}			
		}
		$FlagSequences = 0;
	}
	$NumberOfSequences = 0;	
#	print "Total Sum = $TotalSum\n";
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

# for ($j = $NumAncSequences; $j < $TotalNumberOfSequences; $j++){
#	for ($k = $j+1; $k < $TotalNumberOfSequences; $k++){
#		$MiniFlag = 0;
#		print "$j $k $Sequences[$j] $Sequences[$k]\n";
#		for ($i = $SelSite+1; $i < length($Sequences[0]); $i++){
#			$SubstrOne = substr($Sequences[$j],$i,1);
#			$SubstrTwo = substr($Sequences[$k],$i,1);
#			if ($SubstrOne ne $SubstrTwo){
#				print EXIT "$Positions[$i+1]\n";
#				$MiniFlag = 1;
#				last;
#			}
#		}
#		if ($MiniFlag == 0){
#			print EXIT "2.0\n";
#		}			
#	}
#	$FlagSequences = 0;
# }	

close (FILE);
close (EXIT);


