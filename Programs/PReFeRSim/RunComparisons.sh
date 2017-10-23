Begin[1]="average_maf_out.run.1.num."
Begin[2]="dog_out.run.1.num."
Begin[3]="fixed_sites_out.run.1.num."
Begin[4]="full_out.run.1.num."
Begin[5]="gen_load_out.run.1.num."
Begin[6]="num_snp_out.run.1.num."
Begin[7]="s_out.run.1.num."
Begin[8]="s_weight_out.run.1.num."
Begin[9]="sfs_out.run.1.num."

Ending[1]=".N.18169.h.0.500000.F.0.000000.txt"
Ending[2]=".N.18169.h.0.500000.F.0.300000.txt"
Ending[3]=".N.18169.h.0.500000.F.0.000000.txt"
Ending[4]=".N.18169.h.0.500000.F.0.000000.txt"
Ending[5]=".N.18169.h.0.500000.F.0.000000.txt"
Ending[6]=".N.18169.h.0.500000.F.0.000000.txt"
Ending[7]=".N.18169.h.0.500000.F.0.000000.txt"
Ending[8]=".N.18169.h.0.500000.F.0.000000.txt"
Ending[9]=".N.18169.h.0.500000.F.0.000000.txt"
Ending[10]=".N.18169.h.0.500000.F.0.000000.txt"
Ending[12]=".N.18169.h.0.500000.F.0.300000.txt"
Ending[13]=".N.18169.h.0.500000.F.0.300000.txt"


NewFile[1]="average_maf_out.txt"
NewFile[2]="dog_out.txt"
NewFile[3]="fixed_sites_out.txt"
NewFile[4]="full_out.txt"
NewFile[5]="gen_load_out.txt"
NewFile[6]="num_snp_out.txt"
NewFile[7]="s_out.txt"
NewFile[8]="s_weight_out.txt"
NewFile[9]="sfs_out.txt"

for i in {1..9}
do
for j in {1..10}
do
File1="Test/run.1/"${Begin[$i]}$j${Ending[$j]}
File2="MiniTest/Output."$j.${NewFile[$i]}

echo $File1" "$File2
diff $File1 $File2
echo ""
done
done

for i in {1..9}
do
for j in {12..13}
do
File1="Test/run.1/"${Begin[$i]}$j${Ending[$j]}
File2="MiniTest/Output."$j.${NewFile[$i]}

echo $File1" "$File2
diff $File1 $File2
echo ""
done
done


diff MiniTest/AllTrajs.txt Test/run.1/AllTrajs.txt

