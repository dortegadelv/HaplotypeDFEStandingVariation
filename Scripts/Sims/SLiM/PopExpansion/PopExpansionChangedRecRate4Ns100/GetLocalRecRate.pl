$Chromosome= $ARGV[0];
$Position = $ARGV[1];
$RecRateFile = $ARGV[2];

$StartingPositionLeft = $Position - 250000;
$StartingPositionRight = $Position;

$EndingPositionLeft = $Position;
$EndingPositionRight = $Position + 250000;

open (REC, "zcat annotations/hg19.recomb.map.txt.gz |") or die "NO\n";
open (EXIT, ">$RecRateFile") or die "NO!\n";

$MeanRecRateLeft = 0;
$MeanRecRateRight = 0;
$LowerBoundary = $Position - 250000;
$UpperBoundary = $Position + 250000;
$SumBp = 0;

while (<REC>) {

chomp;
$Line = $_;
# print "$Line\n";
@SplitLine = split (/\s+/, $Line);
$ChrField = "chr".$Chromosome;

if ( ( $ChrField eq $SplitLine[0] ) && ( $LowerBoundary >= $SplitLine[1] ) && ( $LowerBoundary <  $SplitLine[2]  )  ){
$MeanRecRateLeft = $MeanRecRateLeft + $SplitLine[3] * ( $SplitLine[2] - $LowerBoundary ) ;
print "$Line\n";
$SumBp = $SumBp + ( $SplitLine[2] - $LowerBoundary ) ;
}

if ( ( $ChrField eq $SplitLine[0] ) && ( $SplitLine[1] >= $LowerBoundary ) && ( $SplitLine[2] >= $LowerBoundary ) && ( $SplitLine[1] <= $Position ) && ( $SplitLine[2] <= $Position ) ){
$MeanRecRateLeft = $MeanRecRateLeft + $SplitLine[3] * 10000 ;
print "$Line\n";
$SumBp = $SumBp + 10000 ;
}

if ( ( $ChrField eq $SplitLine[0] ) && ( $Position > $SplitLine[1] ) && ( $Position < $SplitLine[2] ) ){
$MeanRecRateLeft = $MeanRecRateLeft + $SplitLine[3] * ( $Position - $SplitLine[1]  ) ;
$MeanRecRateRight = $MeanRecRateRight + $SplitLine[3] * ( $SplitLine[2] - $Position ) ; 
print "$Line\n";
$SumBp = $SumBp + ( $Position - $SplitLine[1]  ) ;
$SumBp = $SumBp + ( $SplitLine[2] - $Position ) ; 
}

if ( ( $ChrField eq $SplitLine[0] ) && ( $UpperBoundary >= $SplitLine[1] ) && ( $UpperBoundary <  $SplitLine[2]  )  ){
$MeanRecRateRight = $MeanRecRateRight + $SplitLine[3] * ( $UpperBoundary - $SplitLine[1]) ;
print "$Line\n";
$SumBp = $SumBp + ( $UpperBoundary - $SplitLine[1]) ;
}

if ( ( $ChrField eq $SplitLine[0] ) && ( $SplitLine[1] <= $UpperBoundary ) && ( $SplitLine[2] <= $UpperBoundary ) && ( $SplitLine[1] >= $Position ) && ( $SplitLine[2] >= $Position ) ){
$MeanRecRateRight = $MeanRecRateRight + $SplitLine[3] * 10000 ;
print "$Line\n";
$SumBp = $SumBp + 10000 ;
}

}

close (REC);
$MeanRecRateLeft = $MeanRecRateLeft / 250000;
$MeanRecRateRight = $MeanRecRateRight / 250000;
print "bp sum = $SumBp $MeanRecRateLeft $MeanRecRateRight\n";
print EXIT "$Chromosome\t$Position\t$MeanRecRateLeft\t$MeanRecRateRight\n";

close (EXIT);

