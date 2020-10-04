# rm SingletonCount.txt
# touch SingletonCount.txt
# rm DoubletonCount.txt
# touch DoubletonCount.txt
for i in {101..200}
do
echo $i
time slim -d simnum=$i sim_test.slim
python tree_2_vcf_noploidyConstantPopSize.py
vcftools --vcf test_1_combined.vcf --freq --out Salele2.vcf
awk '{print $6}' Salele2.vcf.frq | awk -F ":" '{print $2}' | sort -g | uniq -c | head -n2 | tail -n1 >> SingletonCount.txt
awk '{print $6}' Salele2.vcf.frq | awk -F ":" '{print $2}' | sort -g | uniq -c | head -n3 | tail -n1 >> DoubletonCount.txt
done

