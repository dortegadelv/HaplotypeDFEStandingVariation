$LeftRecRateFile = "../../../../Data/LeftBpRecRatePerVariantNoCpG.txt";
$RightRecRateFile = "../../../../Data/RighttBpRecRatePerVariantNoCpG.txt";

open (LEFT69,">../../../../Data/LeftBpRecRatePerVariantNoCpG69.txt") or die "NO";
open (LEFT70,">../../../../Data/LeftBpRecRatePerVariantNoCpG70.txt") or die "NO";
open (LEFT71,">../../../../Data/LeftBpRecRatePerVariantNoCpG71.txt") or die "NO";
open (LEFT72,">../../../../Data/LeftBpRecRatePerVariantNoCpG72.txt") or die "NO";
open (LEFT73,">../../../../Data/LeftBpRecRatePerVariantNoCpG73.txt") or die "NO";
open (LEFT74,">../../../../Data/LeftBpRecRatePerVariantNoCpG74.txt") or die "NO";
open (LEFT75,">../../../../Data/LeftBpRecRatePerVariantNoCpG75.txt") or die "NO";
open (LEFT76,">../../../../Data/LeftBpRecRatePerVariantNoCpG76.txt") or die "NO";

open (RIGHT69,">../../../../Data/RightBpRecRatePerVariantNoCpG69.txt") or die "NO";
open (RIGHT70,">../../../../Data/RightBpRecRatePerVariantNoCpG70.txt") or die "NO";
open (RIGHT71,">../../../../Data/RightBpRecRatePerVariantNoCpG71.txt") or die "NO";
open (RIGHT72,">../../../../Data/RightBpRecRatePerVariantNoCpG72.txt") or die "NO";
open (RIGHT73,">../../../../Data/RightBpRecRatePerVariantNoCpG73.txt") or die "NO";
open (RIGHT74,">../../../../Data/RightBpRecRatePerVariantNoCpG74.txt") or die "NO";
open (RIGHT75,">../../../../Data/RightBpRecRatePerVariantNoCpG75.txt") or die "NO";
open (RIGHT76,">../../../../Data/RightBpRecRatePerVariantNoCpG76.txt") or die "NO";

open (FILENUM,">../../../../Data/RecSynFileNumberNS.txt") or die "No";

for ($i = 0; $i < 273; $i++){
$HapLengthFile = "../../../../Data/Plink/HapLengths/HapLengthOnlyCpG".$i.".txt";
$LineCount = `wc -l $HapLengthFile | awk '{print $1}'`;
@LineParts = split(/\s+/, $LineCount);
print "File = $i $LineParts[0]\n";

if ($LineParts[0] == 4692){
$Number = $i + 1;
$LeftRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($LeftRecRate);
$RightRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($RightRecRate);
print LEFT69 "$LeftRecRate\n";
print RIGHT69 "$RightRecRate\n";
print FILENUM "69\n";
}
if ($LineParts[0] == 4830){
$Number = $i + 1;
$LeftRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($LeftRecRate);
$RightRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($RightRecRate);
print LEFT70 "$LeftRecRate\n";
print RIGHT70 "$RightRecRate\n";
print FILENUM "70\n";
}
if ($LineParts[0] == 4970){
$Number = $i + 1;
$LeftRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($LeftRecRate);
$RightRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($RightRecRate);
print LEFT71 "$LeftRecRate\n";
print RIGHT71 "$RightRecRate\n";
print FILENUM "71\n";
}
if ($LineParts[0] == 5112){
$Number = $i + 1;
$LeftRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($LeftRecRate);
$RightRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($RightRecRate);
print LEFT72 "$LeftRecRate\n";
print RIGHT72 "$RightRecRate\n";
print FILENUM "72\n";
}
if ($LineParts[0] == 5256){
$Number = $i + 1;
$LeftRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($LeftRecRate);
$RightRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($RightRecRate);
print LEFT73 "$LeftRecRate\n";
print RIGHT73 "$RightRecRate\n";
print FILENUM "73\n";
}
if ($LineParts[0] == 5402){
$Number = $i + 1;
$LeftRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($LeftRecRate);
$RightRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($RightRecRate);
print LEFT74 "$LeftRecRate\n";
print RIGHT74 "$RightRecRate\n";
print FILENUM "74\n";
}
if ($LineParts[0] == 5550){
$Number = $i + 1;
$LeftRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($LeftRecRate);
$RightRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($RightRecRate);
print LEFT75 "$LeftRecRate\n";
print RIGHT75 "$RightRecRate\n";
print FILENUM "75\n";
}
if ($LineParts[0] == 5700){
$Number = $i + 1;
$LeftRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($LeftRecRate);
$RightRecRate = `head -n$Number $LeftRecRateFile | tail -n1`;
chomp($RightRecRate);
print LEFT76 "$LeftRecRate\n";
print RIGHT76 "$RightRecRate\n";
print FILENUM "76\n";
}
if ($LineParts[0] == 0){
print FILENUM "0\n";
}
}

