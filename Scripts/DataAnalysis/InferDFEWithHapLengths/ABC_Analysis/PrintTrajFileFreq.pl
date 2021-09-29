$AlleleList=$ARGV[0];

$CurTrajFile=$ARGV[1];

$PassTrajFile=$ARGV[2];

open (ALLELE,$AlleleList) or die "NO!";

@Alleles = ();
while (<ALLELE>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/,$Line);
push (@Alleles,$SplitLine[0]);
}

close (ALLELE);

open (TRAJ,$CurTrajFile) or die "NO";
open (EXIT,">$PassTrajFile") or die "NO!";

while (<TRAJ>){
chomp;
$Line = $_;
@SplitLine = split(/\s+/, $Line);

foreach $k (@Alleles){

if ($k eq $SplitLine[0]){
print EXIT "$Line\n";
}

}

}

close (TRAJ);
close (EXIT);

