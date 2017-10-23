$FileToOpen = $ARGV[0];
$TrajectoryNumber = $ARGV[1];
$ExitFile = $ARGV[2];
$N0 = $ARGV[3];

$N_Number = 0;
$PrintFlag = 0;
$TrajectoryToPrint = "";

open (FILE, $FileToOpen ) or die "NO!";
open (EXIT, ">$ExitFile" ) or die "NO!";

while (<FILE>){
chomp;
$Line = $_;
if ($Line =~ /n:/){
$N_Number++;
if ($N_Number == $TrajectoryNumber){
$PrintFlag = 1;
}else{
$PrintFlag = 0;
}
}

if ($PrintFlag == 1 ){
$TrajectoryToPrint = $TrajectoryToPrint."$Line\n";
} 

}

print EXIT "// This is an input file for Hudson's mssel stepftn.c program\n";
print EXIT "1 N0: $N0\n";
print EXIT "1\n";
print EXIT "$TrajectoryToPrint";
print "N number = $N_Number\n";

close(FILE);
close(EXIT);
