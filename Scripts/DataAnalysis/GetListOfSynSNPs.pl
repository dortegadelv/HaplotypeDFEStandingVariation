for ($i = 1; $i <= 22 ; $i++){
print "Chromosome $i\n";
$File = "../../Data/UK10K_COHORTChr".$i.".20160215.sites";
$ExitSynFiles = "../../Data/Plink/SynSites".$i.".txt";
open (FILE,$File) or die "NO!";
open (EXIT,">$ExitSynFiles") or die "NO!";

while (<FILE>){
chomp;
if (/syn/){
$Line = $_;
@SplitLine = split(/\s+/,$Line);
@MiniStuff = split(/\./,$SplitLine[1]);
$SNP = $i.".".$MiniStuff[0];
print EXIT "$SNP\n";
}
}

close (FILE);
close (EXIT);
}

