$ExitFile = "NewSelectionValues.txt";

open (EXIT,">$ExitFile") or "NO!";

$SelectionCoef = -.000033404596472;

for ($i = 200; $i >= 0 ; $i--) {
$NewCoef = $i * $SelectionCoef;
print EXIT "$NewCoef\n";
}

$SelectionCoef = .000033404596472;

for ($i = 1; $i <= 200 ; $i++) {
$NewCoef = $i * $SelectionCoef;
print EXIT "$NewCoef\n";
}


close(EXIT);
