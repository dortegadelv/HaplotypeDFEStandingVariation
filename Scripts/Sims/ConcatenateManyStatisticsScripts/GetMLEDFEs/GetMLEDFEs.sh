#$ -l h_vmem=2g
#$ -cwd
#$ -N ForWF
#$ -o ../Trash
#$ -e ../Trash


Line[1]="perl GetMLEDFEs.pl ../../../../Results/ConstantPopSizeBoyko/ForwardSims/HapLengths/ExitFileNoRecCombinedN ../../../../Results/MLEDFEs/ConstantBoykoMLE.txt"
Line[2]="perl GetMLEDFEs.pl ../../../../Results/ConstantPopSizeMouse/ForwardSims/HapLengths/ExitFileNoRecCombinedN ../../../../Results/MLEDFEs/ConstantMouseMLE.txt"
Line[3]="perl GetMLEDFEs.pl ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/ExitFileNoRecCombinedN ../../../../Results/MLEDFEs/PopExpansionBoykoMLE.txt"
Line[4]="perl GetMLEDFEs.pl ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/HapLengths/ExitFileNoRecCombinedN ../../../../Results/MLEDFEs/PopExpansionMouseMLE.txt"
Line[5]="perl GetMLEDFEsOneMillion.pl ../../../../Results/ConstantPopSizeBoyko/ForwardSims/HapLengths/ExitFileNoRecCombinedN ../../../../Results/MLEDFEs/ConstantBoykoMLEOneMillion.txt"
Line[6]="perl GetMLEDFEsOneMillion.pl ../../../../Results/ConstantPopSizeMouse/ForwardSims/HapLengths/ExitFileNoRecCombinedN ../../../../Results/MLEDFEs/ConstantMouseMLEOneMillion.txt"
Line[7]="perl GetMLEDFEsOneMillion.pl ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/ExitFileNoRecCombinedN ../../../../Results/MLEDFEs/PopExpansionBoykoMLEOneMillion.txt"
Line[8]="perl GetMLEDFEsOneMillion.pl ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/HapLengths/ExitFileNoRecCombinedN ../../../../Results/MLEDFEs/PopExpansionMouseMLEOneMillion.txt"
Line[9]="perl GetMLEDFEsTenMillionBootstrap.pl ../../../../Results/ConstantPopSizeBoyko/ForwardSims/HapLengths/ExitFileNoRecN ../../../../Results/MLEDFEs/ConstantBoykoMLETenMillionBootstrap.txt"
Line[10]="perl GetMLEDFEsTenMillionBootstrap.pl ../../../../Results/ConstantPopSizeMouse/ForwardSims/HapLengths/ExitFileNoRecN ../../../../Results/MLEDFEs/ConstantMouseMLETenMillionBootstrap.txt"
Line[11]="perl GetMLEDFEsTenMillionBootstrap.pl ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/ExitFileNoRecN ../../../../Results/MLEDFEs/PopExpansionBoykoMLETenMillionBootstrap.txt"
Line[12]="perl GetMLEDFEsTenMillionBootstrap.pl ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/HapLengths/ExitFileNoRecN ../../../../Results/MLEDFEs/PopExpansionMouseMLETenMillionBootstrap.txt"
Line[13]="perl GetMLEDFEsOneHundredMillionBootstrap.pl ../../../../Results/ConstantPopSizeBoyko/ForwardSims/HapLengths/ExitFileNoRecN ../../../../Results/MLEDFEs/ConstantBoykoMLEOneHundredMillionBootstrap.txt"
Line[14]="perl GetMLEDFEsOneHundredMillionBootstrap.pl ../../../../Results/ConstantPopSizeMouse/ForwardSims/HapLengths/ExitFileNoRecN ../../../../Results/MLEDFEs/ConstantMouseMLEOneHundredMillionBootstrap.txt"
Line[15]="perl GetMLEDFEsOneHundredMillionBootstrap.pl ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/ExitFileNoRecN ../../../../Results/MLEDFEs/PopExpansionBoykoMLEOneHundredMillionBootstrap.txt"
Line[16]="perl GetMLEDFEsOneHundredMillionBootstrap.pl ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/HapLengths/ExitFileNoRecN ../../../../Results/MLEDFEs/PopExpansionMouseMLEOneHundredMillionBootstrap.txt"
Line[17]="perl GetMLEDFEsBoykoPlusPos.pl ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/MixBoykoPositive/HapLengths/ExitFileNoRecCombinedN ../../../../Results/MLEDFEs/PopExpansionBoykoPositiveMLE.txt"

${Line[$SGE_TASK_ID]}
