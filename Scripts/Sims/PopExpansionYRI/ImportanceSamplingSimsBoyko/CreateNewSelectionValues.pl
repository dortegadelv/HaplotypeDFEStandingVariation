$ExitFile = "NewSelectionValues.txt";

open (EXIT,">$ExitFile") or "NO!";

$SelectionCoef = -.000021219708865;

for ($i = 400; $i >= 0 ; $i--) {
$NewCoef = $i * $SelectionCoef;
print EXIT "$NewCoef\n";
}

$SelectionCoef = .000021219708865;

for ($i = 50; $i <= 50 ; $i++) {
$NewCoef = $i * $SelectionCoef;
print EXIT "$NewCoef\n";
}


close(EXIT);
