$Theta = $ARGV[0];
$Rho = $ARGV[1];
$DemographicParameters = $ARGV[2];
$NumberOfHaplotypesWithTheDerivedAllele= $ARGV[3];
$NumberOfIndependentVariants= $ARGV[4];
$NumberSites = $ARGV[5];
$Seeds = $ARGV[6];
$VariantSum = $NumberOfHaplotypesWithTheDerivedAllele + 1;

$Line = "time ../Mssel/mssel3 $VariantSum $NumberOfIndependentVariants 1 $NumberOfHaplotypesWithTheDerivedAllele ".'$ResampledTrajectory'." 1 -r $Rho $NumberSites -t $Theta";

open (DEMFILE, $DemographicParameters) or die "Cannot open $DemographicParameters\n";

@DemParams = ();
$LinesInFile = 0;
while (<DEMFILE>){
    chomp;
    $OutLine = $_;
    push(@DemParams, $OutLine);
    $LinesInFile++;
#    @SplitLine = split(/\s+/,$Line);
    
}
close (DEMFILE);

@LastLine = split(/\s+/, $DemParams[$LinesInFile-1]);
$CurrentPopSize = $LastLine[0];

$Line = $Line. " -eN 0.0 1.0";
$TimeSum = 0;
for ($i = $LinesInFile - 2; $i > -1; $i--){
    
@SplitParams = split(/\s+/, $DemParams[$i+1]);
$Time = $SplitParams[1] /($CurrentPopSize * 2);
$TimeSum = $TimeSum + $Time;
@SplitParams = split(/\s+/, $DemParams[$i]);
$PopSize = $SplitParams[0] /($CurrentPopSize);
$Line = $Line. " -eN $TimeSum $PopSize";
}

$MsselOutput = "../Results/MsselOutput".$Seeds.".txt";
$Line = $Line. " -seeds $Seeds $Seeds $Seeds > $MsselOutput\n";

print "$Line";
