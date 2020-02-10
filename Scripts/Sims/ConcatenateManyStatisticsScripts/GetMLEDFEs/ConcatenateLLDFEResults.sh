for i in {1..500}
do

echo $i

paste -d "\t" ../../../../Results/ConstantPopSizeBoyko/ForwardSims/HapLengths/ExitFileNoRecN$i.txt ../../../../Results/ConstantPopSizeBoyko/ForwardSims/HapLengths/ExitFileNoRecSmallN$i.txt > ../../../../Results/ConstantPopSizeBoyko/ForwardSims/HapLengths/ExitFileNoRecCombinedN$i.txt

paste -d "\t" ../../../../Results/ConstantPopSizeMouse/ForwardSims/HapLengths/ExitFileNoRecN$i.txt ../../../../Results/ConstantPopSizeMouse/ForwardSims/HapLengths/ExitFileNoRecSmallN$i.txt > ../../../../Results/ConstantPopSizeMouse/ForwardSims/HapLengths/ExitFileNoRecCombinedN$i.txt

paste -d "\t" ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/ExitFileNoRecN$i.txt ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/ExitFileNoRecSmallN$i.txt > ../../../../Results/PopExpansionBoykoPlusPositive/ForwardSims/BoykoPart/HapLengths/ExitFileNoRecCombinedN$i.txt

paste -d "\t" ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/HapLengths/ExitFileNoRecN$i.txt ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/HapLengths/ExitFileNoRecSmallN$i.txt > ../../../../Results/PopExpansionMousePlusPositive/ForwardSims/MousePart/HapLengths/ExitFileNoRecCombinedN$i.txt

done

