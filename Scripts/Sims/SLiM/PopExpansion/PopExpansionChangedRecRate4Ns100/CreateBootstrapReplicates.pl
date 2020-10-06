$NumberOfNSFiles = `ls -l ReplicateNS_HapLength*.txt | wc -l`;
chomp($NumberOfNSFiles);

for ($BootNum = 1; $BootNum <= 100; $BootNum++){

print "NS $BootNum\n";
$BootstrapNsFile = "BootstrapNS".$BootNum.".txt";
open (BOOT,">$BootstrapNsFile") or die "NO!\n";

for ($i = 0; $i < 600; $i++){
$RandomNumber = int(rand($NumberOfNSFiles)) + 1;

$NSFile = "ReplicateNS_HapLength".$RandomNumber.".txt";

open (NSFILE,$NSFile) or die "NO!\n";

while (<NSFILE>){
chomp;
$Line = $_;
print BOOT "$Line\n";
}
close (NSFILE);
}
close (BOOT);
}

$NumberOfSynFiles = `ls -l ReplicateSyn_HapLength*.txt | wc -l`;
chomp($NumberOfSynFiles);

for ($BootNum = 1; $BootNum <= 100; $BootNum++){

print "Syn $BootNum\n";
$BootstrapNsFile = "BootstrapSyn".$BootNum.".txt";
open (BOOT,">$BootstrapNsFile") or die "NO!\n";

for ($i = 0; $i < 300; $i++){
$RandomNumber = int(rand($NumberOfSynFiles)) + 1;

$NSFile = "ReplicateSyn_HapLength".$RandomNumber.".txt";

open (NSFILE,$NSFile) or die "NO!\n";

while (<NSFILE>){
chomp;
$Line = $_;
print BOOT "$Line\n";
}
close (NSFILE);
}
close (BOOT);
}

