while (<>){

chomp;
$Line = $_;
@SplitLine = split (/\s+/,$Line);
print "\n\n$SplitLine[2]\n";
$Subchain = substr($SplitLine[2],2);
print "$Subchain\n";
$Line = "git diff 1f077ef26ae496777f146bfd6ceb61684bb22132:$Subchain 118a2899c7fd102bba4a5ed2c9e4af8e2967f62a:$Subchain";
system($Line);
}

