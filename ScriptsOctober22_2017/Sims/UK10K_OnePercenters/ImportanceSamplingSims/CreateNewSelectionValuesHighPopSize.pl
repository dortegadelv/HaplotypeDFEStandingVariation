$ExitFile = "NewSelectionHighPopSizeValues.txt";

open (EXIT,">$ExitFile") or "NO!";

$SelectionCoef = -0.0001088376/5;

for ($i = 200; $i >= 0 ; $i--) {
$NewCoef = $i * $SelectionCoef;
print EXIT "$NewCoef\n";
}

$SelectionCoef = 0.0001088376/5;

for ($i = 1; $i <= 200 ; $i++) {
$NewCoef = $i * $SelectionCoef;
print EXIT "$NewCoef\n";
}


close(EXIT);
