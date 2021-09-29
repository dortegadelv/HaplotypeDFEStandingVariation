
Directories[1]="/scratch/midway2/diegoortega/ConstantPopSizeBoyko/"
Directories[2]="/scratch/midway2/diegoortega/ConstantPopSizeMouse/"
Directories[3]="/scratch/midway2/diegoortega/PopExpansionBoyko/"
Directories[4]="/scratch/midway2/diegoortega/PopExpansionMouse/"

Files[1]="ConstantPopSizeBoyko"
Files[2]="ConstantPopSizeMouse"
Files[3]="PopExpansionBoyko"
Files[4]="PopExpansionMouse"

for i in {1..4}
do

AlphaFile=${Files[$i]}"Alpha.txt"
BetaFile=${Files[$i]}"Beta.txt"

awk '{print $3}' ${Directories[$i]}Output.*.MaxLL.txt | cut -c1-14 > $AlphaFile
awk '{print $2}' ${Directories[$i]}Output.*.MaxLL.txt | cut -c8-21 > $BetaFile

done

################################


Directories[1]="/scratch/midway2/diegoortega/ConstantPopSizeBoyko/"
Directories[2]="/scratch/midway2/diegoortega/ConstantPopSizeMouse/"
Directories[3]="/scratch/midway2/diegoortega/PopExpansionBoyko/"
Directories[4]="/scratch/midway2/diegoortega/PopExpansionMouse/"

Files[1]="ConstantPopSizeBoyko"
Files[2]="ConstantPopSizeMouse"
Files[3]="PopExpansionBoyko"
Files[4]="PopExpansionMouse"

for i in {1..4}
do

AlphaFile=${Files[$i]}"SmallAlpha.txt"
BetaFile=${Files[$i]}"SmallBeta.txt"

awk '{print $1,$2,$3,$4,$5,$6}' ${Directories[$i]}OutputSmall.*.MaxLL.txt | cut -f3 -d',' |  cut -f1 -d']'  > $AlphaFile
awk '{print $1,$2,$3,$4,$5,$6}' ${Directories[$i]}OutputSmall.*.MaxLL.txt | cut -f2 -d',' |  cut -f2 -d'[' > $BetaFile

done

