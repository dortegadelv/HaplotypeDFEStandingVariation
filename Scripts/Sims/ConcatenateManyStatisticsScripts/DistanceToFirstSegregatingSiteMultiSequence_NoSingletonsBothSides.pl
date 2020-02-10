$File = $ARGV[0];
$ExitFile = $ARGV[1];
$NumAncSequences = $ARGV[2];
$NumDerSequences = $ARGV[3];
$FalseNegativeRate = $ARGV[4];
$FalsePositiveRate = $ARGV[5];
$RandomNumber = $ARGV[6];
$BpNumber = $ARGV[7];

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
#	print "Here!\n";
	$NumberOfSequences++;
if ($NumberOfSequences == $TotalNumberOfSequences ){
	print "Here!\n";
	$TotalSum = 0;
	@Frequencies = ();
	for ($i = $SelSite+1; $i < length($Sequences[0]); $i++){
	$Frequencies[$i] = 0;
	for ($j = $NumAncSequences; $j < $TotalNumberOfSequences; $j++){
		$Frequencies[$i] = $Frequencies[$i] + substr($Sequences[$j],$i,1);
	}
#	print "Freq site $i = $Frequencies[$i] Total seq number = $TotalNumberOfSequences\n";
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
				if (($SubstrOne ne $SubstrTwo) ) {
					$Distance = abs ( $Positions[$i+1] - $Position ) * 2;
#					print EXIT "$Positions[$i+1]\n";
					print EXIT "$Distance\n";
#					print "seq = $j seq = $k Site = $i Frequency = $Frequencies[$i]\n";
					$MiniFlag = 1;
					last;
				}
			}
			if ($MiniFlag == 0){
				$BigNum = $BpNumber + 1;
				print EXIT "2.0\n";
			}
                        $MiniFlag = 0;
                        $TotalSum = $TotalSum + 1;
                        for ($i = $SelSite-1; $i >= 0; $i--){
                                $SubstrOne = substr($Sequences[$j],$i,1);
                                $SubstrTwo = substr($Sequences[$k],$i,1);
                                if (($SubstrOne ne $SubstrTwo) ) {
                                        $Distance = abs ( $Positions[$i+1] - $Position ) * 2;
                                        print EXIT "$Distance\n";
                                        $MiniFlag = 1;
                                        last;
                                }
                        }
                        if ($MiniFlag == 0){
                                $BigNum = $BpNumber + 1;
                                print EXIT "2.0\n";
                        }
		}
		$FlagSequences = 0;
	}
	$NumberOfSequences = 0;	
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
# print "Position = $Position\n";
#	print "$Line\tF=$FlagSequences\n";
}

}

close (FILE);
close (EXIT);


