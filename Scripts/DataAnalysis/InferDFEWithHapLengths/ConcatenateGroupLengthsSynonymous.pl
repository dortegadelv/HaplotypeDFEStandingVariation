for ($i = 0; $i < 4 ; $i++){

@HapLengths = ();
$Group = "../../../Data/GroupsPerRecRateSynonymous".$i.".txt";
open (GROUP,$Group) or die "NO!";
$LengthsPerGroup = "../../../Data/LengthsGroupsPerRecRateSynonymous".$i.".txt";
open (LENGTH,">$LengthsPerGroup") or die "NO!";
while (<GROUP>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
if ($SplitLine[1] ne ""){
print "$Line\n";
$HapFile = "../../../Data/Plink/HapLengths/HapLengthSynonymous".$SplitLine[1].".txt";
open (HAP,$HapFile) or die "NO! $HapFile";
while(<HAP>){
chomp;
$Line = $_;
print LENGTH "$Line\n";
}
close (HAP);
}
}

close (GROUP);
close (LENGTH);
}

