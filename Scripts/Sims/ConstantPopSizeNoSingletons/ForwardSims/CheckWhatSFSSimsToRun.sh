#!/bin/bash

FourNs[1]=0
FourNs[2]=50
FourNs[3]=100
FourNs[4]=-50
FourNs[5]=-100

Files[1]="ConstantSizeSFS_4Ns0.sh"
Files[2]="ConstantSizeSFS_4Ns50.sh"
Files[3]="ConstantSizeSFS_4Ns100.sh"
Files[4]="ConstantSizeSFS_4Ns-50.sh"
Files[5]="ConstantSizeSFS_4Ns-100.sh"


for k in {2..5}
do
for i in {1..500}
do
File="../../../../Results/ConstantPopSize/ForwardSims/4Ns_${FourNs[$k]}/OutputSFS."$i".full_out.txt"
if [ ! -f $File  ]; then

echo "sbatch --array=$i ${Files[$k]}"

sbatch --array=$i ${Files[$k]}

fi
done
done
