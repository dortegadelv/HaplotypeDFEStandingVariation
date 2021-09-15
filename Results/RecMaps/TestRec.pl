open (REC,"LeftBpRecRatePerVariantSynonymousNoCpGPrintMap143.txt") or "NO!";

$StartRec = 0;
$LineNumber = 0;
$Start = 9034733;
while (<REC>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/, $Line);
if ($SplitLine[1] eq $Start){
$StartRec = $StartRec + ($SplitLine[3] - $SplitLine[2]) * $SplitLine[4];
}else {
$StartRec = $StartRec / 250000;
print "$StartRec\n";
$StartRec = 0;
$StartRec = $StartRec + ($SplitLine[3] - $SplitLine[2]) * $SplitLine[4];
$Start = $SplitLine[1];
}
}
close (REC);

$StartRec = $StartRec / 250000;
print "$StartRec\n";

print "###\n";

open (REC,"RightBpRecRatePerVariantSynonymousNoCpGPrintMap143.txt") or "NO!";

$StartRec = 0;
$LineNumber = 0;
$Start = 9034733;
while (<REC>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/, $Line);
if ($SplitLine[1] eq $Start){
$StartRec = $StartRec + ($SplitLine[3] - $SplitLine[2]) * $SplitLine[4];
}else {
$StartRec = $StartRec / 250000;
print "$StartRec\n";
$StartRec = 0;
$StartRec = $StartRec + ($SplitLine[3] - $SplitLine[2]) * $SplitLine[4];
$Start = $SplitLine[1];
}

}
close (REC);

$StartRec = $StartRec / 250000;
print "$StartRec\n";

print "###\n";

open (REC,"LeftBpRecRatePerVariantNoCpGPrintMap269.txt") or "NO!";

$StartRec = 0;
$LineNumber = 0;
$Start = 11105542;
while (<REC>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/, $Line);
if ($SplitLine[1] eq $Start){
$StartRec = $StartRec + ($SplitLine[3] - $SplitLine[2]) * $SplitLine[4];
}else {
$StartRec = $StartRec / 250000;
print "$StartRec\n";
$StartRec = 0;
$StartRec = $StartRec + ($SplitLine[3] - $SplitLine[2]) * $SplitLine[4];
$Start = $SplitLine[1];
}
}
close (REC);

$StartRec = $StartRec / 250000;
print "$StartRec\n";

print "###\n";

open (REC,"RightBpRecRatePerVariantNoCpGPrintMap269.txt") or "NO!";

$StartRec = 0;
$LineNumber = 0;
$Start = 11105542;
while (<REC>){
chomp;
$Line = $_;
@SplitLine = split (/\s+/, $Line);
if ($SplitLine[1] eq $Start){
$StartRec = $StartRec + ($SplitLine[3] - $SplitLine[2]) * $SplitLine[4];
}else {
$StartRec = $StartRec / 250000;
print "$StartRec\n";
$StartRec = 0;
$StartRec = $StartRec + ($SplitLine[3] - $SplitLine[2]) * $SplitLine[4];
$Start = $SplitLine[1];
}

}
close (REC);

$StartRec = $StartRec / 250000;
print "$StartRec\n";

print "###\n";



