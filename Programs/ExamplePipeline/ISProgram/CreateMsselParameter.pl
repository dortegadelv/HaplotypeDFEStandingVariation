$DemographicParameters = $ARGV[0];
$ExitParameterFile = $ARGV[1];
open (DEMFILE, $DemographicParameters) or die "Cannot open $DemographicParameters\n";
open (EXITFILE, ">$ExitParameterFile") or die "Cannot open $ExitParameterFile\n";


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

$Line = $Line. "eN 0.0 1.0 0\n";
$TimeSum = 0;
for ($i = $LinesInFile - 2; $i > -1; $i--){
    
@SplitParams = split(/\s+/, $DemParams[$i+1]);
$Time = $SplitParams[1] /($CurrentPopSize * 2);
$TimeSum = $TimeSum + $Time;
@SplitParams = split(/\s+/, $DemParams[$i]);
$PopSize = $SplitParams[0] /($CurrentPopSize);
$Line = $Line. "eN $TimeSum $PopSize 0\n";
}

# $MsselOutput = "../Results/MsselOutput".$Seeds.".txt";
# $Line = $Line. " -seeds $Seeds $Seeds $Seeds > $MsselOutput\n";

print EXITFILE "$Line";

close(EXITFILE);
